From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: S4bios support for 2.5.63
Date: 02 Mar 2003 22:22:38 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1046643757.3700.20.camel@irongate.swansea.linux.org.uk>
References: <20030226211347.GA14903@elf.ucw.cz>
	 <20030302133138.GA27031@outpost.ds9a.nl>
	 <1046630641.3610.13.camel@laptop-linux.cunninghams>
	 <20030302202118.GA2201@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030302202118.GA2201-Q4cIvbmc/GjIwqSPmO0L4w@public.gmane.org>
To: bert hubert <ahu-yMKkj5jtC+M@public.gmane.org>
Cc: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 2003-03-02 at 20:21, bert hubert wrote:
> On Mon, Mar 03, 2003 at 07:44:03AM +1300, Nigel Cunningham wrote:
> > Hi.
> > 
> > This bug is fixed in Linus tree. If you want swsusp to work in the mean
> > time, look for a couple of patches Pavel sent recently.
> 
> Ok,
> 
> In 2.5.63bk5 I get a BUG on drivers/ide/ide-disk.c:1557:
> 
> 
>         BUG_ON (HWGROUP(drive)->handler);

Looks like swsuspend attempted to run an operation while one was in
progress. IDE tries to catch that because the result of missing it isnt
very pretty at fsck time.
