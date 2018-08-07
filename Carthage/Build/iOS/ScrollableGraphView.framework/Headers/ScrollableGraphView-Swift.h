// Generated by Apple Swift version 4.1.2 (swiftlang-902.0.54 clang-902.0.39.2)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR __attribute__((enum_extensibility(open)))
# else
#  define SWIFT_ENUM_ATTR
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
@import UIKit;
@import CoreGraphics;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="ScrollableGraphView",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif

typedef SWIFT_ENUM(NSInteger, ReferenceLinePositioningType) {
  ReferenceLinePositioningTypeRelative = 0,
  ReferenceLinePositioningTypeAbsolute = 1,
};

@class UIColor;
@class NSCoder;

SWIFT_CLASS("_TtC19ScrollableGraphView19ScrollableGraphView")
@interface ScrollableGraphView : UIScrollView <UIScrollViewDelegate>
/// The background colour for the entire graph view, not just the plotted graph.
@property (nonatomic, strong) UIColor * _Nonnull backgroundFillColor;
/// How far the “maximum” reference line is from the top of the view’s frame. In points.
@property (nonatomic) CGFloat topMargin;
/// How far the “minimum” reference line is from the bottom of the view’s frame. In points.
@property (nonatomic) CGFloat bottomMargin;
/// How far the first point on the graph should be placed from the left hand side of the view.
@property (nonatomic) CGFloat leftmostPointPadding;
/// How far the final point on the graph should be placed from the right hand side of the view.
@property (nonatomic) CGFloat rightmostPointPadding;
/// How much space should be between each data point.
@property (nonatomic) CGFloat dataPointSpacing;
/// Forces the graph’s minimum to always be zero. Used in conjunction with shouldAutomaticallyDetectRange or shouldAdaptRange, if you want to force the minimum to stay at 0 rather than the detected minimum.
@property (nonatomic) BOOL shouldRangeAlwaysStartAtZero;
/// The minimum value for the y-axis. This is ignored when shouldAutomaticallyDetectRange or shouldAdaptRange = true
@property (nonatomic) double rangeMin;
/// The maximum value for the y-axis. This is ignored when shouldAutomaticallyDetectRange or shouldAdaptRange = true
@property (nonatomic) double rangeMax;
/// Whether or not the y-axis’ range should adapt to the points that are visible on screen. This means if there are only 5 points visible on screen at any given time, the maximum on the y-axis will be the maximum of those 5 points. This is updated automatically as the user scrolls along the graph.
@property (nonatomic) BOOL shouldAdaptRange;
/// If shouldAdaptRange is set to true then this specifies whether or not the points on the graph should animate to their new positions. Default is set to true.
@property (nonatomic) BOOL shouldAnimateOnAdapt;
/// Whether or not the graph should animate to their positions when the graph is first displayed.
@property (nonatomic) BOOL shouldAnimateOnStartup;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)prepareForInterfaceBuilder;
- (void)layoutSubviews;
@end

typedef SWIFT_ENUM(NSInteger, ScrollableGraphViewAnimationType) {
  ScrollableGraphViewAnimationTypeEaseOut = 0,
  ScrollableGraphViewAnimationTypeElastic = 1,
  ScrollableGraphViewAnimationTypeCustom = 2,
};

typedef SWIFT_ENUM(NSInteger, ScrollableGraphViewDataPointType) {
  ScrollableGraphViewDataPointTypeCircle = 0,
  ScrollableGraphViewDataPointTypeSquare = 1,
  ScrollableGraphViewDataPointTypeCustom = 2,
};

typedef SWIFT_ENUM(NSInteger, ScrollableGraphViewDirection) {
  ScrollableGraphViewDirectionLeftToRight = 0,
  ScrollableGraphViewDirectionRightToLeft = 1,
};

typedef SWIFT_ENUM(NSInteger, ScrollableGraphViewFillType) {
  ScrollableGraphViewFillTypeSolid = 0,
  ScrollableGraphViewFillTypeGradient = 1,
};

typedef SWIFT_ENUM(NSInteger, ScrollableGraphViewGradientType) {
  ScrollableGraphViewGradientTypeLinear = 0,
  ScrollableGraphViewGradientTypeRadial = 1,
};

typedef SWIFT_ENUM(NSInteger, ScrollableGraphViewLineStyle) {
  ScrollableGraphViewLineStyleStraight = 0,
  ScrollableGraphViewLineStyleSmooth = 1,
};

typedef SWIFT_ENUM(NSInteger, ScrollableGraphViewReferenceLinePosition) {
  ScrollableGraphViewReferenceLinePositionLeft = 0,
  ScrollableGraphViewReferenceLinePositionRight = 1,
  ScrollableGraphViewReferenceLinePositionBoth = 2,
};

typedef SWIFT_ENUM(NSInteger, ScrollableGraphViewReferenceLineType) {
  ScrollableGraphViewReferenceLineTypeCover = 0,
};

#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop