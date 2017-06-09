From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: Remove unnecessary call to debugger
Date: Fri, 9 Jun 2017 01:18:25 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CECBBA1@SHSMSX101.ccr.corp.intel.com>
References: <20170608213106.11982-1-kilobyte@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35593 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbdFIBSa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Jun 2017 21:18:30 -0400
In-Reply-To: <20170608213106.11982-1-kilobyte@angband.pl>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

Hi, Adam

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Adam
> Borowski
> Sent: Friday, June 9, 2017 5:31 AM
> To: Moore, Robert <robert.moore@intel.com>; Zheng, Lv <lv.zheng@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>; linux-acpi@vger.kernel.org;
> devel@acpica.org
> Cc: Adam Borowski <kilobyte@angband.pl>
> Subject: [PATCH] ACPICA: Remove unnecessary call to debugger
> 
> This is a port of https://github.com/acpica/acpica/commit/eaa455ac by
> Robert Moore to the kernel:
> 
> > This call was simply wrong, and resulted in a -1 index into the operand
> > stack.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=120351
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>

I think my first fix also worked and your test on bug 120351 was wrong.
I just added comment a moment ago.

However I just pushed the removal of the wrong debugging statement fix to the upstream.
It's really redundant, you need to enable the log and check them.

The patch has already been sent here:
https://patchwork.kernel.org/patch/9765837/
So you don't have to send it again.

Thanks
Lv

> You guys fixed this in your tool months ago, but it's still unfixed in the
> kernel.  Let's apply that patch, then.  The coding styles differ so much the
> patch is hardly recognizable, but it's a direct port.
> 
>  drivers/acpi/acpica/dsutils.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
> index 406edec20de7..0dabd9b95684 100644
> --- a/drivers/acpi/acpica/dsutils.c
> +++ b/drivers/acpi/acpica/dsutils.c
> @@ -633,15 +633,6 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
> 
>  		if ((op_info->flags & AML_HAS_RETVAL) ||
>  		    (arg->common.flags & ACPI_PARSEOP_IN_STACK)) {
> -			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
> -					  "Argument previously created, already stacked\n"));
> -
> -			acpi_db_display_argument_object(walk_state->
> -							operands[walk_state->
> -								 num_operands -
> -								 1],
> -							walk_state);
> -
>  			/*
>  			 * Use value that was already previously returned
>  			 * by the evaluation of this argument
> --
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
