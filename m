From: mru-UNjuZkX4dYU@public.gmane.org (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Missing ACPI interrupts/events after S3 suspend
Date: Sun, 26 Oct 2003 15:08:32 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <yw1x4qxwgkgv.fsf@kth.se>
References: <20031026133510.GA19227@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org> writes:

> Using 2.6.0-test9 if I do an S3 suspend, then when the machine comes=20
> back pressing the power button generates no ACPI events or interrupts=
=2E=20
> Other events (sleep button, lid switch, plugging/unplugging AC adapte=
r)=20
> still work.

What model is your machine?  My Asus M2400E behaves similarly.  After
echo -n mem > /sys/power/state, all the extra buttons stop working,
except that each one will work once after closing and opening the
lid.  Another lid cycle makes them work one more time.

--=20
M=E5ns Rullg=E5rd
mru-UNjuZkX4dYU@public.gmane.org
