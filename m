From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: 2.5.34?
Date: Wed, 18 Sep 2002 14:53:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020918125352.GA29050@atrey.karlin.mff.cuni.cz>
References: <20020917155146.F39@toy.ucw.cz> <200209181224.g8ICONr31147@p2.parker.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200209181224.g8ICONr31147-paYRYfI9b/YMuHHiPFXXZ1fOaUvyCJUZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Brad Parker <brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >No. S3 wakeup is completely different from S4 wakeup.
> 
> Really?  I thought they both used the same "wakeup vector" and hence
> used the pre-_WAK code path.  Perhaps I am mistaken.

Well, we do S3 using ACPI but do S4 "by hand", so wakeup vector is not
even used in S4 (==swsusp) case.

S3 is similar to S4bios; there are patches for S4bios floating around,
but its not in mainline.

> >And bothworked for me in 2.5.32 IIRC.
> 
> ok, thanks.  That's actually the first time anyone has said that clearly.
> 
> (your previous email was somewhat vague about S3 working - it didn't
> actually state that it was working and when)

[I'm not 100% sure about it was 2.5.32. I think it was.]

> >Look at acpi_wakeup.S. If your mode is in  text VGA you can just write
> >to videoram. Maybe code to do that is still there?
> 
> The problem is that the backlight is not on, and it's not clear the
> vga controller is turned on.  This code runs before _WAK (which I think
> is what turns on the backlight)
> 
> I'll try it, however, as it's a reasonable suggestion.  thanks!

On my machines I'm lucky enough to have video either in VGA text or in
original mode. In VGA text it is rather easy to show some debugging.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
