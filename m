From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [ACPI] PaceBlade broken acpi/memory map
Date: Tue, 25 Feb 2003 16:13:41 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030225151341.GI13404@poup.poupinou.org>
References: <20030220172144.GA15016@elf.ucw.cz> <20030224164209.GD13404@poup.poupinou.org> <20030224183955.GC517@atrey.karlin.mff.cuni.cz> <20030225143505.GH13404@poup.poupinou.org> <3E5B835E.7050601@symplon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E5B835E.7050601-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
To: Robert <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Woerle <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 25, 2003 at 03:53:18PM +0100, Robert wrote:
> 
> 
> Ducrot Bruno schrieb:
> 
> >On Mon, Feb 24, 2003 at 07:39:55PM +0100, Pavel Machek wrote:
> > 
> >
> >>Hi!
> >>
> >>   
> >>
> >>>>I have PaceBlade here, and its memory map is wrong, which leads to
> >>>>ACPI refusing to load. [It does not mention "ACPI data" in the memory
> >>>>map at all!]
> >>>>       
> >>>>
> >>>I have made those patches to workaround that.  I have no time
> >>>     
> >>>
> >>Yes, I have seen those... I also made a patch that enables you to do
> >>that workaround from mem= options at kernel command line.
> >>
> >>   
> >>
> >
> >I doubt you received the latest one, since I have not make it public
> >unless this day.
> > 
> >
> i did sent it to him since he recieved our machine from Suse Nuernberg
> 

Ah, OK.  Wasn't aware of that.  But why then making a mem= opitons in
that case.  I have take care to *not* use any mem= at all because that
can make things worse.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
