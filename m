From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: _blank_ after resume
Date: Tue, 9 Mar 2004 00:37:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040308233725.GJ484@elf.ucw.cz>
References: <Pine.LNX.4.58.0403071321080.873@boston.corp.fedex.com> <20040308204608.GA494@elf.ucw.cz> <Pine.LNX.4.58.0403090655550.25069@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403090655550.25069-2K9XAwmnW1wYQUuIRqa960M9+F4ksjoh@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jeff Chua <jeff89-xU4+foPaXuB6NlgSsqhgrkEOCMrvLtNR@public.gmane.org>
Cc: ACPI Development <Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > I got a blank screen with keyboard frozen after resume.
> >
> > Teach X to pretend to shutdown :-).
> 
> Ok, that's good. Can you kindly elaborate just a little?
> 
> I've no clue. Currently, I _really_ shutdown X first. Would to nice to not
> shutdown, but I don't know how to _pretend_.

I did not say it is easy :-).

Teach X (I mean write code!) to return video card to same state it
puts it after X shutdown.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
