From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: sysfs regression on Supermicro X7DB8+ (was Re: ACPICA 20061109
	regression on Supermicro X7DB8+)
Date: Mon, 18 Dec 2006 09:35:05 +0800
Message-ID: <1166405705.27721.1.camel@sli10-conroe.sh.intel.com>
References: <58A36151585E4047913F40517D307BAE0171CD@pdsmsx404.ccr.corp.intel.com>
	 <200612170135.29010.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30172 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbWLRBgJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Dec 2006 20:36:09 -0500
In-Reply-To: <200612170135.29010.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Sun, 2006-12-17 at 01:35 -0500, Len Brown wrote:
> > Len, can you show me the ACPIDUMP and dmesg of 2.6.20-rc1 with this debug patch please?
> 
> lets work this here:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=7695
Looks we can't use if the device has _PRT to determine if it's a pci
bridge. We'll look at if there is better solution for pci driver.

Thanks,
Shaohua
