<?php

if (file_exists('./.env') === false) {
    echo 'error reading .env';
}

else {
    echo '<p>reading .env</p>';
    echo file_get_contents('./.env');
}
