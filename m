From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: controlling ACPI IRQ routing
Date: Wed, 02 Jan 2008 16:04:43 -0800
Message-ID: <477C269B.4080407@howardsilvan.com>
References: <47742083.5060903@howardsilvan.com>	 <1198814721.20418.3.camel@sli10-desk.sh.intel.com>	 <477489B8.20700@howardsilvan.com> <1198821979.20548.9.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from frodo.howardsilvan.com ([66.119.206.113]:46071 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbYACAEp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 19:04:45 -0500
In-Reply-To: <1198821979.20548.9.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org

Shaohua Li wrote:
> Currently vector is allocated when pci_enable_device is called. So which
> vector is allocated depends on how many drivers already called the
> routine. The first vector is 0x31, later higher priority (higher) vector
> will be allocated. In latest kernel, a vector of a irq could be variable
> when irq affinity is set, so it's much complex. There is no existing
> method to reserve a vector for a device.

The systems I've been using are all single-processor AMD x86 or x86_64 
systems.  So I doubt that IRQ affinity applies in these cases.

I've made the driver get "preloaded" through mkinitrd/initrd on 
boot-time, but that doesn't seem to make a difference in device performance.

Is it possible to see in 'dmesg' output which vector was allocated to 
which IRQ/device?

Thanks,

Lee.

