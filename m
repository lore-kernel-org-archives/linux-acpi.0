From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M2400N and monitor switching
Date: Tue, 16 Dec 2003 14:43:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FDF0C02.101@pca.it>
References: <1071580509.29592.21.camel@skinnerup.mip.sdu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1071580509.29592.21.camel-kIu+fQ4xpd9XnW97NowkO4MF2aZwyW4E@public.gmane.org>
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

Hello Mads!

on 12/16/03 14:15, Mads Paulin wrote:
| It's been a while since I've kept up with the acpi-development, but as
| far as I remember, there were some problems switching between the
| flatpanel and an external monitor on some ASUS centrino laptops (more
| specifically the M2400N)
|
| I was wondering, how status is now ?? Is it working now, as the dsdt in
| the bios is used instead of a pathed one from the os ?
As you probably remember, I can speak about the M3N, not the M2400N...

- - Fn+F8 switches correctly from LCD (internal) and CRT (external), but
just one of them, I mean, you can't use the 2 together as in mirror mode.

- - swtiching via 'acpi4asus' doesn't work on M3N and AFAIK neither on M2N

- - the 'i810switch' tool at http://vorlon.ces.cwru.edu/~ames/i810switch/
doesn't work: if you choose CRT:on and LCD:on, the CRT is turned on but
it remains blank, while the image is still on the LCD. Anyway, it seems
that the Intel 82855GM is supported only in CRT mode (but on my laptop
this doesn't work at all, I'm going to write to the author).

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/3wwAVAp7Xm10JmkRAgm4AJ9Ec/X8uAN5rNqH35+yzAAYJM5QKwCfQ+Uv
l7bu+tWonbbEj0qvVawR2K8=
=Aj3X
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
