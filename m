From: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Subject: Re: Invalid PBLK length
Date: Wed, 18 Dec 2002 16:36:36 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212181536.gBIFabD09402@ikffws2.ikff.uni-stuttgart.de>
Reply-To: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-MD5: CVjNqds1nb/jb8/rLrLYCw==
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

> > Ok, I can see in the code (processor.c) that in the function
> > acpi_processor_get_inf the value of object.processor.pblk_lenght
> > is checked, and in case it's smaller than 6 this error is thrown.
> > If it's 6 or greater, then addresses for C2 and C3 are assigned.
> > But why can't PBLK be 5 and only C2 be used? Couldn't we just=20
> > disable C3 and still assign the address for C2 as pblk_address+4?
> > I think it was done that way in prpower.c Revision 32. That gave
> > me a working C2. =20
>=20
> Well, specs issue?

Yes, I see. I hadn't found that, but Matthew pointed me to the
right chapter of the specs.

> > BTW, how can I make my FADT human readable? It isn't shown by=20
> > acpidmp, and I'd like to be able to check some values myself.
>=20
> ./acpidmp FACS | ./acpitbl
>=20
> Note that it is FACS (the signature of the table), not FADT (I don't know
> why the sig. and the name of this table are not the same).

But this FACS doesn't give me much information (since it's only
the signature, I guess).
It sais:

Signature:=09=09FACS
Length:=09=09=0964
Hardware Signature:=090x00000000
Firmware Waking Vector: 0x00000000
Global Lock:=09=090x00000000
Flags:=09=09=090x00000000

I'm curious what I'll find in the FADT. I mean, 5 clearly is=20
neither 0 nor 6, so there might be some other really heavy bugs.
I'll get me the=20


Jens

--=20
Jens Haug
IKFF Universit=E4t Stuttgart              Tel. 0711/685-6422
Pfaffenwaldring 9                       Fax  0711/685-6356
70550 Stuttgart=09                haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
