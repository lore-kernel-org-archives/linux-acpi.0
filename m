From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Date: Mon, 3 Mar 2003 18:23:16 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200303031823.17050.p_christ@hol.gr>
References: <20030226211347.GA14903@elf.ucw.cz> <20030303123551.GA19859@outpost.ds9a.nl> <20030303124133.GH20929@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030303124133.GH20929-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Content-Disposition: inline
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, bert hubert <ahu-yMKkj5jtC+M@public.gmane.org>, Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>, Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> > [ pruned mr Grover from the CC list ]
> >
> > On Mon, Mar 03, 2003 at 01:23:25PM +0100, Pavel Machek wrote:
> > > Well, it does not happen on my machines, but I've already seen it
> > > happen on computer with two harddrives.
> >
> > This is a laptop with only one. Anything I can do to help, let me know.
> > Alan has suggested that an IDE transaction was still in progress, perhaps
> > a small wait could prove/disprove this assumption?
>
> Start adding printks to see whats going on. Try going ext2. Try
> killing sys_sync() from kernel/suspend.c.
>
> 									Pavel

This looks like the problem I've been reporting since 2.5.5x . On my machine 
(HP XE3GC) I get a rare chance that this happens. 
One raw hack I have been using to get around that, is my 'sleep' script (for 
S1):
/etc/init.d/ypbind stop 	#i.e. prepare the system
sleep 9		#allow me to lock the screen etc.

sync			#This is where I reduce the chance I have dirty buffers
sleep 1		# calm down
echo 1 >/proc/acpi/sleep	#sleep now

That won't fix the bug, of course, but shows what may go wrong..
