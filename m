From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: /proc/acpi/ removal plan
Date: Thu, 18 Sep 2008 15:39:34 +0800
Message-ID: <1221723574.3441.187.camel@rzhang-dt>
References: <200809180632.m8I6WMgr029637@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62584 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbYIRHkJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Sep 2008 03:40:09 -0400
In-Reply-To: <200809180632.m8I6WMgr029637@hera.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@hera.kernel.org>
Cc: linux-acpi@vger.kernel.org

On Thu, 2008-09-18 at 14:32 +0800, Len Brown wrote:
> Rui,
> Please look over these slides that I produced
> for the Linux Plumber's Conference showing
> where everything in /proc/acpi/ will go.
> 
> http://userweb.kernel.org/~lenb/doc/LPC2008-API-web/
> 
> Please let me know now if I've missed anything,
> for I'll be speaking to them in the morning.

Hi, len,

Page 7, processor throttling state I/F
As processor T-state is used for thermal control only,
processor t-state is mapped to a cooling_device's cooling_state
in the generic thermal driver, combined with the processor's p-state.
e.g.
# ls -l /sys/class/thermal/cooling_device0/
total 0
-rw-r--r-- 1 root root 4096 2008-09-18 15:20 cur_state
lrwxrwxrwx 1 root root    0 2008-09-18 15:20 device
-> ../../../devices/LNXSYSTM:00/ACPI0007:00   (it's a processor!!!)
-r--r--r-- 1 root root 4096 2008-09-18 15:20 max_state
drwxr-xr-x 2 root root    0 2008-09-18 15:20 power
lrwxrwxrwx 1 root root    0 2008-09-18 15:20 subsystem -> ../../thermal
-r--r--r-- 1 root root 4096 2008-09-18 15:20 type
-rw-r--r-- 1 root root 4096 2008-09-18 15:20 uevent

I'm not sure if we need another generic processor throttle control I/F.

Page 14, wakeup control,
/sys/devices/.../wakeup should be in the todo list. :)

Page 18, we should not put the video driver together with the platform
specific drivers?

Page 21, oops, I forget to add the dynamic tables... will do it soon, :)

Page 23, button sys I/F can be found at /sys/class/input/.
e.g.
# cat /sys/class/input/input*/device/hid 
LNXPWRBN
PNP0C0C

According to Alexey's comments, we don;t need sysfs I/F for ec.
some info like the data/command port address is printed in the dmesg
during ec initialization.
And I don't think we need to export the power resource device info to
user space.

thanks,
rui

