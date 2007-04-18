From: Len Brown <lenb@kernel.org>
Subject: Re: Thermal Zones and Throttling
Date: Tue, 17 Apr 2007 23:03:46 -0400
Message-ID: <200704172303.46321.lenb@kernel.org>
References: <11b141710704121410j16011387q4640f07f1e27a85f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53704 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965427AbXDRDFO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Apr 2007 23:05:14 -0400
In-Reply-To: <11b141710704121410j16011387q4640f07f1e27a85f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Paulo J. Matos" <pocm@soton.ac.uk>
Cc: linux-acpi@vger.kernel.org

On Thursday 12 April 2007 17:10, Paulo J. Matos wrote:
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
> I'm almost sure throttling should be activated... my laptop is
> practically burning my hands as I write this.... Is there anything I
> can check out?

Cat /proc/cpuinfo will tell if the hardware has automatic throttling
for thermal emergencies.

However, the real question is why you're having a thermal emergency
in the first place.  Is there dust blocking the fan?

-Len
