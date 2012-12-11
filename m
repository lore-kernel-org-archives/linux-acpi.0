From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 01/15] ACPICA: Fixes unmerged (dis)assember divergences.
Date: Tue, 11 Dec 2012 00:15:45 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD7E83@SHSMSX101.ccr.corp.intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
 <d78f5a439b768067790ec4f07af70185484deccd.1353491652.git.lv.zheng@intel.com>
 <1A7043D5F58CCB44A599DFD55ED4C94828D4CE6B@FMSMSX108.amr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E88BD7D56@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E88BD7D8D@SHSMSX101.ccr.corp.intel.com>
 <50C5DDEC.4070601@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:4645 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474Ab2LKAPu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Dec 2012 19:15:50 -0500
In-Reply-To: <50C5DDEC.4070601@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

> > 20121114-04.patch:
> >> - * dmextern
> >> + * dmdeferred
> >> +acpi_status acpi_dm_parse_deferred_ops(union acpi_parse_object
> >> +*root);
> >> +/*
> >> + * dmextern
> >> + */
> >> -acpi_status acpi_dm_is_resource_template(union acpi_parse_object
> >> *op);
> >> +acpi_status
> >> +acpi_dm_is_resource_template(struct acpi_walk_state *walk_state,
> >> +			     union acpi_parse_object *op);
> > <  			   acpi_walk_aml_callback user_function,
> > <  			   void **context);
> >>   			   acpi_walk_aml_callback user_function, void *context);
> > <  			   acpi_walk_aml_callback user_function, void **context)
> >>   			   acpi_walk_aml_callback user_function, void *context)
> > <  					    (void **)end_tag);
> >>   					    end_tag);
> > 10 lines are caused by lacking of acdisasm.h and 7 lines are caused by (void **)
> fixes. The latter will be seen in the next acpica release which is not what I'm
> worrying about.
> > I just care about the acdisasm.h, if it is included, my life can be easier and it
> will not be a trouble for the developers currently using ACPICA in the
> community.
> 
> But Len has told you very clearly not to include it.  This is not a Len's whim,
> there's a reason for that.
> 
> Is the reason not known to you or don't you agree with it?

I agreed w/ what we've been discussing about and reworked then found this.
I just wonder whether we could think about it from a different perspective.
Now we have the directory-by-directory "exceptions" maintained in the release scripts:
 common/compiler/debugger/disassembler/interpreter/os_specific/tools.
I just wonder do we need to maintain the file-by-file "exceptions" for the release process.
It will be convenient if there's no such exceptions, then ACPICA can freely manage the files under the "white listed" directories.

Best regards
-Lv
