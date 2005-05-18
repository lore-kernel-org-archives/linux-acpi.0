From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/2] IPMI and acpi=off|ht :acpi-get-firmware-failure.patch
Date: Wed, 18 May 2005 09:19:44 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E01885400@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: sergio-qOf5bGQp09kptuEoxK/DLR2eb7JE58TQ@public.gmane.org, Yann Droneaud <ydroneaud-4qZELD6FgxhWk0Htik3J/w@public.gmane.org>
Cc: Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thanks, I will look at this.
Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Sergio Monteiro Basto
> Sent: Tuesday, May 17, 2005 4:28 PM
> To: Yann Droneaud
> Cc: Kernel Mailing List; ACPI Developers; Moore, Robert
> Subject: Re: [ACPI] [PATCH 1/2] IPMI and acpi=3Doff|ht =
:acpi-get-firmware-
> failure.patch
>=20
> Hi,
> I am CCing to Robert Moore because is about acpi/tables/tbxfroot.c. =
This
> is code from ACPICA
> http://developer.intel.com/technology/iapc/acpi/downloads.htm
> So we have to wait for the next version of ACPICA, on dmesg we can =
find
> it, for example:
>=20
> ACPI: Subsystem revision 20050211
>=20
> thanks,
>=20
> On Mon, 2005-05-16 at 23:42 +0200, Yann Droneaud wrote:
> > This patch check that rsdt_info->pointer is not NULL before trying =
to
> > unmap ACPI tables, which can happen if acpi_tb_get_rsdt_address()
> failed.
> >
> > In my case, with ipmi_si_intf module and acpi=3Dht|off parameter, =
the call
> > failed because acpi_gbl_table_flags is not initialised, so the
> > address.pointer_type is not setup correctly, leading to message =
like:
> >
> > May 16 11:18:29 localhost kernel:     ACPI-0166: *** Error: Invalid
> address flags 8
> >
> > and rsdt_info->pointer equal to NULL leading to the Oops.
> >
> > --- linux-2.6.11.9/drivers/acpi/tables/tbxfroot.c	2005-05-11
> 18:42:39.000000000 -0400
> > +++ linux-2.6.11.9-fixes/drivers/acpi/tables/tbxfroot.c	2005-05-16
> 16:51:33.115768232 -0400
> > @@ -313,7 +313,9 @@ acpi_get_firmware_table (
> >
> >
> >  cleanup:
> > -	acpi_os_unmap_memory (rsdt_info->pointer, (acpi_size) rsdt_info-
> >pointer->length);
> > +	if (rsdt_info->pointer) {
> > +		acpi_os_unmap_memory (rsdt_info->pointer, (acpi_size)
> rsdt_info->pointer->length);
> > +	}
> >  	ACPI_MEM_FREE (rsdt_info);
> >
> >  	if (header) {
> >
> >
> > Signed-Off-by: ydroneaud-4qZELD6FgxhWk0Htik3J/w@public.gmane.org
> >
> --
> S=E9rgio M.B.
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=3D7412&alloc_id=3D16344&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
