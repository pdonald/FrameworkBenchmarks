# ASP.NET MVC on Windows and Mono

## Tests

* JSON serialization
* Single database query
* Multiple database queries
* Server-side templates and collections
* Database updates
* Plaintext

## Versions

**Language**

* C# 5.0

**Platforms**

* .NET Framework 4.5 (Windows)
* Mono 3.6.0 (Linux)

**Web Servers**

* IIS 8 (Windows)
* XSP latest (Linux)
* nginx 1.4.1 & XSP FastCGI (Linux)

**Web Stack**

* ASP.NET 4.5
* ASP.NET MVC Framework 5.1.0

**Databases**

* MySQL Connector/Net 6.9.3
* Npgsql 2.0.14.3
* Entity Framework 6.1.1
* Mongo C# Driver 1.8.3

**Developer Tools**

* Visual Studio 2012

## Mono Installation

    sudo apt-get install -y build-essential autoconf automake libtool zlib1g-dev pkg-config gettext

    wget http://download.mono-project.com/sources/mono/mono-3.6.0.tar.bz2
    tar xf mono-3.6.0.tar.bz2
	cd mono-3.6.0
    ./configure --prefix=/usr/local
    make
    sudo make install

    cd ..

    git clone git://github.com/mono/xsp
    cd xsp
    ./autogen.sh --prefix=/usr/local
    make
    sudo make install
    
	echo -e 'y\ny\n' | certmgr -ssl https://nuget.org
    mozroots --import --sync
