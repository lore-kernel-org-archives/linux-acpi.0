From: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Subject: Re: Invalid PBLK length
Date: Thu, 19 Dec 2002 09:13:41 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212190813.gBJ8DgD13785@ikffws2.ikff.uni-stuttgart.de>
Reply-To: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-MD5: kQ48LSTfYvDCT61Dgh3UxQ==
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Ouch!  Sorry.  FACP is the signature of FADT in fact.
> FACS is the sig. of the FACS table, which contains the global lock and
> other things.

Ok, I see.

> ./acpidmp FACP | ./acpitbl
>=20
> Should give something like:
(...)
> OEMID:            TOSCPL
> OEM Table ID:     888M1

This is ASUS and L2000D for me.

> S4BIOS_REQ:       0xf2

This is 0x00 for me. I had checked that before (when you
wrote about s4bios the last time).

> PM1a_EVT_BLK:     0x00001000

0x0000e400.
Now I only have to find out what that means. Guess I'll have
to read some specs.

> PM1b_EVT_BLK:     0x00000000

Same here.

> PM1a_CNT_BLK:     0x00001004

0x0000e404.

> PM1b_CNT_BLK:     0x00000000

Same here.

> PM2_CNT_BLK:      0x00001020

0x00000000.

> PM_TMR_BLK:       0x00001008

0x0000e408.

> GPE0_BLK:         0x00001028

0x0000e420

> GPE1_BLK:         0x0000102c

0x0000e430.

> PM1_EVT_LEN:      4
> PM1_CNT_LEN:      2

Same here.

> PM2_CNT_LEN:      1

0.

> PM_TM_LEN:        4
> GPE0_BLK_LEN:     4
> GPE1_BLK_LEN:     4
> GPE1_BASE:        16

Same here.

> P_LVL2_LAT:       10

Is this the latency for C2? This is 90 for me.

> P_LVL3_LAT:       1001

1900.

> FLUSH_SIZE:       0
> FLUSH_STRIDE:     0
> DUTY_OFFSET:      1
> DUTY_WIDTH:       3
> DAY_ALRM:         0x0d

Same.

> MON_ALRM:         0x08
> CENTURY:          0x32

Both 0x00.

> Flags:            0x00000025

0x000000a6.


I'll look this up in the specs and see what I can learn. Well,
at least I'm gonna try to find this in the specs.=20


Jens

--=20
Jens Haug
IKFF Universit=E4t Stuttgart              Tel. 0711/685-6422
Pfaffenwaldring 9                       Fax  0711/685-6356
70550 Stuttgart=09                haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org



-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
