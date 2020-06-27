psycopg2-aws-lambda
===================

[![Build Status](https://travis-ci.org/soulwing/psycopg2-aws-lambda.svg?branch=master)](https://travis-ci.org/github/soulwing/psycopg2-aws-lambda)

A build repository for a statically-linked distribution of 
[Psycopg2](https://pypi.org/project/psycopg2/) for use with AWS Lambda.


Why is this Needed?
-------------------

The [Python Package Index](https://pypi.org) describes **Psycopg**
as the "_most popular PostgreSQL database adapter for the Python 
programming language_." Indeed, Psycopg provides a nice functional 
interface for interacting with PostgreSQL databases in Python 
programs. However, the default distribution cannot be used with AWS 
Lambda, because it is dynamically linked to the `libpq` library 
provided with PostgreSQL.

There are (at least) two approaches to solving this problem. One would
be to make use of AWS Lambda _layers_ to include the necessary PostgreSQL
libraries. If this is the approach you wish to take, this project is _not_
what you seek.

An alternative is to build a distribution of Psycopg that is statically
linked to `libpq`. That is the approach used here. The result is fully
functional copy of Psycopg that you can simply include in the zip file
for your AWS Lambda deployment package.


Installation Instructions
-------------------------

1. Go to [Releases](https://github.com/soulwing/psycopg2-aws-lambda/releases)
   for this project.
2. Find and download the latest version of the distribution zip for the 
   version of Python used by your lambda code. The naming convention for 
   the distribution zip is `psycopgA.B.C-X.Y.zip`, where _X.Y_ is the 
   version of Python targeted by the distribution.
3. Download the corresponding SHA256 or MD5 hash and use it to validate 
   the downloaded zip file.
4. Unpack and include the contents of the distribution zip in the zip file
   for your AWS Lamdba deployment package, just like any other Python library.
5. Use Psycopg in your Python code for AWS Lambda just as you would in any
   other Python program.


Prior Art
---------

Jeff Kehler's [awslambda-psycopg2](https://github.com/jkehler/awslambda-psycopg2) repository also provides a statically-linked distribution of Psycopg.
However, because it is not packaged as a version- tagged Github release, 
it's a little less convenient to use in automated builds.

The principal difference is that this repository includes an 
open (and easily inspected/audited) set of small shell scripts that are 
used with Travis CI via Github integration to build and release Psycopg 
distributions for use with AWS Lambda. The resulting releases are tagged 
and available at fixed, predictable URLs for use in your automated builds. 
Each release distribution includes SHA256 and MD5 hashes so you can 
use in your builds with greater confidence that you have a genuine 
artifact.


Python Versions
---------------

The build in this repository produces statically-linked distributions of
Psycopg for each of the Python versions supported by AWS Lambda. As of
June 2020, this includes Python versions 2.7, 3.6, 3.7, and 3.8. If you 
discover that this repository does not contain a distribution for a 
version of Python supported by AWS Lambda, please open an issue to
request it.


PostgreSQL Versions
-------------------

Client software such as Psycopg interfaces with a PostgreSQL server
via the `libpq` library. Indeed, the entire purpose of this project
is to build a distribution of Psycopg that is statically linked to
`libpq`.

Based in part on [this thread](https://www.postgresql-archive.org/Details-about-libpq-cross-version-compatibility-td5723830.html) as well as anecdotal 
experiences reported by others, it seems that the recommended approach is 
to build PostgreSQL client applications that use `libpq` using the latest 
stable version of that library. The development community for PostgreSQL 
has demonstrated a solid history of maintaining both backward and forward 
compatibility between `libpq` and the PostgreSQL server. For this reason, 
this project is generally built using the latest stable version of 
PostgreSQL when creating new tagged builds.
