From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: [ACPI] Re: [BUG] test9 ACPI bad: scheduling while atomic!
Date: Mon, 27 Oct 2003 12:24:04 -0800 (PST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20031027122259.Y77994@root.org>
References: <Pine.GSO.4.58.0310262327040.19469@clyde>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.GSO.4.58.0310262327040.19469-8Uwgm7wxmYs@public.gmane.org>
To: "Noah J. Misch" <noah-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 27 Oct 2003, Noah J. Misch wrote:
> > are shown below.  It looks like the AML associated with the AC event is
> > trying to do an AML_SLEEP_OP.  Since this is called while in the
> > interrupt handler, and the eventual call to acpi_os_sleep() sets the
> > current state to interruptible... boom.  One simple, but terribly ugly,
> > workaround is to make acpi_os_sleep() call acpi_os_stall() if
> > in_atomic() is true (patch below).  Hopefully there's a better way to
> > fix this.  Somehow the interpreter really needs to drop interrupt
> > context before it starts making calls like this.  Thanks,

I thought a change was committed to address this, calling Stall for up to
255 us and Sleep for more than that.

-Nate
