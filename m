From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 4/6] ACPI: show dynamic ACPI tables
Date: Tue, 14 Oct 2008 09:43:06 +0800
Message-ID: <1223948586.2735.244.camel@rzhang-dt>
References: <1223885414.2735.187.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1224 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755747AbYJNBqJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Oct 2008 21:46:09 -0400
In-Reply-To: <1223885414.2735.187.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "nokos@gmx.net" <nokos@gmx.net>

oops. there is still one case that this patch doesn't cover.

if the Load instruction is in the _INI method which means that the tabl=
e
is loaded before the gbl table handler is registered, the current code
will recognize it as a static table. :(
I'm not able to fix this issue without changing a lot of ACPICA code.
A temporary fix is removing the "_dynamic" suffix.

Peter says that "=EF=BB=BFSince it is only additional information I wou=
ld prefer
keeping it and live with the occasional false positive (of almost stati=
c
tables)."

what do you think?

thanks,
rui

On Mon, 2008-10-13 at 02:10 -0600, Zhang, Rui wrote:
> Some ACPI tables are loaded at runtime.
> create sysfs I/F for these dynamic tables in /sys/firmware/acpi/table=
s/.
>=20
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/system.c |   56 +++++++++++++++++++++++++++++++++++++++=
+----------
>  1 file changed, 45 insertions(+), 11 deletions(-)
>=20
> Index: linux-acpi-2.6/drivers/acpi/system.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-acpi-2.6.orig/drivers/acpi/system.c
> +++ linux-acpi-2.6/drivers/acpi/system.c
> @@ -100,7 +100,6 @@ static ssize_t acpi_table_show(struct ko
>  static void acpi_table_attr_init(struct acpi_table_attr *table_attr,
>                                  struct acpi_table_header *table_head=
er)
>  {
> -       struct acpi_table_header *header =3D NULL;
>         struct acpi_table_attr *attr =3D NULL;
>=20
>         memcpy(table_attr->name, table_header->signature, ACPI_NAME_S=
IZE);
> @@ -113,15 +112,9 @@ static void acpi_table_attr_init(struct
>         }
>         table_attr->instance++;
>=20
> -       if (table_attr->instance > 1 || (table_attr->instance =3D=3D =
1 &&
> -                                        !acpi_get_table(table_header=
->
> -                                                        signature, 2=
,
> -                                                        &header)))
> +       if (table_attr->instance > 1)
>                 sprintf(table_attr->name + 4, "%d", table_attr->insta=
nce);
>=20
> -       if (table_attr->flag)
> -               strncat(table_attr->name, "_inactive",
> -                               ACPI_TABLE_NAME_MAX - strlen(table_at=
tr->name));
>         table_attr->attr.size =3D 0;
>         table_attr->attr.read =3D acpi_table_show;
>         table_attr->attr.attr.name =3D table_attr->name;
> @@ -131,6 +124,42 @@ static void acpi_table_attr_init(struct
>         return;
>  }
>=20
> +static acpi_status
> +acpi_sysfs_table_handler(u32 event, void *table, void *context)
> +{
> +       struct acpi_table_attr *table_attr =3D NULL;
> +
> +       switch (event) {
> +       case ACPI_TABLE_EVENT_LOAD:
> +               table_attr =3D
> +                       kzalloc(sizeof(struct acpi_table_attr), GFP_K=
ERNEL);
> +               if (!table_attr)
> +                       return AE_NO_MEMORY;
> +
> +               acpi_table_attr_init(table_attr, table);
> +               strncat(table_attr->name, "_dynamic",
> +                       ACPI_TABLE_NAME_MAX - strlen(table_attr->name=
));
> +
> +               if (sysfs_create_bin_file(tables_kobj, &table_attr->a=
ttr)) {
> +                       kfree(table_attr);
> +                       return AE_ERROR;
> +               } else
> +                       list_add_tail(&table_attr->node,
> +                                       &acpi_table_attr_list);
> +               break;
> +       case ACPI_TABLE_EVENT_UNLOAD:
> +               /*
> +                * we do not need to do anything right now
> +                * because the table is not deleted from the
> +                * global table list when unloading it.
> +                */
> +               break;
> +       default:
> +               return AE_BAD_PARAMETER;
> +       }
> +       return AE_OK;
> +}
> +
>  static int acpi_system_sysfs_init(void)
>  {
>         struct acpi_table_attr *table_attr;
> @@ -162,12 +191,16 @@ static int acpi_system_sysfs_init(void)
>                         if (!table_attr)
>                                 return -ENOMEM;
>=20
> -                       if (!active_tables) {
> +                       if (!active_tables)
>                                 table_attr->flag =3D ACPI_TABLE_INACT=
IVE;
> -                               table_attr->table_index =3D table_ind=
ex;
> -                       }
> +
> +                       table_attr->table_index =3D table_index;
>                         table_index++;
>                         acpi_table_attr_init(table_attr, table_header=
);
> +                       if (!active_tables)
> +                               strncat(table_attr->name, "_inactive"=
,
> +                                               ACPI_TABLE_NAME_MAX -
> +                                               strlen(table_attr->na=
me));
>=20
>                         result =3D
>                             sysfs_create_bin_file(tables_kobj,
> @@ -189,6 +222,7 @@ static int acpi_system_sysfs_init(void)
>                 }
>         } while (!result);
>         kobject_uevent(tables_kobj, KOBJ_ADD);
> +       acpi_gbl_table_handler =3D acpi_sysfs_table_handler;
>=20
>         return 0;
>  }
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
