From: mru-UNjuZkX4dYU@public.gmane.org (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Fri, 24 Oct 2003 11:11:32 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <yw1xr813f1a3.fsf@kth.se>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net>
 <20031020184750.GA26154@hell.org.pl> <yw1xekx7afrz.fsf@kth.se>
 <20031023082534.GD643@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> writes:

>> >> suspend, the extra buttons (I use them to fire up programs) stop
>> >> working.  Normally, they will generate an ACPI event, that is
>> >> processed by acpid etc.  After a suspend, each button will work o=
nce.
>> >> If I then close and open the lid, they will work one more time, a=
nd so
>> >> on.  Any way I can help?
>> >
>> > Please specify the type of suspend. The situation I described
>> > only occurs for S1 (or, echo -n standby, more specifically), and
>> > only in certain kernel versions.
>>=20
>> standby, at least.
>>=20
>> After echo -n mem > /sys/power/state, the display light won't turn o=
n,
>> so I don't know what's going on.  I've never managed to resume from =
a
>> suspend to disk.  It just boots normally and makes a fuss about the
>> filesystems.
>
> Are you passing resume=3D option?

I've been trying the new suspend to disk implementation (pmdisk, I
think) lately.  I get these lines in the kernel log when starting
after a suspend:

PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S5)

Last time I tried swsusp, I did pass the resume=3D option, but it didn'=
t
work.

Could it be that some disk cache is never flushed properly?
Occasionally, some random filesystem is reported as not being cleanly
unmounted when booting normally, which seems to point in the same
direction.

--=20
M=E5ns Rullg=E5rd
mru-UNjuZkX4dYU@public.gmane.org
