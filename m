From: bert hubert <ahu-yMKkj5jtC+M@public.gmane.org>
Subject: Re: S4bios support for 2.5.63
Date: Sun, 2 Mar 2003 21:21:18 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030302202118.GA2201@outpost.ds9a.nl>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1046630641.3610.13.camel-udXHSmD1qAz9bBlWBkG5g4WQyAnV0byH@public.gmane.org>
To: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 03, 2003 at 07:44:03AM +1300, Nigel Cunningham wrote:
> Hi.
> 
> This bug is fixed in Linus tree. If you want swsusp to work in the mean
> time, look for a couple of patches Pavel sent recently.

Ok,

In 2.5.63bk5 I get a BUG on drivers/ide/ide-disk.c:1557:


        BUG_ON (HWGROUP(drive)->handler);


It now says (copied by hand):

	freeing memory: .....................|
(this 'freeing' takes ages, around 30 seconds, while in progress, the disk
 light blinks every once in a while, perhaps each time while a dot is being
printed)
	syncing disks
	suspending devices
	suspending c0418bcc
	suspending devices
	suspending c0418bcc
	suspending: hda ------------------[ cut here
trace back:

device_susp()
drivers_susp()
do_sofware_susp()

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
