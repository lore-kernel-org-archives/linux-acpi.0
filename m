From: "Diefenbaugh, Paul S" <paul.s.diefenbaugh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: EC SCI model?
Date: Tue, 24 Jun 2003 22:54:59 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <59278FC0C48A994BABABD069571E4568017903D5@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'd echo Andy's recommendation to check out the Linux code.  We went
through quite a bit of wrenching before getting this to work right on
all of the various ECs - noting that most are incapable of handing
EC_SCIs in a purely interrupt-driven fashion...
___________________________________________=20
Paul Diefenbaugh=20
Intel Corporation, MPG | MPA | System Software Architecture


-----Original Message-----
From: Grover, Andrew=20
Sent: Tuesday, June 24, 2003 6:02 PM
To: 'Nate Lawson'; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Diefenbaugh, Paul S
Subject: RE: [ACPI] EC SCI model?

> From: Nate Lawson [mailto:nate-Y6VGUYTwhu0@public.gmane.org]=20

> I am a FreeBSD developer but this is a more general question=20
> with ACPI.  I
> looked through the spec (especially 13 Embedded Controller)=20
> and I have a
> question regarding the IBF/OBF stuff.  Testing has shown that I get
> multiple callbacks of my EcGpeHandler() routine even when IBF=20
> and OBF have
> not changed.  Isn't the GPE only supposed to trigger when=20
> they change (and
> only once)?  I've gotten more reliability by waiting for the=20
> GPE, checking
> the status and if it isn't what I'm waiting for, go back to sleep.

Hi Nate,

Please feel free to take a look at the Linux EC driver. (It's GPLed but
you should still be able to use it as a reference w/o contamination.)

We ended up not being fully interrupt-driven, because of the very
problem you mentioned, IIRC. Once the 3-phase ec read/write sequence has
begun, we busy-wait for IBF/OBF. This is of course not ideal but it
seems to work. Perhaps Paul would like to comment more, after he gets
back from vacation. ;-)

Regards -- Andy


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
