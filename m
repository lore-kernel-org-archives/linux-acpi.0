From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ThinkPad A30p T40p /proc/acpi/embedded_controller crash
Date: Wed, 21 Jan 2004 22:33:31 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8A23@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Red Hat rawhide users on IBM ThinkPad A30p and T40p discovered
that accessing /proc/acpi/embedded_controller crashes Linux:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D113555
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D113814

Arjan and Al Viro isolated the problem to the ACPI EC code (below).
Unfortunately, I don't have a T40p or A30p, and the ThinkPads
we've tried (T40 etc) do not reproduce this crash.

Anybody out there got a ThinkPad that they don't mind crashing
to help test the fix to this bug?  Would also be interested to
Know if other kernels besides rawhide fail the same way.

The test:
$ find /proc/acpi/embedded_controller -name oops

Thanks,
-Len

-----Original Message-----
From: viro-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org [mailto:viro@www.linux.org.uk] On Behalf Of
viro-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org
Sent: Monday, January 19, 2004 5:02 AM
To: Arjan van de Ven
Cc: Brown, Len; linux-acpi
Subject: Re: FW: acpi workqueue prob


On Mon, Jan 19, 2004 at 09:27:06AM +0100, Arjan van de Ven wrote:
>                 acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
>                         ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
>

>                 acpi_remove_gpe_handler(NULL, ec_ecdt->gpe_bit,
&acpi_ec_gpe_handler);
>

>                 kfree(ec_ecdt);
>         }
>=20
> where acpi_remove_gpe_handler() forgets to remove outstanding
work/wait for
> outstanding work, so such work keeps polluting ec_ecdt even though
it's freed (and in
> this bug's case, reallocated for something else leading to an oops in
/proc
> later).
>=20
> Remove interfaces ideally are synchronous with the thing they remove,
like
> del_timer_sync() is in linux....

It's a bit worse than that - removal of acpi_ec_gpe_handler is not what
bites
us here; what happens is:
	acpi_ec_gpe_handler is scheduled
	acpi_ec_gpe_handler runs and schedules acpi_ec_gpe_query
	we remove acpi_ec_gpe_handler, which leaves acpi_ec_gpe_query
scheduled
	we kfree the thing tha is the argument of acpi_ec_gpe_handler
_AND_
the argument of scheduled acpi_ec_gpe_handler
	acpi_ec_gpe_handler runs
	*BOOM*

So whether there are issues in acpi_remove_gpe_handler() behaviour or
not
(and they can easily create similar races with narrower windows), here
we
are getting screwed since the caller of acpi_remove_gpe_handler() has no
idea that acpi_ec_gpe_handler() had left something behind.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
