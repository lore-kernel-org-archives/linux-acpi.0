From: "Andika Triwidada" <andika@gmail.com>
Subject: Battery 'present rate' display weirdness
Date: Fri, 27 Jul 2007 22:23:30 +0700
Message-ID: <7e0bae390707270823v3e80b72cmc0f4c665c3ce907f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:46134 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933463AbXG0PXf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jul 2007 11:23:35 -0400
Received: by wr-out-0506.google.com with SMTP id i30so508669wra
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jul 2007 08:23:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

My Acer Aspire 5580 shows normal info on discharging

andika@hokage:~$ cat /proc/acpi/battery/*/*
alarm:                   unsupported
present:                 yes
design capacity:         4000 mAh
last full capacity:      4131 mAh
battery technology:      rechargeable
design voltage:          11100 mV
design capacity warning: 300 mAh
design capacity low:     165 mAh
capacity granularity 1:  32 mAh
capacity granularity 2:  32 mAh
model number:            PRESPAL
serial number:           217
battery type:            LION
OEM info:                PANASONIC
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            2437 mA
remaining capacity:      448 mAh
present voltage:         10336 mV

But abnormal (?) one when charging:

andika@hokage:~$ cat /proc/acpi/battery/*/*
alarm:                   unsupported
present:                 yes
design capacity:         4000 mAh
last full capacity:      4131 mAh
battery technology:      rechargeable
design voltage:          11100 mV
design capacity warning: 300 mAh
design capacity low:     165 mAh
capacity granularity 1:  32 mAh
capacity granularity 2:  32 mAh
model number:            PRESPAL
serial number:           217
battery type:            LION
OEM info:                PANASONIC
present:                 yes
capacity state:          ok
charging state:          charging
present rate:            63418 mA
                         ^^^^^^^^
remaining capacity:      256 mAh
present voltage:         10640 mV

Does it need to be handled differently in battery.c or up to any
userspace tools to check 'charging state' and calculate proper (65535
- x) 'present rate'?

This is on kernel 2.6.22

TIA.

--
andika
