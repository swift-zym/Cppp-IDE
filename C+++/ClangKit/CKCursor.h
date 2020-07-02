// ClangKit

#import <Cocoa/Cocoa.h>
#import "../clang-c/Index.h"

/*!
 * @typedef         CKCursorKind
 * @abstract        Cursor kind
 */
typedef NSInteger CKCursorKind;

/*!
 * @var             CKCursorKindUnexposedDecl
 * @abstract        Cursor kind - Unexposed declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindUnexposedDecl;

/*!
 * @var             CKCursorKindStructDecl
 * @abstract        Cursor kind - Structure declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindStructDecl;

/*!
 * @var             CKCursorKindUnionDecl
 * @abstract        Cursor kind - Union declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindUnionDecl;

/*!
 * @var             CKCursorKindClassDecl
 * @abstract        Cursor kind - Class declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindClassDecl;

/*!
 * @var             CKCursorKindEnumDecl
 * @abstract        Cursor kind - Enumeration declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindEnumDecl;

/*!
 * @var             CKCursorKindFieldDecl
 * @abstract        Cursor kind - Field declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindFieldDecl;

/*!
 * @var             CKCursorKindEnumConstantDecl
 * @abstract        Cursor kind - Enumeration constant declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindEnumConstantDecl;

/*!
 * @var             CKCursorKindFunctionDecl
 * @abstract        Cursor kind - Function declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindFunctionDecl;

/*!
 * @var             CKCursorKindVarDecl
 * @abstract        Cursor kind - Variable declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindVarDecl;

/*!
 * @var             CKCursorKindParmDecl
 * @abstract        Cursor kind - Parameter declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindParmDecl;

/*!
 * @var             CKCursorKindObjCInterfaceDecl
 * @abstract        Cursor kind - Objective-C interface declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCInterfaceDecl;

/*!
 * @var             CKCursorKindObjCCategoryDecl
 * @abstract        Cursor kind - Objective-C category declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCCategoryDecl;

/*!
 * @var             CKCursorKindObjCProtocolDecl
 * @abstract        Cursor kind - Objective-C protocol declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCProtocolDecl;

/*!
 * @var             CKCursorKindObjCPropertyDecl
 * @abstract        Cursor kind - Objective-C property declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCPropertyDecl;

/*!
 * @var             CKCursorKindObjCIvarDecl
 * @abstract        Cursor kind - Objective-C instance variable declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCIvarDecl;

/*!
 * @var             CKCursorKindObjCInstanceMethodDecl
 * @abstract        Cursor kind - Objective-C instance method declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCInstanceMethodDecl;

/*!
 * @var             CKCursorKindObjCClassMethodDecl
 * @abstract        Cursor kind - Objective-C class method declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCClassMethodDecl;

/*!
 * @var             CKCursorKindObjCImplementationDecl
 * @abstract        Cursor kind - Objective-C implementation declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCImplementationDecl;

/*!
 * @var             CKCursorKindObjCCategoryImplDecl
 * @abstract        Cursor kind - Objective-C category implementation declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCCategoryImplDecl;

/*!
 * @var             CKCursorKindTypedefDecl
 * @abstract        Cursor kind - Type definition declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindTypedefDecl;

/*!
 * @var             CKCursorKindCXXMethod
 * @abstract        Cursor kind - C++ method
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXMethod;

/*!
 * @var             CKCursorKindNamespace
 * @abstract        Cursor kind - Namespace
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindNamespace;

/*!
 * @var             CKCursorKindLinkageSpec
 * @abstract        Cursor kind - Linkage specifier
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindLinkageSpec;

/*!
 * @var             CKCursorKindConstructor
 * @abstract        Cursor kind - Constructor
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindConstructor;

/*!
 * @var             CKCursorKindDestructor
 * @abstract        Cursor kind - Destructor
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindDestructor;

/*!
 * @var             CKCursorKindConversionFunction
 * @abstract        Cursor kind - Conversion function
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindConversionFunction;

/*!
 * @var             CKCursorKindTemplateTypeParameter
 * @abstract        Cursor kind - Template type parameter
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindTemplateTypeParameter;

/*!
 * @var             CKCursorKindNonTypeTemplateParameter
 * @abstract        Cursor kind - Non type template parameter
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindNonTypeTemplateParameter;

/*!
 * @var             CKCursorKindTemplateTemplateParameter
 * @abstract        Cursor kind - Template template parameter
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindTemplateTemplateParameter;

/*!
 * @var             CKCursorKindFunctionTemplate
 * @abstract        Cursor kind - Function template
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindFunctionTemplate;

/*!
 * @var             CKCursorKindClassTemplate
 * @abstract        Cursor kind - Class template
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindClassTemplate;

/*!
 * @var             CKCursorKindClassTemplatePartialSpecialization
 * @abstract        Cursor kind - Template partial specialization
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindClassTemplatePartialSpecialization;

/*!
 * @var             CKCursorKindNamespaceAlias
 * @abstract        Cursor kind - Namespace alias
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindNamespaceAlias;

/*!
 * @var             CKCursorKindUsingDirective
 * @abstract        Cursor kind - Using directive
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindUsingDirective;

/*!
 * @var             CKCursorKindUsingDeclaration
 * @abstract        Cursor kind - Using declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindUsingDeclaration;

/*!
 * @var             CKCursorKindTypeAliasDecl
 * @abstract        Cursor kind - Type alias declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindTypeAliasDecl;

/*!
 * @var             CKCursorKindObjCSynthesizeDecl
 * @abstract        Cursor kind - Objective-C @synthesize declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCSynthesizeDecl;

/*!
 * @var             CKCursorKindObjCDynamicDecl
 * @abstract        Cursor kind - Objective-C @dynamic
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCDynamicDecl;

/*!
 * @var             CKCursorKindCXXAccessSpecifier
 * @abstract        Cursor kind - C++ access specifier
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXAccessSpecifier;

/*!
 * @var             CKCursorKindFirstDecl
 * @abstract        Cursor kind - First declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindFirstDecl;

/*!
 * @var             CKCursorKindLastDecl
 * @abstract        Cursor kind - Last declaration
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindLastDecl;

/*!
 * @var             CKCursorKindFirstRef
 * @abstract        Cursor kind - First reference
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindFirstRef;

/*!
 * @var             CKCursorKindObjCSuperClassRef
 * @abstract        Cursor kind - Objective-C superclass reference
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCSuperClassRef;

/*!
 * @var             CKCursorKindObjCProtocolRef
 * @abstract        Cursor kind - Objective-C protocol reference
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCProtocolRef;

/*!
 * @var             CKCursorKindObjCClassRef
 * @abstract        Cursor kind - Objective-C class reference
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCClassRef;

/*!
 * @var             CKCursorKindTypeRef
 * @abstract        Cursor kind - Type reference
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindTypeRef;

/*!
 * @var             CKCursorKindCXXBaseSpecifier
 * @abstract        Cursor kind - C++ base specifier
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXBaseSpecifier;

/*!
 * @var             CKCursorKindTemplateRef
 * @abstract        Cursor kind - Template reference
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindTemplateRef;

/*!
 * @var             CKCursorKindNamespaceRef
 * @abstract        Cursor kind - Namespace reference
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindNamespaceRef;

/*!
 * @var             CKCursorKindMemberRef
 * @abstract        Cursor kind - Member reference
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindMemberRef;

/*!
 * @var             CKCursorKindLabelRef
 * @abstract        Cursor kind - Label reference
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindLabelRef;

/*!
 * @var             CKCursorKindOverloadedDeclRef
 * @abstract        Cursor kind - Overloaded declaration reference
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindOverloadedDeclRef;

/*!
 * @var             CKCursorKindVariableRef
 * @abstract        Cursor kind - Variable reference
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindVariableRef;

/*!
 * @var             CKCursorKindLastRef
 * @abstract        Cursor kind - Last reference
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindLastRef;

/*!
 * @var             CKCursorKindFirstInvalid
 * @abstract        Cursor kind - First invalid
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindFirstInvalid;

/*!
 * @var             CKCursorKindInvalidFile
 * @abstract        Cursor kind - Invalid file
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindInvalidFile;

/*!
 * @var             CKCursorKindNoDeclFound
 * @abstract        Cursor kind - Ne declaration found
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindNoDeclFound;

/*!
 * @var             CKCursorKindNotImplemented
 * @abstract        Cursor kind - Not implemented
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindNotImplemented;

/*!
 * @var             CKCursorKindInvalidCode
 * @abstract        Cursor kind - Invalid code
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindInvalidCode;

/*!
 * @var             CKCursorKindLastInvalid
 * @abstract        Cursor kind - Last invalid
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindLastInvalid;

/*!
 * @var             CKCursorKindFirstExpr
 * @abstract        Cursor kind - First expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindFirstExpr;

/*!
 * @var             CKCursorKindUnexposedExpr
 * @abstract        Cursor kind - Unexposed expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindUnexposedExpr;

/*!
 * @var             CKCursorKindDeclRefExpr
 * @abstract        Cursor kind - Declaration reference expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindDeclRefExpr;

/*!
 * @var             CKCursorKindMemberRefExpr
 * @abstract        Cursor kind - Member reference expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindMemberRefExpr;

/*!
 * @var             CKCursorKindCallExpr
 * @abstract        Cursor kind - Call expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCallExpr;

/*!
 * @var             CKCursorKindObjCMessageExpr
 * @abstract        Cursor kind - Objective-C message expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCMessageExpr;

/*!
 * @var             CKCursorKindBlockExpr
 * @abstract        Cursor kind - Block expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindBlockExpr;

/*!
 * @var             CKCursorKindIntegerLiteral
 * @abstract        Cursor kind - Integer literal
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindIntegerLiteral;

/*!
 * @var             CKCursorKindFloatingLiteral
 * @abstract        Cursor kind - Floating point literal
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindFloatingLiteral;

/*!
 * @var             CKCursorKindImaginaryLiteral
 * @abstract        Cursor kind - Imaginary number literal
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindImaginaryLiteral;

/*!
 * @var             CKCursorKindStringLiteral
 * @abstract        Cursor kind - String literal
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindStringLiteral;

/*!
 * @var             CKCursorKindCharacterLiteral
 * @abstract        Cursor kind - Character literal
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCharacterLiteral;

/*!
 * @var             CKCursorKindParenExpr
 * @abstract        Cursor kind - Parenthesis expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindParenExpr;

/*!
 * @var             CKCursorKindUnaryOperator
 * @abstract        Cursor kind - Unary operator
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindUnaryOperator;

/*!
 * @var             CKCursorKindArraySubscriptExpr
 * @abstract        Cursor kind - Subscript expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindArraySubscriptExpr;

/*!
 * @var             CKCursorKindBinaryOperator
 * @abstract        Cursor kind - Binary operator
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindBinaryOperator;

/*!
 * @var             CKCursorKindCompoundAssignOperator
 * @abstract        Cursor kind - Coumpound assignment operator
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCompoundAssignOperator;

/*!
 * @var             CKCursorKindConditionalOperator
 * @abstract        Cursor kind - Conditional operator
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindConditionalOperator;

/*!
 * @var             CKCursorKindCStyleCastExpr
 * @abstract        Cursor kind - C-style cast expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCStyleCastExpr;

/*!
 * @var             CKCursorKindCompoundLiteralExpr
 * @abstract        Cursor kind - Coumpound literal expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCompoundLiteralExpr;

/*!
 * @var             CKCursorKindInitListExpr
 * @abstract        Cursor kind - List initializer expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindInitListExpr;

/*!
 * @var             CKCursorKindAddrLabelExpr
 * @abstract        Cursor kind - Address label expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindAddrLabelExpr;

/*!
 * @var             CKCursorKindStmtExpr
 * @abstract        Cursor kind - Statement expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindStmtExpr;

/*!
 * @var             CKCursorKindGenericSelectionExpr
 * @abstract        Cursor kind - Generic selection expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindGenericSelectionExpr;

/*!
 * @var             CKCursorKindGNUNullExpr
 * @abstract        Cursor kind - GNU NULL expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindGNUNullExpr;

/*!
 * @var             CKCursorKindCXXStaticCastExpr
 * @abstract        Cursor kind - C++ static cast expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXStaticCastExpr;

/*!
 * @var             CKCursorKindCXXDynamicCastExpr
 * @abstract        Cursor kind - C++ dynamic cast expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXDynamicCastExpr;

/*!
 * @var             CKCursorKindCXXReinterpretCastExpr
 * @abstract        Cursor kind - C++ reinterpret cast expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXReinterpretCastExpr;

/*!
 * @var             CKCursorKindCXXConstCastExpr
 * @abstract        Cursor kind - C++ const cast expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXConstCastExpr;

/*!
 * @var             CKCursorKindCXXFunctionalCastExpr
 * @abstract        Cursor kind - C++ functional cast expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXFunctionalCastExpr;

/*!
 * @var             CKCursorKindCXXTypeidExpr
 * @abstract        Cursor kind - C++ typeid expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXTypeidExpr;

/*!
 * @var             CKCursorKindCXXBoolLiteralExpr
 * @abstract        Cursor kind - C++ bool literal expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXBoolLiteralExpr;

/*!
 * @var             CKCursorKindCXXNullPtrLiteralExpr
 * @abstract        Cursor kind - C++ nullptr literal  expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXNullPtrLiteralExpr;

/*!
 * @var             CKCursorKindCXXThisExpr
 * @abstract        Cursor kind - C++ this expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXThisExpr;

/*!
 * @var             CKCursorKindCXXThrowExpr
 * @abstract        Cursor kind - C++ throw expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXThrowExpr;

/*!
 * @var             CKCursorKindCXXNewExpr
 * @abstract        Cursor kind - C++ new expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXNewExpr;

/*!
 * @var             CKCursorKindCXXDeleteExpr
 * @abstract        Cursor kind - C++ delete expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXDeleteExpr;

/*!
 * @var             CKCursorKindUnaryExpr
 * @abstract        Cursor kind - Unary expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindUnaryExpr;

/*!
 * @var             CKCursorKindObjCStringLiteral
 * @abstract        Cursor kind - Objective-C string literal
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCStringLiteral;

/*!
 * @var             CKCursorKindObjCEncodeExpr
 * @abstract        Cursor kind - Objective-C encode expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCEncodeExpr;

/*!
 * @var             CKCursorKindObjCSelectorExpr
 * @abstract        Cursor kind - Objective-C @selector expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCSelectorExpr;

/*!
 * @var             CKCursorKindObjCProtocolExpr
 * @abstract        Cursor kind - Objective-C protocol expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCProtocolExpr;

/*!
 * @var             CKCursorKindObjCBridgedCastExpr
 * @abstract        Cursor kind - Objective-C bridged cast expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCBridgedCastExpr;

/*!
 * @var             CKCursorKindPackExpansionExpr
 * @abstract        Cursor kind - Pack expansion expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindPackExpansionExpr;

/*!
 * @var             CKCursorKindSizeOfPackExpr
 * @abstract        Cursor kind - Size of pack expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindSizeOfPackExpr;

/*!
 * @var             CKCursorKindLambdaExpr
 * @abstract        Cursor kind - Lambda expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindLambdaExpr;

/*!
 * @var             CKCursorKindObjCBoolLiteralExpr
 * @abstract        Cursor kind - Objective-C bool literal expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCBoolLiteralExpr;

/*!
 * @var             CKCursorKindLastExpr
 * @abstract        Cursor kind - Last expression
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindLastExpr;

/*!
 * @var             CKCursorKindFirstStmt
 * @abstract        Cursor kind - First statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindFirstStmt;

/*!
 * @var             CKCursorKindUnexposedStmt
 * @abstract        Cursor kind - Unexposed statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindUnexposedStmt;

/*!
 * @var             CKCursorKindLabelStmt
 * @abstract        Cursor kind - Label statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindLabelStmt;

/*!
 * @var             CKCursorKindCompoundStmt
 * @abstract        Cursor kind - Coumpound statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCompoundStmt;

/*!
 * @var             CKCursorKindCaseStmt
 * @abstract        Cursor kind - Case statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCaseStmt;

/*!
 * @var             CKCursorKindDefaultStmt
 * @abstract        Cursor kind - Default statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindDefaultStmt;

/*!
 * @var             CKCursorKindIfStmt
 * @abstract        Cursor kind - If statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindIfStmt;

/*!
 * @var             CKCursorKindSwitchStmt
 * @abstract        Cursor kind - Switch statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindSwitchStmt;

/*!
 * @var             CKCursorKindWhileStmt
 * @abstract        Cursor kind - While statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindWhileStmt;

/*!
 * @var             CKCursorKindDoStmt
 * @abstract        Cursor kind - Do statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindDoStmt;

/*!
 * @var             CKCursorKindForStmt
 * @abstract        Cursor kind - For statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindForStmt;

/*!
 * @var             CKCursorKindGotoStmt
 * @abstract        Cursor kind - Goto statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindGotoStmt;

/*!
 * @var             CKCursorKindIndirectGotoStmt
 * @abstract        Cursor kind - Indirect goto statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindIndirectGotoStmt;

/*!
 * @var             CKCursorKindContinueStmt
 * @abstract        Cursor kind - Continue statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindContinueStmt;

/*!
 * @var             CKCursorKindBreakStmt
 * @abstract        Cursor kind - Break statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindBreakStmt;

/*!
 * @var             CKCursorKindReturnStmt
 * @abstract        Cursor kind - Return statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindReturnStmt;

/*!
 * @var             CKCursorKindAsmStmt
 * @abstract        Cursor kind - Assembly statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindAsmStmt;

/*!
 * @var             CKCursorKindObjCAtTryStmt
 * @abstract        Cursor kind - Objective-C @try statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCAtTryStmt;

/*!
 * @var             CKCursorKindObjCAtCatchStmt
 * @abstract        Cursor kind - Objective-C @catch statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCAtCatchStmt;

/*!
 * @var             CKCursorKindObjCAtFinallyStmt
 * @abstract        Cursor kind - Objective-C @finally statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCAtFinallyStmt;

/*!
 * @var             CKCursorKindObjCAtThrowStmt
 * @abstract        Cursor kind - Objective-C @throw statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCAtThrowStmt;

/*!
 * @var             CKCursorKindObjCAtSynchronizedStmt
 * @abstract        Cursor kind - Objective-C @synchronized statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCAtSynchronizedStmt;

/*!
 * @var             CKCursorKindObjCAutoreleasePoolStmt
 * @abstract        Cursor kind - Objective-C @autoreleasepool statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCAutoreleasePoolStmt;

/*!
 * @var             CKCursorKindObjCForCollectionStmt
 * @abstract        Cursor kind - Objective-C for collection statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindObjCForCollectionStmt;

/*!
 * @var             CKCursorKindCXXCatchStmt
 * @abstract        Cursor kind - C++ catch statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXCatchStmt;

/*!
 * @var             CKCursorKindCXXTryStmt
 * @abstract        Cursor kind - C++ try statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXTryStmt;

/*!
 * @var             CKCursorKindCXXForRangeStmt
 * @abstract        Cursor kind - C++ for range statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXForRangeStmt;

/*!
 * @var             CKCursorKindSEHTryStmt
 * @abstract        Cursor kind - SEH try statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindSEHTryStmt;

/*!
 * @var             CKCursorKindSEHExceptStmt
 * @abstract        Cursor kind - SEH except statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindSEHExceptStmt;

/*!
 * @var             CKCursorKindSEHFinallyStmt
 * @abstract        Cursor kind - SEH finally statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindSEHFinallyStmt;

/*!
 * @var             CKCursorKindMSAsmStmt
 * @abstract        Cursor kind - MS assembly statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindMSAsmStmt;

/*!
 * @var             CKCursorKindNullStmt
 * @abstract        Cursor kind - NULL statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindNullStmt;

/*!
 * @var             CKCursorKindDeclStmt
 * @abstract        Cursor kind - Declaration statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindDeclStmt;

/*!
 * @var             CKCursorKindLastStmt
 * @abstract        Cursor kind - Last statement
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindLastStmt;

/*!
 * @var             CKCursorKindTranslationUnit
 * @abstract        Cursor kind - Translation unit
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindTranslationUnit;

/*!
 * @var             CKCursorKindFirstAttr
 * @abstract        Cursor kind - First attribute
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindFirstAttr;

/*!
 * @var             CKCursorKindUnexposedAttr
 * @abstract        Cursor kind - Unexposed attribute
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindUnexposedAttr;

/*!
 * @var             CKCursorKindIBActionAttr
 * @abstract        Cursor kind - IBAction attribute
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindIBActionAttr;

/*!
 * @var             CKCursorKindIBActionAttr
 * @abstract        Cursor kind - IBOutlet attribute
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindIBOutletAttr;

/*!
 * @var             CKCursorKindIBOutletCollectionAttr
 * @abstract        Cursor kind - IBOutlet collection attribute
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindIBOutletCollectionAttr;

/*!
 * @var             CKCursorKindCXXFinalAttr
 * @abstract        Cursor kind - C++ final attribute
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXFinalAttr;

/*!
 * @var             CKCursorKindCXXOverrideAttr
 * @abstract        Cursor kind - C++ override attribute
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindCXXOverrideAttr;

/*!
 * @var             CKCursorKindAnnotateAttr
 * @abstract        Cursor kind - Annotate attribute
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindAnnotateAttr;

/*!
 * @var             CKCursorKindAsmLabelAttr
 * @abstract        Cursor kind - Assembly label attribute
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindAsmLabelAttr;

/*!
 * @var             CKCursorKindLastAttr
 * @abstract        Cursor kind - Last attribute
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindLastAttr;

/*!
 * @var             CKCursorKindPreprocessingDirective
 * @abstract        Cursor kind - Preprocessing directive
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindPreprocessingDirective;

/*!
 * @var             CKCursorKindMacroDefinition
 * @abstract        Cursor kind - Macro definition
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindMacroDefinition;

/*!
 * @var             CKCursorKindMacroExpansion
 * @abstract        Cursor kind - Macro expansion
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindMacroExpansion;

/*!
 * @var             CKCursorKindMacroInstantiation
 * @abstract        Cursor kind - Macro instantiation
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindMacroInstantiation;

/*!
 * @var             CKCursorKindInclusionDirective
 * @abstract        Cursor kind - Includion directive
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindInclusionDirective;

/*!
 * @var             CKCursorKindFirstPreprocessing
 * @abstract        Cursor kind - First preprocessing
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindFirstPreprocessing;

/*!
 * @var             CKCursorKindLastPreprocessing
 * @abstract        Cursor kind - Last proprocessing
 */
FOUNDATION_EXPORT CKCursorKind CKCursorKindLastPreprocessing;

@class CKTranslationUnit;
@class CKSourceLocation;

/*!
 * @class           CKCursor
 * @abstract        Cursor class
 */
@interface CKCursor : NSObject
{
@protected
    
    CKCursorKind       _kind;
    NSString         * _displayName;
    NSString         * _kindSpelling;
    CKCursor         * _definition;
    CKCursor         * _semanticParent;
    CKCursor         * _lexicalParent;
    CKCursor         * _canonical;
    CKCursor         * _referenced;
    CKSourceLocation * _location;
    BOOL               _isDefinition;
    BOOL               _isDeclaration;
    BOOL               _isReference;
    BOOL               _isPreprocessing;
    BOOL               _isExpression;
    BOOL               _isAttribute;
    BOOL               _isInvalid;
    BOOL               _isStatement;
    BOOL               _isTranslationUnit;
    BOOL               _isUnexposed;
    void             * _cxCursorPointer;
}

/*!
 * @property        kind
 * @abstract        The cursor kind
 */
@property( atomic, readonly ) CKCursorKind kind;

/*!
 * @property        displayName
 * @abstract        The cursor's display name
 */
@property( atomic, readonly ) NSString * displayName;

/*!
 * @property        kindSpelling
 * @abstract        The cursor kind's spelling
 */
@property( atomic, readonly ) NSString * kindSpelling;

/*!
 * @property        definition
 * @abstract        The cursor containing the cursor's definition
 */
@property( atomic, readonly ) CKCursor * definition;

/*!
 * @property        semanticParent
 * @abstract        The cursor containing the cursor's semantic parent
 */
@property( atomic, readonly ) CKCursor * semanticParent;

/*!
 * @property        lexicalParent
 * @abstract        The cursor containing the cursor's lexical parent
 */
@property( atomic, readonly ) CKCursor * lexicalParent;

/*!
 * @property        canonical
 * @abstract        Canonical cursor
 */
@property( atomic, readonly ) CKCursor * canonical;

/*!
 * @property        referenced
 * @abstract        Referenced cursor
 */
@property( atomic, readonly ) CKCursor * referenced;

/*!
 * @property        location
 * @abstract        The cursor's source location
 */
@property( atomic, readonly ) CKSourceLocation * location;

/*!
 * @property        isDefinition
 * @abstract        Whether the cursor is a definition of rot
 */
@property( atomic, readonly ) BOOL isDefinition;

/*!
 * @property        isDeclaration
 * @abstract        Whether the cursor is a declaration of rot
 */
@property( atomic, readonly ) BOOL isDeclaration;

/*!
 * @property        isReference
 * @abstract        Whether the cursor is a reference of rot
 */
@property( atomic, readonly ) BOOL isReference;

/*!
 * @property        isPreprocessing
 * @abstract        Whether the cursor is preprocessing of rot
 */
@property( atomic, readonly ) BOOL isPreprocessing;

/*!
 * @property        isExpression
 * @abstract        Whether the cursor is an expression of rot
 */
@property( atomic, readonly ) BOOL isExpression;

/*!
 * @property        isAttribute
 * @abstract        Whether the cursor is an attribute of rot
 */
@property( atomic, readonly ) BOOL isAttribute;

/*!
 * @property        isInvalid
 * @abstract        Whether the cursor is invalid of rot
 */
@property( atomic, readonly ) BOOL isInvalid;

/*!
 * @property        isStatement
 * @abstract        Whether the cursor is a statement of rot
 */
@property( atomic, readonly ) BOOL isStatement;

/*!
 * @property        isTranslationUnit
 * @abstract        Whether the cursor is a translation unit of rot
 */
@property( atomic, readonly ) BOOL isTranslationUnit;

/*!
 * @property        isUnexposed
 * @abstract        Whether the cursor is unexposed of rot
 */
@property( atomic, readonly ) BOOL isUnexposed;

/*!
 * @method          cursorWithLocation:translationUnit:
 * @abstract        Gets a cursor from a location and a translation unit
 * @param           location        The source location
 * @param           translationUnit The translation unit
 * @return          The cursor object
 * @discussion      The returned object is autoreleased.
 */
+ ( id )cursorWithLocation: ( CKSourceLocation * )location translationUnit: ( CKTranslationUnit * )translationUnit;

/*!
 * @method          initWithLocation:translationUnit:
 * @abstract        Initializes a cursor with a location and a translation unit
 * @param           location        The source location
 * @param           translationUnit The translation unit
 * @return          The cursor object
 */
- ( id )initWithLocation: ( CKSourceLocation * )location translationUnit: ( CKTranslationUnit * )translationUnit;

@end
