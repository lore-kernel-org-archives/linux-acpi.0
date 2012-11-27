From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 12/15] ACPICA: Enhance the ACPI_GETx and ACPI_SETx
 macros.
Date: Tue, 27 Nov 2012 05:37:36 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD37FC@SHSMSX101.ccr.corp.intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
 <8173a1db72935a38cdfe1d27587166766d86f027.1353491653.git.lv.zheng@intel.com>
 <1A7043D5F58CCB44A599DFD55ED4C94828D4CED7@FMSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58355 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726Ab2K0Fhl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Nov 2012 00:37:41 -0500
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C94828D4CED7@FMSMSX108.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Yes, I've performed compilation and then compared the decompiled ones for these macro changes.
Thanks for mention this.

Best regards/Lv Zheng
> -----Original Message-----
> From: Brown, Len
> Sent: Tuesday, November 27, 2012 12:05 PM
> To: Zheng, Lv; Wysocki, Rafael J
> Cc: linux-acpi@vger.kernel.org; Moore, Robert
> Subject: RE: [PATCH 12/15] ACPICA: Enhance the ACPI_GETx and ACPI_SETx
> macros.
> 
> Thank you for verifying that this syntax change did not have any effect on the
> resulting binary!  That would be a great thing to note in patch check-in
> comments in the future:-)
> 
> thanks,
> -Len
