const mongoose = require ('mongoose');
mongoose.connect('mongodb://localhost:27017/ratingsandreviews');
const db = mongoose.connection;

db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function() {
  console.log('success');
  let reviewSchema = mongoose.Schema({
    review_id: Number,
    product_id: Number,
    rating: Number,
    characteristics: Object,
    recommend: Boolean,
    reported: Boolean,
    summary: String,
    body: String,
    response: String,
    reviewer_name: String,
    photos: Array,
    date: Date,
    helpfulness: Number
  });

  let Review = mongoose.model('Review', reviewSchema);

  exports.save = (reviews) => {
    return Review.create(reviews);
  };

  exports.getAll = () => {
    return Review.find({});
  };
});