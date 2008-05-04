From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: linux kernel 2.6.23+ can't restart
Date: Sun, 04 May 2008 17:24:35 +0800
Message-ID: <1209893075.28197.22.camel@yakui_zhao.sh.intel.com>
References: <481B5448.6060202@inl.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2116 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbYEDBd1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 May 2008 21:33:27 -0400
In-Reply-To: <481B5448.6060202@inl.gov>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shane Hansen <shane.hansen@inl.gov>
Cc: linux-acpi@vger.kernel.org

On Fri, 2008-05-02 at 11:50 -0600, Shane Hansen wrote:
> May  2 11:45:18 [kernel] ACPI: DMI Product Version:
> May  2 11:45:18 [kernel] ACPI: DMI Board Name: 0F9382
> May  2 11:45:18 [kernel] ACPI: DMI BIOS Vendor: Dell Inc.
> May  2 11:45:18 [kernel] ACPI: DMI BIOS Date: 12/13/2007
> 
> Since upgrading to the 2.6.23 / 2.6.24 kernels I can no longer "restart" 
> my system.  I can "shutdown" ok, the machine powers off just fine.  
> However when I try a "restart" the kernel goes through all the normal 
> stuff and then hangs on the line that says "Restarting System".  I have 
> to hold down the power button to power off the case...
Will you please confirm whether the system can be rebooted on the
previous kernel? For example: 2.6.20/21/22.

Will you please attach the output of acpidump?

It would be great if you can open a bug at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the acpidump/lspci -vxxx as attachments there.

thanks,
> 
> Suggestions?
> 

