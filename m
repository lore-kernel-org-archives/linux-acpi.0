From: =?ISO-8859-1?Q?Hendrik_J=FCrgens?= <hjuerg-ULHALamj7Vx/+Jgy1241yg@public.gmane.org>
Subject: Re: first shoot for smartbattery (was Re: Re: i2c-acpi-ec.c)
Date: Sat, 01 Jan 2005 13:35:18 +0100
Message-ID: <41D69906.8040908@technik-emden.de>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041231181628.GL19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.
have tried the driver on my Travelmate 4002 which has also the smartbattery.

Here what's happening.

root@trilian smartbatt # ./smartbattery
Error: No i2c-bus specified!
Syntax: smartbatt I2CBUS
~  Installed I2C busses:
~    i2c-4       unknown         ACPI EC SMBus adapter at 0018
Algorithm unavailable
~    i2c-3       unknown         crt2
Algorithm unavailable
~    i2c-2       unknown         vga
Algorithm unavailable
~    i2c-1       unknown         dvi
Algorithm unavailable
~    i2c-0       unknown         monid
Algorithm unavailable

root@trilian smartbatt # ./smartbattery 4
current:       65535 mA
remain:        65535 mA or mWh
time to empty: 65535 minutes
time to full:  65535 minutes
temperature:   6280.5 C
voltage:       65535 mV
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB1pkGgL2kQgmW9pgRAgs8AKDEDlT1vtVHiC+XSGv8Fu5bwHG2GwCfSIbv
AotXyJR5Rn2NGXf8yGr+Prc=
=K+fO
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
