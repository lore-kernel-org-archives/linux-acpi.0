From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Acer 1703 and DSDT fixing questions
Date: Wed, 11 Feb 2004 18:23:12 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0402111818540.2221@frog.athome>
References: <3ACA40606221794F80A5670F0AF15F8401CBB68B@PDSMSX403.ccr.corp.intel.com>
 <200402111650.55343.cirrus@the-penguin.org.uk>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200402111650.55343.cirrus-m8NPtmh9OiN1HeySrBk8eLVCufUGDwFn@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John <cirrus-m8NPtmh9OiN1HeySrBk8eLVCufUGDwFn@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut John,
On Wed, 11 Feb 2004, John wrote:
> $ cat /proc/acpi/battery/BAT1/state
> present:                 yes
> capacity state:          ok
> charging state:          discharging
> present rate:            unknown
> remaining capacity:      5524 mAh
> present voltage:         16249 mV
>
> The present rate is unknown.
The ACPI-spec only asks for a present-rate, if you use a
rechargeable-battery, and are in state discharging. So this is against the
specs, as you are probably not using one-way-cells. Whith my Acer TM-630 I
found out, that the present-rate is hard-coded to be unknown in the DSDT.
So just have a look into your DSDT.
But anyway, if there is software, that may not handle an unknown
presen-rate, it is broken. With software, I do not mean ACPI or DSDT, but
userspace tools.

Cheers
  hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAKmUF9bBoTzOf1pMRAgo0AKC9cUX6ddP/oXllwuUM1SKJrL/y6ACbB952
UY0j6AtBm8AIoK59Ib9Ak5o=
=WivT
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
