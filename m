From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Thermal Zones and Throttling
Date: Fri, 13 Apr 2007 09:38:10 +0800
Message-ID: <1176428290.29594.18.camel@localhost.localdomain>
References: <11b141710704121410j16011387q4640f07f1e27a85f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45651 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbXDMBjP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Apr 2007 21:39:15 -0400
In-Reply-To: <11b141710704121410j16011387q4640f07f1e27a85f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Paulo J. Matos" <pocm@soton.ac.uk>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

HI, Paulo,

On Thu, 2007-04-12 at 22:10 +0100, Paulo J. Matos wrote:
> Hello,
> 
> I'm almost sure by laptop is burning [almost] and yet, no throttling
> change is happening.
> The only wierd thing I can find is the fact that:
> euler ~ # cat /proc/acpi/processor/CPU0/info
> processor id:            0
> acpi id:                 0
> bus mastering control:   yes
> power management:        yes
> throttling control:      yes
> limit interface:         yes
> euler ~ # cat /proc/acpi/processor/CPU0/throttling
> state count:             4
> active state:            T0
> states:
>    *T0:                  00%
>     T1:                  25%
>     T2:                  50%
>     T3:                  75%
> euler ~ # ls -la /proc/acpi/thermal_zone/
> total 0
> dr-xr-xr-x  2 root root 0 Apr 12 22:07 .
> dr-xr-xr-x 10 root root 0 Apr 12 15:26 ..
> 
> Isn't it wierd that although I have throttling control, there are no
> thermal zones?
> 
Please attach the acpidump file of your laptop.
Or you can file a bug report at bugzilla.kernel.org and attach the
acpidump there, so that we can track it better. :)

Thanks,
Ray
