From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH][BUG] LoadTable() operator fails
Date: Fri, 7 Jan 2005 11:19:41 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E34E5A5@orsmsx403.amr.corp.intel.com>
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
To: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks, I will integrate into ACPICA
Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Kenji Kaneshige
> Sent: Thursday, January 06, 2005 6:15 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] [PATCH][BUG] LoadTable() operator fails
>=20
> Hi,
>=20
> My mailer inserted unnecessary line feeds into the patch.
> So I send it again.
>=20
> Thanks,
> Kenji Kaneshige
>=20
> Kenji Kaneshige wrote:
> > Hi,
> >
> > The execution of the LoadTable() operator might fail because of the
> > bug on OEM ID comparison. The following patch fixes this issue.
> >
> > Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
> >
> >
> > ---
> >
> >  linux-2.6.10-kanesige/drivers/acpi/tables/tbxfroot.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff -puN drivers/acpi/tables/tbxfroot.c~fix_acpi_tb_find_table
> > drivers/acpi/tables/tbxfroot.c
> > ---
linux-2.6.10/drivers/acpi/tables/tbxfroot.c~fix_acpi_tb_find_table
> > 2005-01-04 09:05:29.000000000 +0900
> > +++ linux-2.6.10-kanesige/drivers/acpi/tables/tbxfroot.c
2005-01-04
> > 09:05:29.000000000 +0900
> > @@ -114,8 +114,8 @@ acpi_tb_find_table (
> >
> >  	/* Check oem_id and oem_table_id */
> >
> > -	if ((oem_id[0]     && ACPI_STRCMP (oem_id, table->oem_id)) ||
> > -		(oem_table_id[0] && ACPI_STRCMP (oem_table_id, table-
> >oem_table_id))) {
> > +	if ((oem_id[0]     && ACPI_STRNCMP (oem_id, table->oem_id,
sizeof
> > (table->oem_id))) ||
> > +		(oem_table_id[0] && ACPI_STRNCMP (oem_table_id, table-
> >oem_table_id,
> > sizeof (table->oem_table_id)))) {
> >  		return_ACPI_STATUS (AE_AML_NAME_NOT_FOUND);
> >  	}
> >
> >
> > _
> >
> >
> > -------------------------------------------------------
> > The SF.Net email is sponsored by: Beat the post-holiday blues
> > Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> > It's fun and FREE -- well,
almost....http://www.thinkgeek.com/sfshirt
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
