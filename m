From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: trackpoint dead after S3 suspend
Date: Sun, 23 Nov 2003 11:32:09 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031123103209.GA279@elf.ucw.cz>
References: <3FB3B9D0.5020408@netspace.org> <20031116225331.GA206@elf.ucw.cz> <20031119145809.GA14399@hell.org.pl> <3FC05E17.1010208@netspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FC05E17.1010208-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Brian Perkins <bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >>Its actually input problem. This might help, (untested!).
> >>   
> >>
> >
> >This actually makes my keyboard *not* work after any suspend, including the
> >previously-OK S1. Your last patch was better for my system, it seems.
> >Best regards,
> >
> > 
> >
> I tried a very naive hack, which gets a step closer to fixing things.
> I essentially copied i8042_init to the resume function.  It's terribly 
> ugly, and incorrect in a myriad of ways, but the mouse is responding.  
> Unfortunately it appears that the mouse is still not generating 
> interrupts, so the mouse response is slow and jerky.
> I fooled around quite a bit, but wasn't able to do any better than this.
> 
> Probably not very helpful, but I thought I pass this on.

Uhmm, yes this is really way too ugly. See l-k to find similar code
done less ugly way... (I did it yesterday).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
