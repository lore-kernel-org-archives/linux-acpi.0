From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sat, 5 Jan 2008 15:39:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801051537450.26040-100000@netrider.rowland.org>
References: <200801052119.48542.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757539AbYAEUj6@vger.kernel.org>
In-Reply-To: <200801052119.48542.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 5 Jan 2008, Rafael J. Wysocki wrote:

> > Another thing to watch out for: Just in case somebody ends up calling
> > destroy_suspended_device(dev) from within dev's own resume method, you 
> > should interchange the resume_device() and the list_move_tail() 
> > calls in dpm_resume().
> 
> However, if we unregister them all at once after releasing pm_sleep_rwsem,
> that shouldn't be necessary, right?

It's still necessary, because destroy_suspended_device() still has to
move the device from one list to another.  You don't want it to end up 
on the dpm_locked list.

Alan Stern

