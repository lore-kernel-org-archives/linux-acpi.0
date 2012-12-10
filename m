From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 01/15] ACPICA: Fixes unmerged (dis)assember divergences.
Date: Mon, 10 Dec 2012 08:54:22 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD7D8D@SHSMSX101.ccr.corp.intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
 <d78f5a439b768067790ec4f07af70185484deccd.1353491652.git.lv.zheng@intel.com>
 <1A7043D5F58CCB44A599DFD55ED4C94828D4CE6B@FMSMSX108.amr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E88BD7D56@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44613 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777Ab2LJIyZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Dec 2012 03:54:25 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88BD7D56@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Hi, I can offer detailed proof hereafter:

After I reverted the acdisasm.h inclusion and refreshed all of the release patches, I could found the following differences between the final patches and the linuxize.sh generated ones:

PATCH 06 - 15 are marked as 20121114-01 -> 10 in my quilt stack.

release patches
patch name (acpica)	state	patch diff lines
20121114-01.patch(01)	100%	0
20121114-02.patch(02)	100%	0
20121114-03.patch(07)	100%	1 (indent)
20121114-04.patch(10)	100%	10 (acdisasm) + 7 (context)
20121114-05.patch(13)	100%	0
20121114-06.patch(15)	100%	0
20121114-07.patch(17)	100%	1 (indent)
20121114-08.patch(18)	100%	0
20121114-09.patch(19)	100%	0
20121114-10.patch(30)	100%	2 (include)

20121114-03.patch:
> -acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
> +acpi_ut_evaluate_object(struct acpi_namespace_node * prefix_node,

This is there due to the indentation divergences fixes which are not what I'm worrying about.

20121114-04.patch:
> - * dmextern
> + * dmdeferred
> +acpi_status acpi_dm_parse_deferred_ops(union acpi_parse_object *root);
> +/*
> + * dmextern
> + */
> -acpi_status acpi_dm_is_resource_template(union acpi_parse_object *op);
> +acpi_status
> +acpi_dm_is_resource_template(struct acpi_walk_state *walk_state,
> +			     union acpi_parse_object *op);
<  			   acpi_walk_aml_callback user_function,
<  			   void **context);
>  			   acpi_walk_aml_callback user_function, void *context);
<  			   acpi_walk_aml_callback user_function, void **context)
>  			   acpi_walk_aml_callback user_function, void *context)
<  					    (void **)end_tag);
>  					    end_tag);

10 lines are caused by lacking of acdisasm.h and 7 lines are caused by (void **) fixes. The latter will be seen in the next acpica release which is not what I'm worrying about.
I just care about the acdisasm.h, if it is included, my life can be easier and it will not be a trouble for the developers currently using ACPICA in the community.

20121114-07.patch:
<  			    (u16) (aml_length +
>  			    (u16)(aml_length +

This is there due to the indentation divergences fixes which are not what I'm worrying about.

20121114-10.patch:
<  #include <acpi/acconfig.h>
<  #include <acpi/actypes.h>
>  #include "acconfig.h"
>  #include "actypes.h"

This is there due to the header inclusion changes which are not what I'm worrying about.

Best regards
-Lv

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org
> [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Zheng, Lv
> Sent: Monday, December 10, 2012 4:24 PM
> To: Brown, Len; Wysocki, Rafael J
> Cc: linux-acpi@vger.kernel.org
> Subject: RE: [PATCH 01/15] ACPICA: Fixes unmerged (dis)assember
> divergences.
> 
> Hi, Len and Rafael
> 
> Please also look at the [PATCH 09/15] ACPICA: Debugger: Major update for the
> Disassemble<method> command.
> 
> There is acdisasm.h updates in the patch 09.
> If we can introduce acdisasm.h into linux but surround it with #ifdef/#endif to
> make it compiled out, then no manual fixes are needed for the [PATCH 09/15]
> thus less bugs in release process, Or fixes are needed to be included as a
> special case in the acpica release scripts.
> 
> Please think about the benefit of adding this file.
> I'm waiting for the decision on this.
> 
> Best regards
> -Lv
> 
> > -----Original Message-----
> > From: Brown, Len
> > Sent: Tuesday, November 27, 2012 10:59 AM
> > To: Zheng, Lv; Wysocki, Rafael J
> > Cc: linux-acpi@vger.kernel.org
> > Subject: RE: [PATCH 01/15] ACPICA: Fixes unmerged (dis)assember
> > divergences.
> >
> > >  drivers/acpi/acpica/acdisasm.h |  641
> > ++++++++++++++++++++++++++++++++++++++++
> >
> > please do not include this file in the linux kenrel.
> >
> > thanks,
> > -Len
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
