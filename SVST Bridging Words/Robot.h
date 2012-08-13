#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface Robot : NSObject {
	NSString *word;
    NSUInteger wordID;
    NSString *wordMean;
	NSString *content;
	BOOL isDetailViewHydrated;
    NSInteger playerID;
}
@property (nonatomic, readwrite) NSInteger playerID;
@property (nonatomic,copy) NSString *wordMean;
@property (nonatomic, copy) NSString *word;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, readwrite) BOOL isDetailViewHydrated;

//Static methods.
+ (NSMutableArray *) getInitialDataToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;
//Instance methods.
- (void) hydrateDetailViewData:(NSString *) wordSelected;
- (NSMutableArray *) detailViewWithCharater:(char) charBegin;
-(void) insertWordToRobot:(NSString* ) wordInsert;
@end
