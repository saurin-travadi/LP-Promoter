//
//  Consumer.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Consumer.h"

@implementation Consumer{
    bool elementFound;
    NSMutableString *soapResults;
    
    NSString* _element;
}


-(void)getDataForElement:(NSString*)element Request:(NSMutableURLRequest *)req :(void (^)(id))Success :(void(^)(NSError *))Failure {
    
    _element=element;  
    
    _OnSuccess = [Success copy];
    _OnFailure = [Failure copy]; 
    
    [self performSelector:@selector(checkConnection) withObject:nil afterDelay:60];          //this is to check if server is not responding
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
    webData = [NSMutableData data];
}

-(void)checkConnection {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                      message:@"Server is not responding, Please check application settings in your iPhone Settings."
                                                     delegate:self
                                            cancelButtonTitle:@"Exit"
                                            otherButtonTitles:nil];
    [message show];
}

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response {
    [webData setLength: 0];
}

-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data {
    [webData appendData:data];
}

-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error {
    if(error.code==-1009){              //check for connectivity
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Exit" otherButtonTitles: nil];

        [alert show];
        return;
    }
    
    _OnFailure(error);
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    [self parse];
}

-(void)parse{
    if (xmlParser){
        xmlParser = nil;
    }
    
    soapResults = [[NSMutableString alloc] init];
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    
    NSString* str = [[NSString alloc] initWithData:webData encoding:NSStringEncodingConversionAllowLossy];
    NSLog(@"%@",str);
    
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];
}

-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict 
{
    if( [elementName isEqualToString:_element]){
        elementFound = YES;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkConnection) object:nil];     //first bit received to stop checking
    }
}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
{
    if (elementFound){
        [soapResults appendString: string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:_element]){
        _OnSuccess(soapResults);
    } 
}

- (void)missingBaseUrl
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                      message:@"The Base URL has not been set. Please assign a value in your iPhone Settings."
                                                     delegate:self
                                            cancelButtonTitle:@"Exit"
                                            otherButtonTitles:nil];
    [message show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Exit"])
    {
        exit(0);
    }
}

@end




