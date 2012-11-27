From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 01/15] ACPICA: Fixes unmerged (dis)assember divergences.
Date: Tue, 27 Nov 2012 05:41:47 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD380D@SHSMSX101.ccr.corp.intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
 <d78f5a439b768067790ec4f07af70185484deccd.1353491652.git.lv.zheng@intel.com>
 <1A7043D5F58CCB44A599DFD55ED4C94828D4CE6B@FMSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:64747 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022Ab2K0Flv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Nov 2012 00:41:51 -0500
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C94828D4CE6B@FMSMSX108.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

I agreed.
It's assembler and disassembler specific changes.
Fixing them will make release engineering a easier process.
But adding this header file does not do much help on reducing the divergences.

Best regards/Lv Zheng

> -----Original Message-----
> From: Brown, Len
> Sent: Tuesday, November 27, 2012 10:59 AM
> To: Zheng, Lv; Wysocki, Rafael J
> Cc: linux-acpi@vger.kernel.org
> Subject: RE: [PATCH 01/15] ACPICA: Fixes unmerged (dis)assember
> divergences.
> 
> >  drivers/acpi/acpica/acdisasm.h |  641
> ++++++++++++++++++++++++++++++++++++++++
> 
> please do not include this file in the linux kenrel.
> 
> thanks,
> -Len
