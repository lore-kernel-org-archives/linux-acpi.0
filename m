From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [ACPI] RE: kacpidpc needs to die
Date: Wed, 8 Jan 2003 21:58:48 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030108205848.GB32645@atrey.karlin.mff.cuni.cz>
References: <F760B14C9561B941B89469F59BA3A84725A10E@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A10E-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > safe, anyway],
> > > kacpidpc needs to die. Andrew, are you going to kill it or 
> > should I do
> > > it?
> > 
> > I can kill it...let me just verify with you --
> > acpi_os_queue_for_execution has a two block switch statement, just use
> > the first block (the case that uses schedule_work) and delete 
> > the rest,
> > yes?
> 
> Oops, and combine acpi_os_schedule_exec and acpi_os_queue_exec, so that
> we call dpc->function() from the original thread. Anything else?

I don't see anything else, this looks okay.

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
