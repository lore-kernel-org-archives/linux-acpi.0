From: mru-UNjuZkX4dYU@public.gmane.org (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Mon, 20 Oct 2003 21:08:16 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <yw1xekx7afrz.fsf@kth.se>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net>
 <20031020184750.GA26154@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> writes:

>> suspend, the extra buttons (I use them to fire up programs) stop
>> working.  Normally, they will generate an ACPI event, that is
>> processed by acpid etc.  After a suspend, each button will work once=
=2E
>> If I then close and open the lid, they will work one more time, and =
so
>> on.  Any way I can help?
>
> Please specify the type of suspend. The situation I described only oc=
curs
> for S1 (or, echo -n standby, more specifically), and only in certain =
kernel
> versions.

standby, at least.

After echo -n mem > /sys/power/state, the display light won't turn on,
so I don't know what's going on.  I've never managed to resume from a
suspend to disk.  It just boots normally and makes a fuss about the
filesystems.

--=20
M=E5ns Rullg=E5rd
mru-UNjuZkX4dYU@public.gmane.org
