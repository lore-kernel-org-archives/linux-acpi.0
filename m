From: <Valdis.Kletnieks-PjAqaU27lzQ@public.gmane.org>
Subject: Re: ACPI battery issue - Dell Inspiron 4150 - 2.6.1-rc1-mm2
Date: Mon, 29 Mar 2004 16:46:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <046501c415a4$f8b33350$d100000a@sbs2003.local>
References: <3ACA40606221794F80A5670F0AF15F8401720C78@PDSMSX403.ccr.corp.intel.com>            <1073356057.2687.2.camel@mentor.gurulabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
	micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="==_Exmh_311795388P"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: Your message of "Mon, 05 Jan 2004 19:27:38 MST."             <1073356057.2687.2.camel-P/F4XmbQBeggkoNBMjr0DEEOCMrvLtNR@public.gmane.org> 
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Administrator-fARf8FLM0JdLN7wammbJVlpr/1R2p/CL@public.gmane.org
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--==_Exmh_311795388P
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="us-ascii"

On Mon, 05 Jan 2004 19:27:38 MST, Dax Kelson said:

> Seems to work ... is it normal to have the "unknown" values below when
> plugged in?
> 
> $ cat /proc/acpi/battery/BAT0/state
> present:                 yes
> capacity state:          ok
> charging state:          unknown
> present rate:            unknown
> remaining capacity:      66000 mWh
> present voltage:         16501 mV

I can't say for certain, but I think it's a tad confused - it can report 
'charging', and 'discharging', but doesn't know what to say if the battery
is at 100% and you're running off AC....It's been that way on mine at
least since 2.5.7mumble or maybe 2.4.18, so it's NOT a regression from the
recent ACPI patch.

--==_Exmh_311795388P
Content-Transfer-Encoding: 7bit
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/+icEcC3lWbTT17ARAtMZAJ93stfHRUoxG50eeFB7+YRrqh3aVACgm1gE
xKBbT9pJfs3vMpvRx6fZvOg=
=Re/0
-----END PGP SIGNATURE-----

--==_Exmh_311795388P--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
