From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [ACPI] Re: Fixes to suspend-to-RAM
Date: 19 Feb 2003 00:08:21 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1045609701.7399.5.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.33.0302181535520.1035-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0302181535520.1035-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2003-02-18 at 22:41, Patrick Mochel wrote:

> I propose that we don't even call SUSPEND_DISABLE. Based on recent
> conversations, it appears that we can and should do the entire device
> suspend sequence in two passes - SUSPEND_SAVE_STATE with interrupts
> enabled, and SUSPEND_POWER_DOWN with interrupts disabled.

Right... though I still care about my early pet SUSPEND_NOTIFY for
the few things that need to care about allocations issues (that is
that need to know they can no longer rely on GFP_KERNEL & friends
not blocking until wakeup).

Regarding failure, what I did with success on pmac (I had occasional
failure to suspend from the OHCI controller or video drivers during
tests, though those seem to be quite rare in real life) is to call
back the wakeup calls for devices that got the matching suspend
call.

I beleive it's as safe to just call all wakeup calls in order
instead though, and it makes things simpler (as the individual
drivers should really know in what state they really are).

Ben.
