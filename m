From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: 2.5.34?
Date: Tue, 17 Sep 2002 15:51:47 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020917155146.F39@toy.ucw.cz>
References: <willy@debian.org> <200209161612.g8GGCtv24883@p2.parker.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200209161612.g8GGCtv24883-paYRYfI9b/YMuHHiPFXXZ1fOaUvyCJUZ@public.gmane.org>; from brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org on Mon, Sep 16, 2002 at 12:12:55PM -0400
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Brad Parker <brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Gustavo Sverzut Barbieri <gsbarbieri-/E1597aS9LRfJ/NunPodnw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >but 2.5.35 is out, so there's no need any more ;-)
> 
> ok, I'll try 2.5.35;  Is there a changelog for acpi? (other than the
> kernel changelog)
> 
> S1 is working for me with 2.4.19, but even if I throttle back the cpu it
> eats a lot of power (and generates a lot of heat!)
> 
> I've been fooling around with S3.  It looks like the big recent
> additions (in 2.5) are to try and set the video mode in the wakeup
> callback.  I keep sending email to the list but I have not heard from
> anyone talk about the status of this code.

In such case... you are not listening.

> I want to ask "does the s3 wakeup code work for anyone?"; I suspect it
> does since I've read reports that S4 is working for some and it uses
> the same code path (for wakeup anyway).

No. S3 wakeup is completely different from S4 wakeup.

And bothworked for me in 2.5.32 IIRC.

> Any suggestions how to debug this?  I would hack in some code to spit
> messages out the uart but my hp laptop doesn't have one :-) I may try
> a pcmcia 16550 card and a kgdb hack...
> 
> S3 puts it to sleep fine but when I wake up it seem to be hung - no lcd,
> no keyboard...  It's pretty hard to say how far it gets.

Look at acpi_wakeup.S. If your mode is in  text VGA you can just write
to videoram. Maybe code to do that is still there?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
