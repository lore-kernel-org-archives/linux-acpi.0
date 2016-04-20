From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPICA / Interpreter: Fix a regression triggered because
 of wrong Linux ECDT support
Date: Wed, 20 Apr 2016 12:27:17 +0200
Message-ID: <CAJZ5v0i32aQet6vc2o12E6K6F3vcnqQMymu=O3oy-aeHhB+=FQ@mail.gmail.com>
References: <1461119996-1861-1-git-send-email-lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36096 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188AbcDTK1T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Apr 2016 06:27:19 -0400
In-Reply-To: <1461119996-1861-1-git-send-email-lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Stable <stable@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Apr 20, 2016 at 4:39 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> 4.5-stable review patch. If anyone has any objects, please let me know.

This should be a request to the maintainers of -stable trees to apply
the following backport of a mainline commit.  Something like:

"Please take the following backport of mainline commit
5508df89756f8378024828e185724a9bd2348985 to the 4.5.y tree as it fixes
a regression introduced by commit
efaed9be998b5ae0afb7458e057e5f4402b43fa0 (ACPICA: Events: Enhance
acpi_ev_execute_reg_method() to  ensure no _REG evaluations can happen
during OS early boot stages)".

> ---------------
>
> From: Lv Zheng <lv.zheng@intel.com>
>
> commit 5508df89756f8378024828e185724a9bd2348985 upstream.
>
> It is reported that the following commit triggers regressions:
>  Linux commit: efaed9be998b5ae0afb7458e057e5f4402b43fa0
>  ACPICA commit: 31178590dde82368fdb0f6b0e466b6c0add96c57
>  Subject: ACPICA: Events: Enhance acpi_ev_execute_reg_method() to
>           ensure no _REG evaluations can happen during OS early boot
>           stages
>
> This is because that the ECDT support is not corrected in Linux, and Linux
> requires to execute _REG for ECDT (though this sounds so wrong), we need to
> ensure acpi_gbl_reg_methods_enabled is set before ECDT probing in order
> for _REG to be executed. Since we have to move
> "acpi_gbl_reg_methods_enabled = TRUE" to the initialization step
> happening before ECDT probing, acpi_load_tables() is the best candidate for
> now. Thus this patch fixes the regression by doing so.
>
> But if the ECDT support is fixed, Linux will not execute _REG for ECDT, and
> ECDT probing will happen before acpi_load_tables(). At that time, we still
> want to ensure acpi_gbl_reg_methods_enabled is set after executing
> acpi_ns_initialize_objects() (under the condition of
> acpi_gbl_group_module_level_code = FALSE), this patch also moves
> acpi_ns_initialize_objects() to acpi_load_tables() accordingly.
>
> Since acpi_ns_initialize_objects() doesn't seem to be skippable, this
> patch also removes ACPI_NO_OBJECT_INIT for the one invoked in
> acpi_load_tables(). Reported by Chris Bainbridge, Fixed by Lv Zheng.
>
> Fixes: efaed9be998b (ACPICA: Events: Enhance acpi_ev_execute_reg_method() to ensure no _REG evaluations can happen during OS early boot stages)
> Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpica/nsinit.c   |    2 ++
>  drivers/acpi/acpica/tbxfload.c |   14 ++++++++++++++
>  drivers/acpi/acpica/utxfinit.c |   25 +++++++++++--------------
>  3 files changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
> index bd75d46..ddb436f 100644
> --- a/drivers/acpi/acpica/nsinit.c
> +++ b/drivers/acpi/acpica/nsinit.c
> @@ -83,6 +83,8 @@ acpi_status acpi_ns_initialize_objects(void)
>
>         ACPI_FUNCTION_TRACE(ns_initialize_objects);
>
> +       ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
> +                         "[Init] Completing Initialization of ACPI Objects\n"));
>         ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
>                           "**** Starting initialization of namespace objects ****\n"));
>         ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> index 278666e..c37d479 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -83,6 +83,20 @@ acpi_status __init acpi_load_tables(void)
>                                 "While loading namespace from ACPI tables"));
>         }
>
> +       if (!acpi_gbl_group_module_level_code) {
> +               /*
> +                * Initialize the objects that remain uninitialized. This
> +                * runs the executable AML that may be part of the
> +                * declaration of these objects:
> +                * operation_regions, buffer_fields, Buffers, and Packages.
> +                */
> +               status = acpi_ns_initialize_objects();
> +               if (ACPI_FAILURE(status)) {
> +                       return_ACPI_STATUS(status);
> +               }
> +       }
> +
> +       acpi_gbl_reg_methods_enabled = TRUE;
>         return_ACPI_STATUS(status);
>  }
>
> diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
> index 721b87c..638fbd4 100644
> --- a/drivers/acpi/acpica/utxfinit.c
> +++ b/drivers/acpi/acpica/utxfinit.c
> @@ -267,7 +267,6 @@ acpi_status __init acpi_initialize_objects(u32 flags)
>          * initialized, even if they contain executable AML (see the call to
>          * acpi_ns_initialize_objects below).
>          */
> -       acpi_gbl_reg_methods_enabled = TRUE;
>         if (!(flags & ACPI_NO_ADDRESS_SPACE_INIT)) {
>                 ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
>                                   "[Init] Executing _REG OpRegion methods\n"));
> @@ -299,20 +298,18 @@ acpi_status __init acpi_initialize_objects(u32 flags)
>          */
>         if (acpi_gbl_group_module_level_code) {
>                 acpi_ns_exec_module_code_list();
> -       }
>
> -       /*
> -        * Initialize the objects that remain uninitialized. This runs the
> -        * executable AML that may be part of the declaration of these objects:
> -        * operation_regions, buffer_fields, Buffers, and Packages.
> -        */
> -       if (!(flags & ACPI_NO_OBJECT_INIT)) {
> -               ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
> -                                 "[Init] Completing Initialization of ACPI Objects\n"));
> -
> -               status = acpi_ns_initialize_objects();
> -               if (ACPI_FAILURE(status)) {
> -                       return_ACPI_STATUS(status);
> +               /*
> +                * Initialize the objects that remain uninitialized. This
> +                * runs the executable AML that may be part of the
> +                * declaration of these objects:
> +                * operation_regions, buffer_fields, Buffers, and Packages.
> +                */
> +               if (!(flags & ACPI_NO_OBJECT_INIT)) {
> +                       status = acpi_ns_initialize_objects();
> +                       if (ACPI_FAILURE(status)) {
> +                               return_ACPI_STATUS(status);
> +                       }
>                 }
>         }
>
> --
> 1.7.10
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
