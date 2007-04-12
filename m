From: "Paulo J. Matos" <pocm@soton.ac.uk>
Subject: Thermal Zones and Throttling
Date: Thu, 12 Apr 2007 22:10:27 +0100
Message-ID: <11b141710704121410j16011387q4640f07f1e27a85f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:44113 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbXDLVKa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Apr 2007 17:10:30 -0400
Received: by wx-out-0506.google.com with SMTP id h31so680748wxd
        for <linux-acpi@vger.kernel.org>; Thu, 12 Apr 2007 14:10:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I'm almost sure by laptop is burning [almost] and yet, no throttling
change is happening.
The only wierd thing I can find is the fact that:
euler ~ # cat /proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        yes
throttling control:      yes
limit interface:         yes
euler ~ # cat /proc/acpi/processor/CPU0/throttling
state count:             4
active state:            T0
states:
   *T0:                  00%
    T1:                  25%
    T2:                  50%
    T3:                  75%
euler ~ # ls -la /proc/acpi/thermal_zone/
total 0
dr-xr-xr-x  2 root root 0 Apr 12 22:07 .
dr-xr-xr-x 10 root root 0 Apr 12 15:26 ..

Isn't it wierd that although I have throttling control, there are no
thermal zones?

I'm almost sure throttling should be activated... my laptop is
practically burning my hands as I write this.... Is there anything I
can check out?

Cheers,
-- 
Paulo Jorge Matos - pocm at soton.ac.uk
http://www.personal.soton.ac.uk/pocm
PhD Student @ ECS
University of Southampton, UK
