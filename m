From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M2400N and monitor switching
Date: Wed, 17 Dec 2003 09:54:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FE019E2.3030705@pca.it>
References: <3ACA40606221794F80A5670F0AF15F8401720C37@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C37-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

on 12/17/03 06:28, Yu, Luming wrote:
| Is this ACPI issue? If yes, please provide some detail.
I don't know about the M2N/M3N, but monitor switching is an ACPI
features on some ASUS laptops. From the 'acpi4asus' readme:

|   You can turn the LCD panel on/off or read its status by echoing 0 or
1 in the
|   lcd entry or reading it.
<cut>
|  4.1.1 Display switching
|
|   Note: the display switching code is currently considered EXPERIMENTAL.
|
|   Switching works for the following models:
|     L3800C
|     A2500H
|
|   Switching doesn't work for the following:
|     M3700N
|     L2X00D (locks the laptop under certain conditions)
|
|   To switch the displays, echo values from 0 to 7 to
/proc/acpi/asus/disp. The
|   significance of those values is as follows:
|
|   0 - no display
|   1 - LCD only
|   2 - CRT only
|   3 - LCD + CRT
|   4 - TV-Out only
|   5 - LCD + TV-Out
|   6 - CRT + TV-Out (not tested)
|   7 - LCD + CRT + TV-Out (not tested)
|
|   In most cases, the appropriate displays must be plugged in for the above
|   combinations to work. TV-Out may need to be initialized at boot time.

Maybe Karol Kozimor can explain better :-)

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/4BngVAp7Xm10JmkRAlvtAKCLjcCfOhkD5mSiaz3OBvrap/RSFwCgg6sC
47UHwKLSOuAXQlL0Rk7/9pY=
=kriK
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
