From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Presario R3120US not updating present rate
Date: Tue, 15 Jun 2004 10:13:39 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.60.0406151005230.1178@frog.athome>
References: <20040614215520.GA17906@dominikbrodowski.de> <40CE5F69.7030500@pacific.edu>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40CE5F69.7030500-s7p20SfEDVaVc3sceRu5cw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ken Hughes <khughes-s7p20SfEDVaVc3sceRu5cw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Ken,
On Mon, 14 Jun 2004, Ken Hughes wrote:
> I noticed that I alway get "present rate: 0 mA" when I
> cat /proc/acpi/battery/BAT1/state .  Running acpi -ab
> gives the following:
>
> 35 budgie: ./acpi -ab
>     Battery 1: charging, 88%, charging at zero rate - will never fully 
> charge.
>   AC Adapter 1: on-line
> 36 budgie: ./acpi -ab
>     Battery 1: discharging, 88%, charging at zero rate - will never fully 
> charge.
>   AC Adapter 1: off-line
I did not look into your DSDT, but as you are surely not using a 
primary-battery (as opposed to an akkumulator), the offline-case needs to 
report a sensible value, according to the ACPI-1.0 spec.
For the online-case if would suffice to report the unknown-value (its the 
MAX-UINT...). So your BIOS is NOT ACPI-compilant!
The BIOS of my Acer TM-63x reports in both case the unknown-value (so is 
less buggy, but still not ACPI-compliant). The problem might be, that XP 
does not care about the present-rate.

cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAzq+49bBoTzOf1pMRAmJJAKDQGDDIWYr0UQDM20K4Msqd9zM0HQCg7dYu
Nhl5EPwT1FW+psYYNP94AtI=
=O+qE
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
