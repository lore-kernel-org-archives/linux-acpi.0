From: Alvaro Lopes <alvieboy-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org>
Subject: Re: [ACPI] 2.5.58 hangs at boot
Date: Sun, 26 Jan 2003 13:59:55 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3E33E9DB.2070604@alvie.com>
References: <F760B14C9561B941B89469F59BA3A847137F76@orsmsx401.jf.intel.com> <3E300BCE.9080909@alvie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3E300BCE.9080909-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> This repeats 'ad infinitum'. Didn't wait for more than a few minutes,=
=20
> but it looks like it will.
>
> The interrupts are handled at acpi_ev_gpe_detect (), which returns 1.=
=20
> At this point in_irq() returns 0x00010000 (or 0x00001000, don't have =
a=20
> serial console :/)
>
I have done some debugging, and here are the not-so-exciting results:

GPE08 is dispatched. My debug shows something like this:

* Is a control method
* Method at AML address d08047a4 length 39D
* Begin method parse Entry=3Dcff43904 obj=3Dcff4238c
* State=3Dcff4ec00
* Completed one call  to walk loop, AE_OK, state=3Dcff4ec00
* Parser exiting, status AE_OK
* Begin method execution Entry=3Dcff43904 obj=3Dcff4238c
* State=3Dcff4ec00
* Completed one call to walk loop, AE_CTRL_TRANSFER State=3Dcff4ec00
* Execute Method 00000000, current state cff4ec00
* State=3Dcff4e800
* Completed one call to walk loop, AE_OK, State=3Dcff4e800
* Parser exiting, status AE_OK
* Starting nested execution, newstate=3Dcff4e800
* Completed one call to walk loop, AE_OK, state=3Dcff4e800
* Completed one call to walk loop, AE_OK, state=3Dcff4ec00
* Parser exiting, status AE_OK

And keeps doing this every time GPE08 is enabled.

Any ideas ? Right now I have disabled the GPE and can trigger an enable=
=20
via /proc, so if you need more info, please tell me.

The hex dump at 0xd08047a4 + 1 shows something like:

5c 2f 04 5f 53 42 5f 50 43 49 30 50 43 49 42 42 52 47 42 60 79 60 0a 18=
=20
60 0c 0b b1 20 00 60 70 0a af
5c 2f 03 5f 53 42 5f 4d 45 4d 5f 49 45 44 49 53 4d 42 52 0b 00 ff 60 0a=
=20
00 0a 00 0a b2 a2 4b 35 91
5c 2f 03 5f 53 42 5f 4d 45 4d 5f 47 50 35 30 91
=2E...

And now a stupid question: on the second line I believe it reads as=20
"Root" "Multiname" "3 Segments", but it looks like it has 4=20
(_SB_.MEM_.IEDI.SMBR). Is this correct ?

--=20

=C1lvaro Lopes=20
---------------------
A .sig is just a .sig
