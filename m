From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI reads wrong temperature
Date: Thu, 6 Nov 2008 09:11:26 +0000
Message-ID: <20081106091126.GA25849@srcf.ucam.org>
References: <20081031210913.3180@gmx.net> <20081102092541.GE10983@srcf.ucam.org> <20081102113112.316040@gmx.net> <1225677936.26020.17.camel@yakui_zhao.sh.intel.com> <20081103090153.250280@gmx.net> <9F0C1DB20AFA954FA1DA05309350433D3E5CA72D@pdsmsx503.ccr.corp.intel.com> <20081103145723.GB496@srcf.ucam.org> <alpine.LFD.2.00.0811031246550.3132@localhost.localdomain> <20081103174849.GA4285@srcf.ucam.org> <1225951972.3989.99.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36768 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbYKFJLe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 04:11:34 -0500
Content-Disposition: inline
In-Reply-To: <1225951972.3989.99.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>, Peter Mahlknecht <mali100@gmx.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Nov 06, 2008 at 02:12:52PM +0800, Zhao Yakui wrote:

> On your box after the i2c-i801 driver is loaded, the smbus controller
> will be used by the AML code and i2c-i801 driver. Unfortunately there is
> no synchronization between them. IMO this is the BIOS fault. The SMbus
> will be accessed by the two different modules. But it is exported by
> BIOS. 

No, loading i2c-i801 is harmless. The breakage occurs when you attempt 
to drive the smbus.

>     So the better solution is that:
>     a. SMBus is hidden in BIOS. In such case the Linux OS can't detect
> the SMbus controller . Of course it won't try to load the device driver
> for it. 
>     b. Linux OS won't load the device driver for it. 

The solution is for users not to load smbus drivers unless they know for 
certain that it's safe to do so, or alternatively for us to refuse to 
load i2c drivers if they overlap with ACPI resource allocations.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
