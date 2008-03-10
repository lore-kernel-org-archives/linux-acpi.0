From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: lenovo 3000 n100 thermal+hibernate
Date: Mon, 10 Mar 2008 09:25:47 +0800
Message-ID: <1205112347.4069.5.camel@yakui_zhao.sh.intel.com>
References: <200803091310.22074.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10567 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572AbYCJBee (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Mar 2008 21:34:34 -0400
In-Reply-To: <200803091310.22074.anarsoul@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sun, 2008-03-09 at 13:10 +0200, Vasily Khoruzhick wrote:
> Hi, I have problems with thermal module on lenovo 3000 n100,
> 
> Sometimes after resuming from suspend, 
> cat /proc/acpi/thermal_zone/TZ00/temperature says that CPU temp is 70 C and 
> fan blows cold air. But coretemp says that CPU temp is about 40 C. 
> 
> Also I get following message on dmesg:
> ACPI Exception (thermal-0471): AE_NOT_FOUND, Invalid active threshold [0] 
> [20070126]
> 
> Reloading of module doesn't help, and I have no such bug in windows. 
> I've tried kernels 2.6.20-2.6.24, and bug is present in all of them.
> 
> I can provide any additional info required ;)
> 
Please file a bug report here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

and attach the info you sent, plus the output from acpidump.

The acpidump tool can be downloaded from:
http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools-20071116.tar.bz2

Thanks.
> Regards
> Vasily
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

