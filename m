From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: S4bios support for 2.5.63
Date: 03 Mar 2003 14:09:07 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1046700547.5890.24.camel@irongate.swansea.linux.org.uk>
References: <20030226211347.GA14903@elf.ucw.cz>
	 <20030302133138.GA27031@outpost.ds9a.nl>
	 <1046630641.3610.13.camel@laptop-linux.cunninghams>
	 <20030302202118.GA2201@outpost.ds9a.nl>
	 <20030303003940.GA13036@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030303003940.GA13036-NW/W/tFpkLjPJA67Yv3YjA@public.gmane.org>
To: Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>
Cc: bert hubert <ahu-yMKkj5jtC+M@public.gmane.org>, Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2003-03-03 at 00:39, Roger Luethi wrote:
> The only thing that came up at the time was a suggestion to replace BUG_ON
> with while (which I didn't try because I'd like to keep my data).

That isnt far off what you want. IDE has proper command queuing functionality and
providing you are suspending in a sleeping context you can do what you are trying
to do through the IDE layer politely. Take a look at how the various ide taskfile
ioctls issue commands.
