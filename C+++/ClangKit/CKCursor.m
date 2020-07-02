// ClangKit
 


#import "CKCursor.h"
#import "CKCursor+Private.h"
#import "CKSourceLocation.h"
#import "CKTranslationUnit.h"

CKCursorKind CKCursorKindUnexposedDecl                      = CXCursor_UnexposedDecl;
CKCursorKind CKCursorKindStructDecl                         = CXCursor_StructDecl;
CKCursorKind CKCursorKindUnionDecl                          = CXCursor_UnionDecl;
CKCursorKind CKCursorKindClassDecl                          = CXCursor_ClassDecl;
CKCursorKind CKCursorKindEnumDecl                           = CXCursor_EnumDecl;
CKCursorKind CKCursorKindFieldDecl                          = CXCursor_FieldDecl;
CKCursorKind CKCursorKindEnumConstantDecl                   = CXCursor_EnumConstantDecl;
CKCursorKind CKCursorKindFunctionDecl                       = CXCursor_FunctionDecl;
CKCursorKind CKCursorKindVarDecl                            = CXCursor_VarDecl;
CKCursorKind CKCursorKindParmDecl                           = CXCursor_ParmDecl;
CKCursorKind CKCursorKindObjCInterfaceDecl                  = CXCursor_ObjCInterfaceDecl;
CKCursorKind CKCursorKindObjCCategoryDecl                   = CXCursor_ObjCCategoryDecl;
CKCursorKind CKCursorKindObjCProtocolDecl                   = CXCursor_ObjCProtocolDecl;
CKCursorKind CKCursorKindObjCPropertyDecl                   = CXCursor_ObjCPropertyDecl;
CKCursorKind CKCursorKindObjCIvarDecl                       = CXCursor_ObjCIvarDecl;
CKCursorKind CKCursorKindObjCInstanceMethodDecl             = CXCursor_ObjCInstanceMethodDecl;
CKCursorKind CKCursorKindObjCClassMethodDecl                = CXCursor_ObjCClassMethodDecl;
CKCursorKind CKCursorKindObjCImplementationDecl             = CXCursor_ObjCImplementationDecl;
CKCursorKind CKCursorKindObjCCategoryImplDecl               = CXCursor_ObjCCategoryImplDecl;
CKCursorKind CKCursorKindTypedefDecl                        = CXCursor_TypedefDecl;
CKCursorKind CKCursorKindCXXMethod                          = CXCursor_CXXMethod;
CKCursorKind CKCursorKindNamespace                          = CXCursor_Namespace;
CKCursorKind CKCursorKindLinkageSpec                        = CXCursor_LinkageSpec;
CKCursorKind CKCursorKindConstructor                        = CXCursor_Constructor;
CKCursorKind CKCursorKindDestructor                         = CXCursor_Destructor;
CKCursorKind CKCursorKindConversionFunction                 = CXCursor_ConversionFunction;
CKCursorKind CKCursorKindTemplateTypeParameter              = CXCursor_TemplateTypeParameter;
CKCursorKind CKCursorKindNonTypeTemplateParameter           = CXCursor_NonTypeTemplateParameter;
CKCursorKind CKCursorKindTemplateTemplateParameter          = CXCursor_TemplateTemplateParameter;
CKCursorKind CKCursorKindFunctionTemplate                   = CXCursor_FunctionTemplate;
CKCursorKind CKCursorKindClassTemplate                      = CXCursor_ClassTemplate;
CKCursorKind CKCursorKindClassTemplatePartialSpecialization = CXCursor_ClassTemplatePartialSpecialization;
CKCursorKind CKCursorKindNamespaceAlias                     = CXCursor_NamespaceAlias;
CKCursorKind CKCursorKindUsingDirective                     = CXCursor_UsingDirective;
CKCursorKind CKCursorKindUsingDeclaration                   = CXCursor_UsingDeclaration;
CKCursorKind CKCursorKindTypeAliasDecl                      = CXCursor_TypeAliasDecl;
CKCursorKind CKCursorKindObjCSynthesizeDecl                 = CXCursor_ObjCSynthesizeDecl;
CKCursorKind CKCursorKindObjCDynamicDecl                    = CXCursor_ObjCDynamicDecl;
CKCursorKind CKCursorKindCXXAccessSpecifier                 = CXCursor_CXXAccessSpecifier;
CKCursorKind CKCursorKindFirstDecl                          = CXCursor_FirstDecl;
CKCursorKind CKCursorKindLastDecl                           = CXCursor_LastDecl;
CKCursorKind CKCursorKindFirstRef                           = CXCursor_FirstRef;
CKCursorKind CKCursorKindObjCSuperClassRef                  = CXCursor_ObjCSuperClassRef;
CKCursorKind CKCursorKindObjCProtocolRef                    = CXCursor_ObjCProtocolRef;
CKCursorKind CKCursorKindObjCClassRef                       = CXCursor_ObjCClassRef;
CKCursorKind CKCursorKindTypeRef                            = CXCursor_TypeRef;
CKCursorKind CKCursorKindCXXBaseSpecifier                   = CXCursor_CXXBaseSpecifier;
CKCursorKind CKCursorKindTemplateRef                        = CXCursor_TemplateRef;
CKCursorKind CKCursorKindNamespaceRef                       = CXCursor_NamespaceRef;
CKCursorKind CKCursorKindMemberRef                          = CXCursor_MemberRef;
CKCursorKind CKCursorKindLabelRef                           = CXCursor_LabelRef;
CKCursorKind CKCursorKindOverloadedDeclRef                  = CXCursor_OverloadedDeclRef;
CKCursorKind CKCursorKindVariableRef                        = CXCursor_VariableRef;
CKCursorKind CKCursorKindLastRef                            = CXCursor_LastRef;
CKCursorKind CKCursorKindFirstInvalid                       = CXCursor_FirstInvalid;
CKCursorKind CKCursorKindInvalidFile                        = CXCursor_InvalidFile;
CKCursorKind CKCursorKindNoDeclFound                        = CXCursor_NoDeclFound;
CKCursorKind CKCursorKindNotImplemented                     = CXCursor_NotImplemented;
CKCursorKind CKCursorKindInvalidCode                        = CXCursor_InvalidCode;
CKCursorKind CKCursorKindLastInvalid                        = CXCursor_LastInvalid;
CKCursorKind CKCursorKindFirstExpr                          = CXCursor_FirstExpr;
CKCursorKind CKCursorKindUnexposedExpr                      = CXCursor_UnexposedExpr;
CKCursorKind CKCursorKindDeclRefExpr                        = CXCursor_DeclRefExpr;
CKCursorKind CKCursorKindMemberRefExpr                      = CXCursor_MemberRefExpr;
CKCursorKind CKCursorKindCallExpr                           = CXCursor_CallExpr;
CKCursorKind CKCursorKindObjCMessageExpr                    = CXCursor_ObjCMessageExpr;
CKCursorKind CKCursorKindBlockExpr                          = CXCursor_BlockExpr;
CKCursorKind CKCursorKindIntegerLiteral                     = CXCursor_IntegerLiteral;
CKCursorKind CKCursorKindFloatingLiteral                    = CXCursor_FloatingLiteral;
CKCursorKind CKCursorKindImaginaryLiteral                   = CXCursor_ImaginaryLiteral;
CKCursorKind CKCursorKindStringLiteral                      = CXCursor_StringLiteral;
CKCursorKind CKCursorKindCharacterLiteral                   = CXCursor_CharacterLiteral;
CKCursorKind CKCursorKindParenExpr                          = CXCursor_ParenExpr;
CKCursorKind CKCursorKindUnaryOperator                      = CXCursor_UnaryOperator;
CKCursorKind CKCursorKindArraySubscriptExpr                 = CXCursor_ArraySubscriptExpr;
CKCursorKind CKCursorKindBinaryOperator                     = CXCursor_BinaryOperator;
CKCursorKind CKCursorKindCompoundAssignOperator             = CXCursor_CompoundAssignOperator;
CKCursorKind CKCursorKindConditionalOperator                = CXCursor_ConditionalOperator;
CKCursorKind CKCursorKindCStyleCastExpr                     = CXCursor_CStyleCastExpr;
CKCursorKind CKCursorKindCompoundLiteralExpr                = CXCursor_CompoundLiteralExpr;
CKCursorKind CKCursorKindInitListExpr                       = CXCursor_InitListExpr;
CKCursorKind CKCursorKindAddrLabelExpr                      = CXCursor_AddrLabelExpr;
CKCursorKind CKCursorKindStmtExpr                           = CXCursor_StmtExpr;
CKCursorKind CKCursorKindGenericSelectionExpr               = CXCursor_GenericSelectionExpr;
CKCursorKind CKCursorKindGNUNullExpr                        = CXCursor_GNUNullExpr;
CKCursorKind CKCursorKindCXXStaticCastExpr                  = CXCursor_CXXStaticCastExpr;
CKCursorKind CKCursorKindCXXDynamicCastExpr                 = CXCursor_CXXDynamicCastExpr;
CKCursorKind CKCursorKindCXXReinterpretCastExpr             = CXCursor_CXXReinterpretCastExpr;
CKCursorKind CKCursorKindCXXConstCastExpr                   = CXCursor_CXXConstCastExpr;
CKCursorKind CKCursorKindCXXFunctionalCastExpr              = CXCursor_CXXFunctionalCastExpr;
CKCursorKind CKCursorKindCXXTypeidExpr                      = CXCursor_CXXTypeidExpr;
CKCursorKind CKCursorKindCXXBoolLiteralExpr                 = CXCursor_CXXBoolLiteralExpr;
CKCursorKind CKCursorKindCXXNullPtrLiteralExpr              = CXCursor_CXXNullPtrLiteralExpr;
CKCursorKind CKCursorKindCXXThisExpr                        = CXCursor_CXXThisExpr;
CKCursorKind CKCursorKindCXXThrowExpr                       = CXCursor_CXXThrowExpr;
CKCursorKind CKCursorKindCXXNewExpr                         = CXCursor_CXXNewExpr;
CKCursorKind CKCursorKindCXXDeleteExpr                      = CXCursor_CXXDeleteExpr;
CKCursorKind CKCursorKindUnaryExpr                          = CXCursor_UnaryExpr;
CKCursorKind CKCursorKindObjCStringLiteral                  = CXCursor_ObjCStringLiteral;
CKCursorKind CKCursorKindObjCEncodeExpr                     = CXCursor_ObjCEncodeExpr;
CKCursorKind CKCursorKindObjCSelectorExpr                   = CXCursor_ObjCSelectorExpr;
CKCursorKind CKCursorKindObjCProtocolExpr                   = CXCursor_ObjCProtocolExpr;
CKCursorKind CKCursorKindObjCBridgedCastExpr                = CXCursor_ObjCBridgedCastExpr;
CKCursorKind CKCursorKindPackExpansionExpr                  = CXCursor_PackExpansionExpr;
CKCursorKind CKCursorKindSizeOfPackExpr                     = CXCursor_SizeOfPackExpr;
CKCursorKind CKCursorKindLambdaExpr                         = CXCursor_LambdaExpr;
CKCursorKind CKCursorKindObjCBoolLiteralExpr                = CXCursor_ObjCBoolLiteralExpr;
CKCursorKind CKCursorKindLastExpr                           = CXCursor_LastExpr;
CKCursorKind CKCursorKindFirstStmt                          = CXCursor_FirstStmt;
CKCursorKind CKCursorKindUnexposedStmt                      = CXCursor_UnexposedStmt;
CKCursorKind CKCursorKindLabelStmt                          = CXCursor_LabelStmt;
CKCursorKind CKCursorKindCompoundStmt                       = CXCursor_CompoundStmt;
CKCursorKind CKCursorKindCaseStmt                           = CXCursor_CaseStmt;
CKCursorKind CKCursorKindDefaultStmt                        = CXCursor_DefaultStmt;
CKCursorKind CKCursorKindIfStmt                             = CXCursor_IfStmt;
CKCursorKind CKCursorKindSwitchStmt                         = CXCursor_SwitchStmt;
CKCursorKind CKCursorKindWhileStmt                          = CXCursor_WhileStmt;
CKCursorKind CKCursorKindDoStmt                             = CXCursor_DoStmt;
CKCursorKind CKCursorKindForStmt                            = CXCursor_ForStmt;
CKCursorKind CKCursorKindGotoStmt                           = CXCursor_GotoStmt;
CKCursorKind CKCursorKindIndirectGotoStmt                   = CXCursor_IndirectGotoStmt;
CKCursorKind CKCursorKindContinueStmt                       = CXCursor_ContinueStmt;
CKCursorKind CKCursorKindBreakStmt                          = CXCursor_BreakStmt;
CKCursorKind CKCursorKindReturnStmt                         = CXCursor_ReturnStmt;
CKCursorKind CKCursorKindAsmStmt                            = CXCursor_AsmStmt;
CKCursorKind CKCursorKindObjCAtTryStmt                      = CXCursor_ObjCAtTryStmt;
CKCursorKind CKCursorKindObjCAtCatchStmt                    = CXCursor_ObjCAtCatchStmt;
CKCursorKind CKCursorKindObjCAtFinallyStmt                  = CXCursor_ObjCAtFinallyStmt;
CKCursorKind CKCursorKindObjCAtThrowStmt                    = CXCursor_ObjCAtThrowStmt;
CKCursorKind CKCursorKindObjCAtSynchronizedStmt             = CXCursor_ObjCAtSynchronizedStmt;
CKCursorKind CKCursorKindObjCAutoreleasePoolStmt            = CXCursor_ObjCAutoreleasePoolStmt;
CKCursorKind CKCursorKindObjCForCollectionStmt              = CXCursor_ObjCForCollectionStmt;
CKCursorKind CKCursorKindCXXCatchStmt                       = CXCursor_CXXCatchStmt;
CKCursorKind CKCursorKindCXXTryStmt                         = CXCursor_CXXTryStmt;
CKCursorKind CKCursorKindCXXForRangeStmt                    = CXCursor_CXXForRangeStmt;
CKCursorKind CKCursorKindSEHTryStmt                         = CXCursor_SEHTryStmt;
CKCursorKind CKCursorKindSEHExceptStmt                      = CXCursor_SEHExceptStmt;
CKCursorKind CKCursorKindSEHFinallyStmt                     = CXCursor_SEHFinallyStmt;
CKCursorKind CKCursorKindMSAsmStmt                          = CXCursor_MSAsmStmt;
CKCursorKind CKCursorKindNullStmt                           = CXCursor_NullStmt;
CKCursorKind CKCursorKindDeclStmt                           = CXCursor_DeclStmt;
CKCursorKind CKCursorKindLastStmt                           = CXCursor_LastStmt;
CKCursorKind CKCursorKindTranslationUnit                    = CXCursor_TranslationUnit;
CKCursorKind CKCursorKindFirstAttr                          = CXCursor_FirstAttr;
CKCursorKind CKCursorKindUnexposedAttr                      = CXCursor_UnexposedAttr;
CKCursorKind CKCursorKindIBActionAttr                       = CXCursor_IBActionAttr;
CKCursorKind CKCursorKindIBOutletAttr                       = CXCursor_IBOutletAttr;
CKCursorKind CKCursorKindIBOutletCollectionAttr             = CXCursor_IBOutletCollectionAttr;
CKCursorKind CKCursorKindCXXFinalAttr                       = CXCursor_CXXFinalAttr;
CKCursorKind CKCursorKindCXXOverrideAttr                    = CXCursor_CXXOverrideAttr;
CKCursorKind CKCursorKindAnnotateAttr                       = CXCursor_AnnotateAttr;
CKCursorKind CKCursorKindAsmLabelAttr                       = CXCursor_AsmLabelAttr;
CKCursorKind CKCursorKindLastAttr                           = CXCursor_LastAttr;
CKCursorKind CKCursorKindPreprocessingDirective             = CXCursor_PreprocessingDirective;
CKCursorKind CKCursorKindMacroDefinition                    = CXCursor_MacroDefinition;
CKCursorKind CKCursorKindMacroExpansion                     = CXCursor_MacroExpansion;
CKCursorKind CKCursorKindMacroInstantiation                 = CXCursor_MacroInstantiation;
CKCursorKind CKCursorKindInclusionDirective                 = CXCursor_InclusionDirective;
CKCursorKind CKCursorKindFirstPreprocessing                 = CXCursor_FirstPreprocessing;
CKCursorKind CKCursorKindLastPreprocessing                  = CXCursor_LastPreprocessing;

@implementation CKCursor

@synthesize kind                = _kind;
@synthesize displayName         = _displayName;
@synthesize kindSpelling        = _kindSpelling;
@synthesize location            = _location;
@synthesize isDefinition        = _isDefinition;
@synthesize isDeclaration       = _isDeclaration;
@synthesize isReference         = _isReference;
@synthesize isPreprocessing     = _isPreprocessing;
@synthesize isExpression        = _isExpression;
@synthesize isAttribute         = _isAttribute;
@synthesize isInvalid           = _isInvalid;
@synthesize isStatement         = _isStatement;
@synthesize isTranslationUnit   = _isTranslationUnit;
@synthesize isUnexposed         = _isUnexposed;

+ ( id )cursorWithLocation: ( CKSourceLocation * )location translationUnit: ( CKTranslationUnit * )translationUnit
{
    return [ [ [ self alloc ] initWithLocation: location translationUnit: translationUnit ] autorelease ];
}

- ( id )initWithLocation: ( CKSourceLocation * )location translationUnit: ( CKTranslationUnit * )translationUnit
{
    CXSourceLocation sourceLocation;
    CXCursor         cursor;
    
    sourceLocation.ptr_data[ 0 ] = location.ptrData1;
    sourceLocation.ptr_data[ 1 ] = location.ptrData2;
    sourceLocation.int_data      = location.intData;
    
    cursor = clang_getCursor( translationUnit.cxTranslationUnit, sourceLocation );
    
    return [ self initWithCXCursor: cursor ];
}

- ( void )dealloc
{
    [ _displayName      release ];
    [ _definition       release ];
    [ _lexicalParent    release ];
    [ _semanticParent   release ];
    [ _canonical        release ];
    [ _referenced       release ];
    [ _location         release ];
    
	free( _cxCursorPointer );
    
    [ super dealloc ];
}

- ( NSString * )description
{
    NSString * description;
    
    description = [ super description ];
    description = [ description stringByAppendingFormat: @": %@ - %@", self.kindSpelling, self.displayName ];
    
    return description;
}

- ( CKCursor * )referenced
{
    CXCursor cursor;
    CXCursor referenced;
    
    if( _referenced == nil && _cxCursorPointer != NULL && _isDefinition == NO )
    {
        memcpy( &cursor, _cxCursorPointer, sizeof( CXCursor ) );
        
        referenced  = clang_getCursorReferenced( cursor );
        
        if( clang_equalCursors( cursor, referenced ) == 0 )
        {
            _referenced = [ [ [ self class ] alloc ] initWithCXCursor: referenced ];
        }
    }
    
    return _referenced;
}

- ( CKCursor * )definition
{
    CXCursor cursor;
    CXCursor definition;
    
    if( _definition == nil && _cxCursorPointer != NULL && _isDefinition == NO )
    {
        memcpy( &cursor, _cxCursorPointer, sizeof( CXCursor ) );
        
        definition  = clang_getCursorDefinition( cursor );
        
        if( clang_Cursor_isNull( definition ) == 0 )
        _definition = [ [ [ self class ] alloc ] initWithCXCursor: definition ];
    }
    
    return _definition;
}

- ( CKCursor * )canonical
{
    CXCursor cursor;
    CXCursor canonical;
    
    if( _canonical == nil && _cxCursorPointer != NULL )
    {
        memcpy( &cursor, _cxCursorPointer, sizeof( CXCursor ) );
        
        canonical  = clang_getCanonicalCursor( cursor );
        _canonical = [ [ [ self class ] alloc ] initWithCXCursor: canonical ];
    }
    
    return _canonical;
}

- ( CKCursor * )lexicalParent
{
    CXCursor cursor;
    CXCursor lexicalParent;
    
    if( _referenced == nil && _cxCursorPointer != NULL )
    {
        memcpy( &cursor, _cxCursorPointer, sizeof( CXCursor ) );
        
        lexicalParent  = clang_getCursorReferenced( cursor );
        _lexicalParent = [ [ [ self class ] alloc ] initWithCXCursor: lexicalParent ];
    }
    
    return _referenced;
}

- ( CKCursor * )semanticParent
{
    CXCursor cursor;
    CXCursor semanticParent;
    
    if( _semanticParent == nil && _cxCursorPointer != NULL )
    {
        memcpy( &cursor, _cxCursorPointer, sizeof( CXCursor ) );
        
        semanticParent  = clang_getCursorReferenced( cursor );
        _semanticParent = [ [ [ self class ] alloc ] initWithCXCursor: semanticParent ];
    }
    
    return _semanticParent;
}

@end
