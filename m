From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: FW: ACPI breakage in 2.6.2-rc3 (and before)
Date: Sun, 01 Feb 2004 21:38:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <401D63B8.6080301@pca.it>
References: <7F740D512C7C1046AB53446D37200173B135D3@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <7F740D512C7C1046AB53446D37200173B135D3-exJ48ZlmiLrcnAH0NVKmOFDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 02/01/04 19:27, Nakajima, Jun wrote:
> Forwarding potential degradation in 2.6.2-rc3.
<cut>
> -----Original Message-----
<cut>
> Hmm.  I just tried 2.6.2-rc3 (after having tried 2.6.1 after having
>   tried 2.6.2-rc2-mm1), and I note that ACPI can get my battery
>   status in 2.6.1, but *not* in 2.6.2-rc2-mm1 or in 2.6.2-rc3.
>   It notes that there is a battery in one of the two bays, and
>   that it's on battery or AC power, but nothing more; all status
>   readouts say that the battery's drained.
just as a report, no problem here on an ASUS M3410C (M3N):

- - 2.6.1 + ACPI 20031203
gismo:~# cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         64500 mWh
last full capacity:      59970 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 6450 mWh
design capacity low:     3225 mWh
capacity granularity 1:  645 mWh
capacity granularity 2:  645 mWh
model number:            M3N
serial number:
battery type:            LIon
OEM info:                ASUSTEK
gismo:~# cat /proc/acpi/battery/BAT0/alarm
alarm:                   unsupported
gismo:~# cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mW
remaining capacity:      59970 mWh
present voltage:         16726 mV
gismo:~#

- - 2.6.2-rc3 (with no other patch)
gismo:~# cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         64500 mWh
last full capacity:      59970 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 6450 mWh
design capacity low:     3225 mWh
capacity granularity 1:  645 mWh
capacity granularity 2:  645 mWh
model number:            M3N
serial number:
battery type:            LIon
OEM info:                ASUSTEK
gismo:~# cat /proc/acpi/battery/BAT0/alarm
alarm:                   unsupported
gismo:~# cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mW
remaining capacity:      59970 mWh
present voltage:         16732 mV
gismo:~# cat /proc/acpi/battery/BAT1/alarm
present:                 no
gismo:~# cat /proc/acpi/battery/BAT1/info
present:                 no
gismo:~# cat /proc/acpi/battery/BAT1/state
present:                 no
gismo:~#

Even on my laptop, there're 2 battery bays (actually, on my laptop the
2nd is used by the optical drive).

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAHWO3VAp7Xm10JmkRApoHAJ4/pdJ0Jfa6OwBgKtvCenHrp7FtIwCdGvQE
Uk/FB3WRbzufPb3x+ghBaKE=
=7k6b
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
