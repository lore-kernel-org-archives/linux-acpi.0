From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH for review] ACPI: Create /sys/firmware/acpi/interrupts/
	counters
Date: Tue, 5 Feb 2008 18:43:49 -0800
Message-ID: <20080206024349.GA10883@suse.de>
References: <200802050230.10873.lenb@kernel.org> <200802051812.09228.lenb@kernel.org> <20080205231842.GB8740@suse.de> <200802052058.50663.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761737AbYBFCpx@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200802052058.50663.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 05, 2008 at 08:58:50PM -0500, Len Brown wrote:
> On Tuesday 05 February 2008 18:18, Greg KH wrote:
> > On Tue, Feb 05, 2008 at 06:12:09PM -0500, Len Brown wrote:
> > > On Tuesday 05 February 2008 17:18, Greg KH wrote:
> > > > On Tue, Feb 05, 2008 at 02:30:10AM -0500, Len Brown wrote:
> > > > > # cat /sys/firmware/acpi/interrupts/summary
> > > > > pm_timer     0
> > > > > glbl_lock    0
> > > > > power_btn    0
> > > > > sleep_btn    0
> > > > > rtc          0
> > > > > gpe00    0
> > > ...
> > > > > gpe1F    0
> > > > > gpe_hi    0
> > > > > gpe_total   63
> > > > > acpi_irq    63
> > > > 
> > > > Eeek!  Why?  What's wrong with individual files here?
> > > 
> > > My expectation is that this is a shell interface for debugging,
> > > not an API for programs.  ala /proc/interrupts.
> > 
> > Great, then use debugfs for it.  Please, don't put debug stuff like this
> > in sysfs, that's not what it is there for.  You can do whatever you want
> > in debugfs :)
> 
> Can you point to a model of good behaviour that I can copy?

Any user of the debugfs api you could copy for this.

> note that I want this information to be available on every system,
> just like /proc/interrupts is.

Ah, then /proc perhaps?

> /proc/ has seqfile support, is there a reason I shouldn't use it?
> I'd banned additional files from /proc/acpi for a long time
> since the directory layout was ill-conceived.  But maybe I
> should re-consider the headlong rush to use sysfs?

One of the main problems of /proc was that the files were not
documented, or that the format would change between versions, or that
they were different on different arches.

For something like this, yes, maybe you do need to use proc.  It can
handle almost infinite length files, and just make sure you document it
well.

But I would just stick with debugfs, all distros enable it when
shipping, you just have to ask them to mount it by hand usually:
	mount -t debugfs none /sys/kernel/debug/

Either way, I wouldn't recommend sysfs for this.

thanks,

greg k-h
