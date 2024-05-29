var lang = 'En';

const version = '1.0';
const actual_version = '1.0.5';

const whatsapp_support = '96171190361';

const max_image_size = 5;

const cancel_time = 2;

const return_time = 0;

const cancel_return_time = 0;

List<String> regions = const [
  'Beirut',
  'Jnoub',
  'Beqaa',
];

// WHEN CHANGING THE CONDITIONS, WE SHOULD CHANGE THEM IN THE ===> TRANSLATIONS FOLDERS AND IN THE BACKEND.  +  RIDER APP.
List<String> conditions = const [
  'New',
  'Used - Like New',
  'Used - Good',
  'Used - Fair',
];

// ADD THE VALUE IN THIS MAP IN THE JSON FILE WHENEVER CHANGED.
Map<String, String> plural_selling_units = const {
  'Piece': 'pieces',
  'Box(6 pieces)': 'boxes(6 pieces)',
  'Box(12 pieces)': 'boxes(12 pieces)',
  'Box(24 pieces)': 'boxes(24 pieces)',
};

// WHEN CHANGING THE SELLING UNITS, WE SHOULD CHANGE THEM IN THE ===> TRANSLATIONS FOLDERS AND IN THE BACKEND. + RIDER APP.
// WE SHOULD ADD THIS IN THE TRANSLATIONS IN THE SMALL CASE ALSO.
// FINALLY ADD THE NEW IN THE PLURAL SELLING UNITS.
var selling_units = const [
  'Piece',
  'Box(6 pieces)',
  'Box(12 pieces)',
  'Box(24 pieces)',
];

// WHEN CHANGING THE WEIGHTS, WE SHOULD CHANGE THEM IN THE ===> TRANSLATIONS FOLDERS AND IN THE BACKEND.  +  RIDER APP.
List<String> product_weights = const [
  'kg',
  'g',
  'ml',
];

// WHEN CHANGING THE R POINTS, WE SHOULD CHANGE THEM IN THE ===> TRANSLATIONS FOLDERS AND IN THE BACKEND.  +  RIDER APP.
List<String> r_points = const [
  '50 Points',
  '100 Points',
  '200 Points',
  '300 Points',
  '400 Points',
  '500 Points',
];
// WHEN CHANGING THE WS POINTS, WE SHOULD CHANGE THEM IN THE ===> TRANSLATIONS FOLDERS AND IN THE BACKEND.  +  RIDER APP.
List<String> ws_points = const [
  '5 Points',
  '10 Points',
  '20 Points',
  '30 Points',
  '40 Points',
  '50 Points',
];

// WHEN CHANGING THE CANCEL REASONS, WE SHOULD CHANGE THEM IN THE ===> TRANSLATIONS FOLDERS + BACKEND. + ADMIN APP.
List<String> cancel_reasons = const [
  'Found a Better Price',
  'Long Delivery Time',
  "Incorrect Item Ordered",
  "Financial Reasons",
  'Other',
];

// WHEN CHANGING THE DENIED REASONS, WE SHOULD CHANGE THEM IN THE ===> TRANSLATIONS FOLDERS + BACKEND  + ADMIN APP.
List<String> denied_reasons = const [
  'Out Of Stock',
  "Pricing Error",
  'Other',
];

// WHEN CHANGING THE RETURN REASONS, WE SHOULD CHANGE THEM IN THE ===> TRANSLATIONS FOLDERS + BACKEND.
List<String> return_reasons = const [
  'Product Damaged',
  "Incorrect Item",
  "Product Not as Described",
  "Quality Issues",
  'Other',
];

// WHEN CHANGING THE RETURN CANCEL REASONS, WE SHOULD CHANGE THEM IN THE ===> TRANSLATIONS FOLDERS + BACKEND +  ADMIN APP.
List<String> return_cancel_reasons = const [
  'Changed Mind',
  'Resolved Issue',
  'Other',
];

// WHEN CHANGING THE RETURN CANCEL REASONS, WE SHOULD CHANGE THEM IN THE ===> TRANSLATIONS FOLDERS.
List<String> support_normal = const [
  "Order Issues",
  "Order Tracking",
  "Returns and Refunds",
  "Shipping Information",
  "Technical Support",
  'Forgot password',
  "Feedback and Suggestions",
  "Other",
];

// List<String> support_buyer_order = const [
//   'Buyer Order',
//   'Other',
// ];
//
// List<String> support_seller_order = const [
//   'Seller Order',
//   'Other',
// ];
//
// List<String> support_buyer_return = const [
//   'Buyer Return',
//   'Other',
// ];
//
// List<String> support_seller_return = const [
//   'Seller Return',
//   'Other',
// ];
