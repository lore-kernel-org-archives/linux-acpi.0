From: yakui_zhao <yakui.zhao@intel.com>
Subject: a backlight issue
Date: Thu, 25 Jun 2009 10:09:09 +0800
Message-ID: <1245895749.7266.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:32398 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbZFYCIC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Jun 2009 22:08:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, rpurdie@linux.intel.com

Hi, Len
    
    On some boxes there is neither generic ACPI backlight I/F nor
platform backlight I/F. That means that the backlight brightness can't
be changed by using sys backlight I/F. But the backlight brightness can
be changed by using the driver backlight I/F. For example: on the box
based on intel-integrated graphics card the backlight brightness can
also be changed by using the LBB register in pci device. 
    Can the graphics driver register the sys backlight I/F so that we
can change the backlight by using sys I/F? 
    
    If the graphics driver can also register the backlight I/F, it seems
that we can register three types of backlight I/F.
    a. generic ACPI backlight I/F. This is registered by acpi video
driver.
    b. platform backlight I/F. This is registered by the platform driver
    c. graphics backlight I/F. This can be registered by the graphics
driver.

    As there exist three types of backlight I/F, how can we make the
coordination among the three backlight I/F? In fact only one backlight
I/f is enough for user to change the brightness.

Rui provides a propose that use the backlight manager to choose the
appropriate the backlight I/F. 
    backlight manager only exports one single I/F to users, like:
----|
    |----brightness
    |----actual_brightness
    |----max_brightness
    |----...
    |----mode
and it supports multiple modes, e.g.
1. generic ---ACPI
2. platform---platform drivers
3. legacy-----i915

The sysfs backlight manager always chooses the mode with highest
priority (generic > platform > legacy), and call the respective
callbacks when backlight is changed.
For example, the backlight manager switches to the "generic" mode from
"legacy" mode automatically when ACPI video driver is loaded at runtime.
  
   How about the above propose?

 
BTW: now in the video driver only one of acpi generic backlight I/F and
platform backlight I/F is registered. That means that the acpi generic
backlight I/F is preferred if it exists. Of course we can switch to the
platform backlight I/F by adding the boot option of
"acpi_backlight=vendor".  In summary, the platform driver will check
whether the acpi generic backlight is supported before registering the
platform backlight I/F.


Thanks.

   

