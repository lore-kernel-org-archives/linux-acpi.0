From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Date: 03 Mar 2003 16:40:20 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1046709619.6530.11.camel@irongate.swansea.linux.org.uk>
References: <20030226211347.GA14903@elf.ucw.cz>
	 <20030302133138.GA27031@outpost.ds9a.nl>
	 <1046630641.3610.13.camel@laptop-linux.cunninghams>
	 <20030302202118.GA2201@outpost.ds9a.nl>
	 <20030303003940.GA13036@k3.hellgate.ch>
	 <1046657290.8668.33.camel@laptop-linux.cunninghams>
	 <20030303113153.GA18563@outpost.ds9a.nl>
	 <20030303122325.GA20929@atrey.karlin.mff.cuni.cz>
	 <20030303123551.GA19859@outpost.ds9a.nl>
	 <20030303124133.GH20929@atrey.karlin.mff.cuni.cz>
	 <20030303151135.GA24815@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030303151135.GA24815-Q4cIvbmc/GjIwqSPmO0L4w@public.gmane.org>
To: bert hubert <ahu-yMKkj5jtC+M@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>, Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2003-03-03 at 15:11, bert hubert wrote:
> To no avail. I'm investigating how I can go ext2 on this machine as I read
> elsewhere that the kernel will silently mount an ext3 partition with a
> journal as ext3 even when asked to mount as ext2.

hdparm -u1 is just changing the timing its not actually touching the bug in
the suspend code.
