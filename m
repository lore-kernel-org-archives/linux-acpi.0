From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 05/14] ACPICA: Debugger: Prevent possible command line
 buffer overflow.
Date: Mon, 23 Sep 2013 01:36:03 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802465271@SHSMSX101.ccr.corp.intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
	<31cb81fe6434a1cbb35360798d3f8f8579350e5d.1377844863.git.lv.zheng@intel.com>
 <CAJvTdKmdXehe=fy-p+_gktaPBQYH_XWUd=PbCybVK-SVQ=Uiqg@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E8802463FB4@SHSMSX101.ccr.corp.intel.com>
 <1A7043D5F58CCB44A599DFD55ED4C948452754E1@FMSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2066 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880Ab3IWBgH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Sep 2013 21:36:07 -0400
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C948452754E1@FMSMSX106.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

OK, I'll add this line to the subject.

Thanks and best regards
-Lv

> From: Brown, Len
> Sent: Wednesday, September 18, 2013 3:31 AM
> 
> > Currently, kernel behaviors are not affected by this patch.
> 
> This is exactly what you want to write in the commit message.
> 
> Imagine, for a minute, a distro scanning thousands of
> patches and reading the title of this one -- they would
> be alarmed by the phrase "buffer overflow" on a kernel patch --
> so you need to tell them not to be alarmed.
> 
> thanks,
> -Len

