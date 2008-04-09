From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC] [PATCH 0/3] several fixups about RTC alarm Sys I/F
Date: Wed, 09 Apr 2008 14:32:49 +0800
Message-ID: <1207722769.5997.14.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61859 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248AbYDIGky (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Apr 2008 02:40:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rui.zhang@intel.com, david-b@pacbell.net

Hi, all 
    The following patches are several fixups about RTC alarm sys I/F.
    
    Patch 1/3 : allow to override RTC alarm time
      In current kernel when RTC alarm time is set and not fired,
it is impossible to set RTC alarm again. But it is more
reasonable that the RTC alarm time can be overrided.
      At the same time a bug in cmos_set_alarm(driver/rtc/rtc-cmos.c)
is fixed.         
   
    Patch 2/3 : Call RTC wake_on hook function when alarm is enabled
    when RTC alarm is enabled, the rtc_wake_on hook function
should be called.( The Fixed_RTC event is enabled in the rtc_wake_on 
hook function of rtc-cmos)
    The Fixed_RTC event is enabled when the fixed rtc event handler is installed.
When RTC alarm is set, it will be fired for the first time.
After RTC alarm is fired, the fixed_RTC event is disabled. So in my test
 no RTC alarm is fired again if the rtc_wake_on hook function is not called. 
             
    Patch 3/4 : Add the support for alarm time relative to current RTC
time in sysfs
        In current kernel if we want to set the alarm time, the relative
time( the seconds relative to 1970-01-01 00:00:00) should be written
into/sys/class/rtc/rtc0/wakealarm. It is not convenient.
       It is more convenient to add the support for the alarm
time relative to current RTC time.(the unit is second) 
For example:
If the RTC is required to generate alarm after 2 minutes, the following
will be OK.
        echo +120 > /sys/class/rtc/rtc0/wakealarm
or 	echo +0x78 > /sys/class/rtc/rtc0/wakealarm
    
    Of course the old style is still supported.
    
Note: another question 
  There is another question about the driver rtc and rtc-cmos.
rtc driver is in drivers/char/ and rtc-cmos is in drivers/rtc/
On some laptops the two drivers will share the same memory/irq resource, which will cause
that rtc-cmos driver can't work well after the rtc driver is already loaded.(Of course RTC sys 
I/F isn't created.)
How to solve this issue? 


   Thank for the review.
   
Best regards 
   Yakui.


