From: "Ranjan Parthasarathy" <Ranjan.Parthasarathy-IrU4XInhIXM@public.gmane.org>
Subject: RE: 2.6.11 issues with S3
Date: Wed, 28 Sep 2005 10:39:51 -0700
Message-ID: <4A60C83D027E224BAA4550FB1A2B120E9DFBB3@fcexmb04.efi.internal>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks,

Ranjan

-----Original Message-----
From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org]=20
Sent: Tuesday, September 27, 2005 5:44 AM
To: Ranjan Parthasarathy
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] 2.6.11 issues with S3

Hi!

> I am trying to get S3 working on my system running a 2.6.11 (upgraded =
from
> 2.6.4) kernel. On boot up I can put the system to S3 and then wol =
using
magic
> packets. Subsequent attempts to put the system to S3 fail with the =
error

Try with recent kernel.

> "stopping tasks failed (208 tasks remaining)". I tried changing the =
TIMEOUT
> from the default 6 HZ in kernel/power/process.c to a larger number and =
the
> system is now able to suspend but takes about 20 - 30 seconds for it =
to go
to
> suspend. Why is it taking that long? Also shouldn't the timeout be
dependent
> on the number of processes that we are trying to put to suspend vs a
constant
> value?
> =20
> On my system, the error is easily reproducible with a simple shell =
script
> that spawns a lot of processes. As the number of processes increase, =
after
> around 70 odd processes in the system I start seeing failures while =
trying
to
> suspend.

It was not really design to work on stressed system, but feel free to =
fix it.
Sometimes even make -j 10 on kernel breaks it.
--=20
64 bytes from 195.113.31.123: icmp_seq=3D28 ttl=3D51 time=3D448769.1 ms  =
      =20



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
