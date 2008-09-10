From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: linux-acpi-2.6/test on Thinkpad T61: Battery Absent
Date: Wed, 10 Sep 2008 17:22:02 +0800
Message-ID: <1221038522.3989.178.camel@yakui_zhao.sh.intel.com>
References: <1221027769.3958.1.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14074 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbYIJJH0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Sep 2008 05:07:26 -0400
In-Reply-To: <1221027769.3958.1.camel@hidalgo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: ACPI mailing list <linux-acpi@vger.kernel.org>

On Wed, 2008-09-10 at 08:22 +0200, Yves-Alexis Perez wrote:
> Hi,
> 
> I just pulled linux-acpi-2.6/test on my git tree, and rebuild the
> kernel, and now it doesn't detect any battery:
> 
> ACPI: Battery Slot [BAT0] (battery absent)
> 
> My tree is at faca89759dd7d4d87309f56cd09ae885a296fb4c and I'll try to
> bisect.
Can the battery be detected on the upstream kernel of 2.6.27-rc6? 
Please attach the output of acpidump, lspci -vxxx and dmesg.(Both dmesg
on acpi_test git tree and 2.6.27-rc6 are needed).
Thanks.
> 
> Cheers,

