From: Sergio Monteiro Basto <sergio-qOf5bGQp09kptuEoxK/DLR2eb7JE58TQ@public.gmane.org>
Subject: Re: [PATCH 1/2] IPMI and acpi=off|ht :
	acpi-get-firmware-failure.patch
Date: Wed, 18 May 2005 00:27:31 +0100
Message-ID: <1116372451.14534.17.camel@bastov>
References: <m27jhyzwj6.fsf@firedrake.mandriva.com>
	 <m23bsmzw35.fsf@firedrake.mandriva.com>
Reply-To: sergio-qOf5bGQp09kptuEoxK/DLR2eb7JE58TQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m23bsmzw35.fsf-UvLOT2mcgw93qojSD/UXlMfpnLc0EkqF@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Yann Droneaud <ydroneaud-4qZELD6FgxhWk0Htik3J/w@public.gmane.org>
Cc: Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
I am CCing to Robert Moore because is about acpi/tables/tbxfroot.c. This
is code from ACPICA
http://developer.intel.com/technology/iapc/acpi/downloads.htm
So we have to wait for the next version of ACPICA, on dmesg we can find
it, for example: =20

ACPI: Subsystem revision 20050211

thanks,

On Mon, 2005-05-16 at 23:42 +0200, Yann Droneaud wrote:
> This patch check that rsdt_info->pointer is not NULL before trying to
> unmap ACPI tables, which can happen if acpi_tb_get_rsdt_address() faile=
d.
>=20
> In my case, with ipmi_si_intf module and acpi=3Dht|off parameter, the c=
all
> failed because acpi_gbl_table_flags is not initialised, so the
> address.pointer_type is not setup correctly, leading to message like:
>=20
> May 16 11:18:29 localhost kernel:     ACPI-0166: *** Error: Invalid add=
ress flags 8
>=20
> and rsdt_info->pointer equal to NULL leading to the Oops.
>=20
> --- linux-2.6.11.9/drivers/acpi/tables/tbxfroot.c	2005-05-11 18:42:39.0=
00000000 -0400
> +++ linux-2.6.11.9-fixes/drivers/acpi/tables/tbxfroot.c	2005-05-16 16:5=
1:33.115768232 -0400
> @@ -313,7 +313,9 @@ acpi_get_firmware_table (
> =20
>=20
>  cleanup:
> -	acpi_os_unmap_memory (rsdt_info->pointer, (acpi_size) rsdt_info->poin=
ter->length);
> +	if (rsdt_info->pointer) {
> +		acpi_os_unmap_memory (rsdt_info->pointer, (acpi_size) rsdt_info->poi=
nter->length);
> +	}
>  	ACPI_MEM_FREE (rsdt_info);
> =20
>  	if (header) {
>=20
>=20
> Signed-Off-by: ydroneaud-4qZELD6FgxhWk0Htik3J/w@public.gmane.org
>=20
--=20
S=E9rgio M.B.



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=3D7412&alloc_id=3D16344&op=3Dclick
