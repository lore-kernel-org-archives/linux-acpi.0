From: Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>
Subject: Re: S4bios support for 2.5.63
Date: Mon, 3 Mar 2003 01:39:40 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030303003940.GA13036@k3.hellgate.ch>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams> <20030302202118.GA2201@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030302202118.GA2201-Q4cIvbmc/GjIwqSPmO0L4w@public.gmane.org>
To: bert hubert <ahu-yMKkj5jtC+M@public.gmane.org>, Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 02 Mar 2003 21:21:18 +0100, bert hubert wrote:
> In 2.5.63bk5 I get a BUG on drivers/ide/ide-disk.c:1557:
> 
> 
>         BUG_ON (HWGROUP(drive)->handler);
> 

That problem has been around for a while. I reported it for 2.5.59 which
just happened to be the first 2.5 kernel I tested with swsuspend.

I'm seeing the bug every time I try swsuspend on 2.5. The same Vanilla
kernels seem to work for other people, though.

The only thing that came up at the time was a suggestion to replace BUG_ON
with while (which I didn't try because I'd like to keep my data).

Roger
