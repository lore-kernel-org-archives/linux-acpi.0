From: Jason Bowman <jasonb42lists-K2GnTyEPumIAvxtiuMwx3w@public.gmane.org>
Subject: Re: Kernel instability problem
Date: Wed, 14 Aug 2002 01:01:30 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208140101.31130.jasonb42lists@attbi.com>
References: <200208130037.51909.jasonb42lists@attbi.com> <20020813081825.A798@tarnation.dyndns.org>
Reply-To: jasonb42lists-K2GnTyEPumIAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020813081825.A798-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Aaron Gaudio <prothonotar-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>
Cc: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 13 August 2002 08:18 am, Aaron Gaudio wrote:
> If you haven't already, try disabling your sound... gaim will (by defau=
lt)
> play a sound when you receive a message, xine probably tries at least
> opening the sound device when it loads, and KDE starts aRts, I believe,
> which, like Gnome's Esound, will open the sound device in order to

Actually sounds is a big reason as to why I am using the ACPI patch as my=
=20
laptops sound does not work unless ACPI is up and running! I can and do p=
lay=20
sound through out the day using KDE's artsd daemon. Naturally watching a=20
movie w/o sound is not that appealing... I will however try gaim w/o soun=
d=20
just to make sure.=20

> multiplex desktop sounds. Maybe there's a conflict somewhere brought ab=
out
> by ACPI (did you turn off "Plug 'n Play OS" in the BIOS?).
My bios sucks and does not have this option... in fact HP shipped an bad =
ACPI=20
version number too!
=2E.............

I can't believe it! The problem was the sound... gaim was set to use esd.=
 With=20
it set to esd the computer crashes, setting sound output to an option oth=
er=20
than esd it does not crash. (I don't hear anything, but at least my compu=
ter=20
didn't crash!)

Thanks a lot for pointing out the obvious,
 - Jason B.

> And lo, upon Tue, Aug 13, 2002 at 12:37:51AM -0400, Jason Bowman spaket=
h=20
thusly:
> > Hello all,
> >
> > I have an HP zt1190 laptop, reportedly the same as the xt1100 series.=
 I
> > have found that whenever I use an ACPI kernel (I have tried 2.4.18 w/
> > 20020611 20020726 patches) and run gaim my machine freezes. This also
> > happens with xine. Gaim freezes when someone sends me a message, xine=
 at
> > startup. Running KDE 3.0.1 the display remains in a frozen state, not=
hing
> > moves/changes/etc. I can't switch to an virtual desktops either.
> >
> > Anyone have any clues? I would like to investigate why this happens a=
nd
> > help to fix it, however I don't know what to try next. Pointers
> > appreciated.
> >
> > Thanks,
> > Jason B.
> >
> >
> >
> > -------------------------------------------------------
> > This sf.net email is sponsored by: Dice - The leading online job boar=
d
> > for high-tech professionals. Search and apply for tech jobs today!
> > http://seeker.dice.com/seeker.epl?rel_code1
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
