From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 1/5] ACPICA: Namespace: Fix a regression that MLC
 support triggers dead lock in dynamic table loading
Date: Mon, 20 Jun 2016 13:57:01 +0300
Message-ID: <20160620105701.GI1739@lahna.fi.intel.com>
References: <0e65135af51d94db0410c7059f3bc3a2300fc3b5>
 <cover.1466413497.git.lv.zheng@intel.com>
 <7422eb351c933c167893534ef7a113220d80dc64.1466413497.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:46027 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871AbcFTK5i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Jun 2016 06:57:38 -0400
Content-Disposition: inline
In-Reply-To: <7422eb351c933c167893534ef7a113220d80dc64.1466413497.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Jun 20, 2016 at 05:07:22PM +0800, Lv Zheng wrote:
> The new MLC approach invokes MLC per-table basis. But the dynamic loa=
ding
> support of this is incorrect because of the lock order:
>  acpi_ns_evaluate
>    acpi_ex_enter_intperter
>      acpi_ns_load_table (triggered by Load opcode)
>        acpi_ns_exec_module_code_list
>          acpi_ex_enter_intperter
> The regression is introduced by the following commit:
>   Commit: 2785ce8d0da1cac9d8f78615e116cf929e9a9123
>   ACPICA Commit: 071eff738c59eda1792ac24b3b688b61691d7e7c
>   Subject: ACPICA: Add per-table execution of module-level code
> This patch fixes this regression by unlocking the interpreter lock be=
fore
> invoking MLC. However the unlocking is done to the acpi_ns_load_table=
(), in
> which, the interpreter lock should be locked by acpi_ns_parse_table()=
 but
> wasn't. Reported by Mika Westerberg. Fixed by Lv Zheng.
>=20
> Fixes: 2785ce8d0da1 ("ACPICA: Add per-table execution of module-level=
 code")
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/acpica/exconfig.c |    2 ++
>  drivers/acpi/acpica/nsparse.c  |    8 ++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exc=
onfig.c
> index a1d177d..21932d6 100644
> --- a/drivers/acpi/acpica/exconfig.c
> +++ b/drivers/acpi/acpica/exconfig.c
> @@ -108,7 +108,9 @@ acpi_ex_add_table(u32 table_index,
> =20
>  	/* Add the table to the namespace */
> =20
> +	acpi_ex_exit_interpreter();
>  	status =3D acpi_ns_load_table(table_index, parent_node);
> +	acpi_ex_enter_interpreter();
>  	if (ACPI_FAILURE(status)) {
>  		acpi_ut_remove_reference(obj_desc);
>  		*ddb_handle =3D NULL;
> diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nspa=
rse.c
> index f631a47..0d29383 100644
> --- a/drivers/acpi/acpica/nsparse.c
> +++ b/drivers/acpi/acpica/nsparse.c
> @@ -170,6 +170,8 @@ acpi_ns_parse_table(u32 table_index, struct acpi_=
namespace_node *start_node)
> =20
>  	ACPI_FUNCTION_TRACE(ns_parse_table);
> =20
> +	acpi_ex_enter_interpreter();

I'm getting these:

drivers/acpi/acpica/nsparse.c: In function =E2=80=98acpi_ns_parse_table=
=E2=80=99:
drivers/acpi/acpica/nsparse.c:173:2: error: implicit declaration of fun=
ction =E2=80=98acpi_ex_enter_interpreter=E2=80=99 [-Werror=3Dimplicit-f=
unction-declaration]
  acpi_ex_enter_interpreter();
  ^
drivers/acpi/acpica/nsparse.c:210:2: error: implicit declaration of fun=
ction =E2=80=98acpi_ex_exit_interpreter=E2=80=99 [-Werror=3Dimplicit-fu=
nction-declaration]
  acpi_ex_exit_interpreter();
  ^
cc1: some warnings being treated as errors

Do I need to have some other patch applied before this?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
