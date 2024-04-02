import React, { useState } from 'react';

function Header({ onSearchKeyword }) {
    const [searchTerm, setSearchTerm] = useState('');

    function handleKeyUp(event) {
            fetchData();
    }

    function fetchData() {
        onSearchKeyword(searchTerm);
    }

    return (
        <section className="panel">
            <div className="panel-body">
                <input
                    type="text"
                    placeholder="Keyword Search"
                    className="form-control"
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    onKeyUp={handleKeyUp}
                />
            </div>
        </section>
    );
}

export default Header;
