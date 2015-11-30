From: Daniel J Blueman <daniel@numascale.com>
Subject: RE: overriding ACPI _CRS method
Date: Mon, 30 Nov 2015 11:23:21 +0800
Message-ID: <1448853801.18315.0@outlook-emeawest.office365.com>
References: <1448794735.18592.0@outlook-emeawest.office365.com>
	<1AE640813FDE7649BE1B193DEA596E883BAFA0F9@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-am1on0105.outbound.protection.outlook.com ([157.56.112.105]:4500
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750736AbbK3DXl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Nov 2015 22:23:41 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BAFA0F9@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steffen Persvold <sp@numascale.com>, Myron Stowe <myron.stowe@redhat.com>

On Mon, Nov 30, 2015 at 11:09 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi,
> 
> IMO, if you want the new _CRS to be applied during the Linux early 
> boot stage, you can override the table using initrd override or DSDT 
> override mechanism.
> Please see Documentation/acpi/initrd_table_override.txt or 
> Documentation/acpi/dsdt-override.txt.
> 
> If you want the new _CRS to be applied during Linux runtime, you can 
> override it using method customization mechanism.
> Please see Documentation/acpi/method-customizing.txt

The reason I'm trying to adjust this in firmware, is to deliver the 
right behaviour with pre-built/distro kernels, so I can't use that 
approach.

Thanks Lv,
  Daniel

