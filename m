From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: listening for GPEs
Date: Sat, 23 Aug 2003 01:51:38 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84702C92ED5@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vishal Verma <vermavee-Wuw85uim5zDR7s880joybQ@public.gmane.org>, acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Vishal Verma [mailto:vermavee-Wuw85uim5zDR7s880joybQ@public.gmane.org]=20
> I have a problem related to the propagation of GPEs. In my module, I'm
> installing my own GPE handler using acpi_install_gpe_handler() as
>=20
> acpi_install_gpe_handler(NULL, 8, ACPI_EVENT_EDGE_TRIGGERED,=20
> my_handler,
> NULL);
>=20
> my_handler() gets called on arrival of events and it queues a task as:
>=20
> acpi_disable_gpe(NULL, 8, ACPI_ISR);
> acpi_os_queue_for_execution(OSD_PRIORITY_GPE, my_doit_handler, data);
>=20
> and then my_doit_handler() performs the following tasks:
>=20
> /* some processing */
> acpi_clear_gpe(NULL, 8, ACPI_NOT_ISR);
> acpi_enable_gpe(NULL, 8, ACPI_NOT_ISR);
>=20
>=20
> The problem is that the acpi subsystem keeps calling my_handler()
> infinitely. The only reason, I think that can happen is that I'm not
> able to remove the event from the ACPI event queue. I was thinking
> acpi_clear_gpe() would remove it, but it doesn't seem to be=20
> doing that.

Could your device be continually signalling the GPE? If the trigger-mode
was wrong, could that be it? I don't think it's ACPI. It should be a
straight shot from the SCI handler (acpi_ev_sci_xrupt_handler) being
called to invocation of your GPE handler -- there aren't any queues or
anything.

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
