From: Chris Howells <chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org>
Subject: Re: Latest ACPI + cpufreq on a Dell Inspiron 2650
Date: Tue, 3 Dec 2002 18:12:46 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212031812.50786.chris@chrishowells.co.uk>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B95D@orsmsx107.jf.intel.com> <200212031601.20634.chris@chrishowells.co.uk> <00de01c29aeb$0583c8f0$3746028e@bio.dfo.ca>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <00de01c29aeb$0583c8f0$3746028e-dP0OE4Ef7fWw5LPnMra/2Q@public.gmane.org>
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

On Tuesday 03 December 2002 16:42, Derek Broughton wrote:
> It should generate an event to /proc/acpi/event, and the easiest way to use
> that is to use acpid.  check syslog for messages from acpid, which
> correspond to unprocessed events.

Aha. Just installed acpid now. Looks quite nifty. /etc/acpi/powerbtn.sh 
originally just said "shutdown -h 0" which I've changed to say "dcop 
- --all-users kdesktop KDesktopIface logout" so I get the KDE logout dialog 
when the power button is pressed. Nice :)

> iirc, sometimes you might only get an event on pushing the suspend button,

The machine helpfully doesn't have a suspend button, only a power button.

> in which case you run a script that completes the suspend, then sleeps a
> couple of seconds, then runs hwclock to reset the clock.

Good idea. I'll have a mess around. 

> > I'm not going to have this machine much longer because after a length
> > battle with them including starting legal proceedings (the memory was(is)
> > faulty and g++ kept suffering from Internal Compiler errors) I'm getting
> > a refund. Hopefully the new machine will work as well or better :)
>
> better, one hopes!

Just as long as it compiles properly I'll be happy :) ACPI working nicely is a 
bonus though.

Thanks for the help, most appreciated.

- -- 
Cheers, Chris Howells -- chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org, howells@kde.org
Web: http://chrishowells.co.uk, PGP key: http://chrishowells.co.uk/pgp.txt
KDE: http://www.koffice.org, http://printing.kde.org, http://usability.kde.org

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE97PQiF8Iu1zN5WiwRAnzrAJ9h5wauBb2JF8FgjzbCZeF0Lflv5QCeJK6p
npakczbmNHjnubtoKrol8eI=
=Tlng
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
