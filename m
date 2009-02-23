From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: incorrect battery design capacity
Date: Mon, 23 Feb 2009 16:58:02 +0800
Message-ID: <1235379482.5789.1.camel@localhost.localdomain>
References: <1235377098.7046.20.camel@kocour>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31714 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbZBWIqb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Feb 2009 03:46:31 -0500
In-Reply-To: <1235377098.7046.20.camel@kocour>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jachym Cepicky <jachym.cepicky@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2009-02-23 at 16:18 +0800, Jachym Cepicky wrote:
> Hi, 
> if I'm in wrong mailing list, my apologizes, plese point me to the right
> one.
>  
> It is truth, that my laptop is about 3 years old, and so, I can not
> expect  miracles from my battery, however, I would call this an bug:
> 
> I have HP Compaq nx6125 and on the battery it is written, that it is
> 10.8V - 4.8 Ahr, which I understand, that capacity of my battery is 4800
> mAh. 
> 
> However,  cat /proc/acpi/battery/C179/info 
> present:                 yes
> design capacity:         638 mAh
It seems that the design capacity is not very correct.
Will you please try the latest kernel and see whether the battery design
capacity can be reported correctly?
Of course please also attach the output of acpidump.
Thanks.
> last full capacity:      638 mAh
> battery technology:      rechargeable
> design voltage:          11100 mV
> design capacity warning: 32 mAh
> design capacity low:     7 mAh
> capacity granularity 1:  100 mAh
> capacity granularity 2:  100 mAh
> model number:            Primary
> serial number:           03740 2006/01/12
> battery type:            LIon
> OEM info:                Hewlett-Packard
> 
> The last full/design capacity ratio is (after 3 years) impressive. But I
> would expect the design capacity little bit (about 7.5x?) higher. 
> 
> Is it the bug of acpi? Kernel? Do I have to buy me a new battery?  Can I
> set somehow design capacity by hand?
> 
> Linux kocour 2.6.27-11-generic #1 SMP Thu Jan 29 19:24:39 UTC 2009 i686
> GNU/Linux
> Ubuntu 8.10
> acpi 1.1
> 
> Thanks
> 
> Jachym

