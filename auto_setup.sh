#!/bin/bash

echo -n "Enter the name of your project and press [ENTER]: "
read name

meteor create $name
cd $name

npmmodules=('react' 'react-dom')
for i in "${npmmodules[@]}";do npm install --save $i; done


cat > ./client/main.js << EOF
// any JS here is run automatically

// Import the React Library
import React from 'react';
import ReactDOM from 'react-dom';

import ImageList from './components/image_list';

// Create a component


const App = () => {
  return (
    <div>
      <ImageList />
    </div>
  );
};

// Render this component to the screen
Meteor.startup(() => {
  ReactDOM.render(<App />, document.querySelector('.container'));
});
EOF


cat > ./client/main.html << EOF
<head>
  <title>Image Bucket</title>
</head>
<body>
  <div class="container"></div>
</body>
EOF





mkdir client/components
mkdir client/style
meteor add twbs:bootstrap@3.3.6



cat > ./client/components/image_detail.js << EOF
import React from 'react';

const ImageDetail = (props) => {
  // props.image => this is the image object
  // props.image.title
  // props.image.link

  return (
      <li className="media list-group-item">
        <div className="media-left">
          <img src={props.image.link} />
        </div>
        <div className="media-body">
          <h4 className="media-heading">
          {props.image.title}
          </h4>
        </div>
      </li>
  );
};

export default ImageDetail;
EOF

cat > ./client/components/image_list.js << EOF
// Create our image list component

// Import React
import React from 'react';
import ImageDetail from './image_detail';

const IMAGES = [
  {title: 'First', link: 'http://dummyimage.com/600x400'},
  {title: 'Second', link: 'http://dummyimage.com/600x400'},
  {title: 'Third', link: 'http://dummyimage.com/600x400'},
];

// Create component
const ImageList = () => {
  const RenderedImages = IMAGES.map((image) => {
      return <ImageDetail key={image.title} image={image} />
  });

  return (
    <ul className="media-list list-group">
      {RenderedImages}
    </ul>
  );
};

// Export component
export default ImageList;

EOF

cat > ./client/style/main.css << EOF
img {
  width: 300px;
}
EOF

cd ../

touch .gitignore

echo '.DS_Store' >> .gitignore
echo '*.log' >> .gitignore

cd $name

meteor
