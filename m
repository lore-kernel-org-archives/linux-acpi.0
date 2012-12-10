From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 01/15] ACPICA: Fixes unmerged (dis)assember divergences.
Date: Mon, 10 Dec 2012 08:23:32 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD7D56@SHSMSX101.ccr.corp.intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
 <d78f5a439b768067790ec4f07af70185484deccd.1353491652.git.lv.zheng@intel.com>
 <1A7043D5F58CCB44A599DFD55ED4C94828D4CE6B@FMSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61144 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab2LJIXh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Dec 2012 03:23:37 -0500
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C94828D4CE6B@FMSMSX108.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Len and Rafael

Please also look at the [PATCH 09/15] ACPICA: Debugger: Major update for the Disassemble<method> command.

There is acdisasm.h updates in the patch 09.
If we can introduce acdisasm.h into linux but surround it with #ifdef/#endif to make it compiled out, then no manual fixes are needed for the [PATCH 09/15] thus less bugs in release process,
Or fixes are needed to be included as a special case in the acpica release scripts.

Please think about the benefit of adding this file.
I'm waiting for the decision on this.

Best regards
-Lv

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
