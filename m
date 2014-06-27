From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: Interrupt in ACPI driver?
Date: Fri, 27 Jun 2014 02:22:50 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026316CA@SHSMSX101.ccr.corp.intel.com>
References: <AA3DED1F9B922246BC60FBFF3BE7EA20F7DDF2@CRSMSX102.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:28875 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751733AbaF0CXA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jun 2014 22:23:00 -0400
In-Reply-To: <AA3DED1F9B922246BC60FBFF3BE7EA20F7DDF2@CRSMSX102.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Cazeao, Haroldo R" <haroldo.r.cazeao@intel.com>, Julian Wollrath <jwollrath@web.de>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, 

If you are going to write a driver using level-triggered GPEs, please wait until some useful GPE API fixes being merged.

Thanks and best regards
-Lv

> From: Cazeao, Haroldo R
> Sent: Friday, June 27, 2014 7:13 AM
> 
> All,
> For a given platform, the CPU and the PCH are being enumerated along the ACPI bus. We have been using polling for temperature
> thresholds trip points. Now, we are looking to use interrupts instead. I haven't seen too many examples of of acpi drivers with
> interrupts enabled. Any suggestions on where to start? Any templates I can use?
> 
> Thanks and regards,
> 
> 

