From: Chris Howells <chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org>
Subject: Re: Latest ACPI + cpufreq on a Dell Inspiron 2650
Date: Tue, 3 Dec 2002 16:01:11 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212031601.20634.chris@chrishowells.co.uk>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B95D@orsmsx107.jf.intel.com> <200212030136.30159.chris@chrishowells.co.uk> <002401c29acd$e1316880$3746028e@bio.dfo.ca>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <002401c29acd$e1316880$3746028e-dP0OE4Ef7fWw5LPnMra/2Q@public.gmane.org>
Content-Description: clearsigned data
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On Tuesday 03 December 2002 13:14, Derek Broughton wrote:
> > * When going into S1 from within X, the screen does not seem to be turned
> > off, only much darker -- I can still see the contents of the screen
> > albeit darkly when the system is supposedly asleep.
>
> That's very normal on the Dell.  If you ever figure out how to actually
> turn off the backlight, please let me know.

:)

Ah, this reminds me of something. The binary only NVidia (while I've heard of 
many people with trouble them, they've been excellent for me and give me 
decent rates in Return to Castle Wolfenstein) force apm to be disabled, 
because it intereferes with AGP or something. Thanfully this is done in the 
open-source interface bit. I'll see if making some changes to the interface 
(just a case of changing some function return calues) code makes it work any 
better.

> > * Entering S1 halts the system clock so the time when leaving S1 is the
> > same as when it entered S1
>
> As it should.  You have to reset the clock.

Oh really? Hrm.... so presumably the correct solution would be to do a 
"hwclock --hctosys" on leaving S1? *Wonders how to make it do this 
automatically*

> I've never had fan & thermal_zones successfully on my i2500, and never even
> seen a "power_resource", but ac_adapter works fine.

Interesting.

Many thanks for the answers, very useful.

I'm not going to have this machine much longer because after a length battle 
with them including starting legal proceedings (the memory was(is) faulty and 
g++ kept suffering from Internal Compiler errors) I'm getting a refund. 
Hopefully the new machine will work as well or better :)

- -- 
Cheers, Chris Howells -- chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org, howells@kde.org
Web: http://chrishowells.co.uk, PGP key: http://chrishowells.co.uk/pgp.txt
KDE: http://www.koffice.org, http://printing.kde.org, http://usability.kde.org

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE97NVQF8Iu1zN5WiwRAi2dAJoDZiO8aOxvGzAiSzs1hlAKy7mjiwCeIWP1
5AQ3cedN9DJECBwWA1igMeA=
=XMvs
-----END PGP SIGNATURE-----




-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
