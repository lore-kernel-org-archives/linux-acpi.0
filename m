From: mru-UNjuZkX4dYU@public.gmane.org (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Sat, 25 Oct 2003 19:05:39 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <yw1xwuati6xo.fsf@kth.se>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net>
 <20031020184750.GA26154@hell.org.pl> <yw1xekx7afrz.fsf@kth.se>
 <20031023082534.GD643@openzaurus.ucw.cz> <yw1xr813f1a3.fsf@kth.se>
 <3F98FDDF.1040905@cyberone.com.au> <yw1xbrs6652m.fsf@kth.se>
 <20031024222347.GB728@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> writes:

>> That took me one step further.  Now it loaded the image swap, but th=
em
>> immediately rebooted.  I didn't have time to see if there were any
>> error messages.  I don't have a serial port, so I can't put a consol=
e
>> there.  This was with lots of modules loaded, so maybe unloading som=
e
>> would help.  Are there any known broken drivers in this list:
>
> Try it completely without modules. I'm not sure how it should work
> with modules which means it probably does not work at all.

OK, so I tried it with just the a few modules loaded (those I couldn't
unload, for some reason), and it worked.  Now I guess I'll have to
track down which modules are being evil.

--=20
M=E5ns Rullg=E5rd
mru-UNjuZkX4dYU@public.gmane.org
