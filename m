From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 05/14] ACPICA: Debugger: Prevent possible command line
 buffer overflow.
Date: Tue, 17 Sep 2013 19:31:26 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C948452754E1@FMSMSX106.amr.corp.intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
	<31cb81fe6434a1cbb35360798d3f8f8579350e5d.1377844863.git.lv.zheng@intel.com>
 <CAJvTdKmdXehe=fy-p+_gktaPBQYH_XWUd=PbCybVK-SVQ=Uiqg@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E8802463FB4@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9246 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753718Ab3IQTb2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Sep 2013 15:31:28 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802463FB4@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

> Currently, kernel behaviors are not affected by this patch.

This is exactly what you want to write in the commit message.

Imagine, for a minute, a distro scanning thousands of
patches and reading the title of this one -- they would
be alarmed by the phrase "buffer overflow" on a kernel patch --
so you need to tell them not to be alarmed.

thanks,
-Len

