From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Thu, 23 Oct 2003 10:25:35 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20031023082534.GD643@openzaurus.ucw.cz>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net> <20031020184750.GA26154@hell.org.pl> <yw1xekx7afrz.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <yw1xekx7afrz.fsf-UNjuZkX4dYU@public.gmane.org>
To: pavel-+ZI9xUNit7I@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >> suspend, the extra buttons (I use them to fire up programs) stop
> >> working.  Normally, they will generate an ACPI event, that is
> >> processed by acpid etc.  After a suspend, each button will work once.
> >> If I then close and open the lid, they will work one more time, and so
> >> on.  Any way I can help?
> >
> > Please specify the type of suspend. The situation I described only occurs
> > for S1 (or, echo -n standby, more specifically), and only in certain kernel
> > versions.
> 
> standby, at least.
> 
> After echo -n mem > /sys/power/state, the display light won't turn on,
> so I don't know what's going on.  I've never managed to resume from a
> suspend to disk.  It just boots normally and makes a fuss about the
> filesystems.

Are you passing resume= option?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...
