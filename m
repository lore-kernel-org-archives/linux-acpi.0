From: Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Date: Mon, 3 Mar 2003 13:37:29 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030303123729.GB4048@k3.hellgate.ch>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams> <20030302202118.GA2201@outpost.ds9a.nl> <20030303003940.GA13036@k3.hellgate.ch> <1046657290.8668.33.camel@laptop-linux.cunninghams> <20030303113153.GA18563@outpost.ds9a.nl> <20030303122325.GA20929@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030303122325.GA20929-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: bert hubert <ahu-yMKkj5jtC+M@public.gmane.org>, Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 03 Mar 2003 13:23:25 +0100, Pavel Machek wrote:
> Well, it does not happen on my machines, but I've already seen it
> happen on computer with two harddrives.

That was my initial suspicion, since I have two of them and typical swsusp
(Laptop) users tend not to have more than one. But I gave up on that theory
when Bert's log showed only one disk:

#        syncing disks
#        suspending devices
#        suspending c0418bcc
#        suspending devices
#        suspending c0418bcc
#        suspending: hda ------------------[ cut here

If he had two disks, his trace should look more like mine:

# Syncing disks before copy
# Suspending devices
# Suspending device c0390e4c
# Suspending device c03911a4
# Suspending devices
# Suspending device c0390e4c
# suspending: had ------------[ cut here ]------------
# kernel BUG at drivers/ide/ide-disk.c:1557!

Roger
