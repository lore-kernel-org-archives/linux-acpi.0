From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Suspend issue on ancient asus A7V system
Date: Tue, 22 Apr 2008 15:33:50 +0800
Message-ID: <1208849630.3550.42.camel@rzhang-1.sh.intel.com>
References: <20080421093641.GD20322@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35913 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755284AbYDVHfR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Apr 2008 03:35:17 -0400
In-Reply-To: <20080421093641.GD20322@zoy.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michel Lespinasse <walken@zoy.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>


On Mon, 2008-04-21 at 02:36 -0700, Michel Lespinasse wrote:
> Hi,
> 
> I'm having a minor issue getting suspend to ram to work on an old
> asus A7V based system: the system does suspend (I can hear the fans
> go off etc...) but it immediately resumes.
> 
> I do have a workaround though: After booting, this system shows in
> /proc/acpi/wakeup:
> Device  S-state   Status   Sysfs node
> PWRB      S5    *enabled   
> PCI0      S4     disabled  no-bus:pci0000:00
> USB0      S4     disabled  pci:0000:00:04.2
> USB1      S4     disabled  pci:0000:00:04.3
> 
> If I run echo PWRB > /proc/acpi/wakeup,
> 
> 1- the kernel complains that "ACPI: 'PCI0' and 'PWRB' have the same GPE,
>    can't disable/enable one seperately"
> 
> 2- /proc/acpi/wakeup now shows:
> Device  S-state   Status   Sysfs node
> PWRB      S5    *disabled  
> PCI0      S4     disabled  no-bus:pci0000:00
> USB0      S4     disabled  pci:0000:00:04.2
> USB1      S4     disabled  pci:0000:00:04.3

What can you see in /proc/acpi/wakeup if you run "echo PWRB
> /proc/acpi/wakeup" again?

Please open a bug at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the acpidump output there.

thanks,
rui

> 
> 3- The system can now be suspended, and it will
>    resume normally when I press the power button.
> 
> This is not a recent regression, that system has been like that since
> I first got suspend working.
> 
> Hope this helps. I can collect additional information if you tell me how.
> 
> Cheers,
> 

