From: "Paulo J. Matos" <pocm@soton.ac.uk>
Subject: Losing battery power but computer is plugged in
Date: Thu, 12 Apr 2007 22:12:59 +0100
Message-ID: <11b141710704121412y53aca773x60f990bb38493c02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:45577 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbXDLVM7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Apr 2007 17:12:59 -0400
Received: by wx-out-0506.google.com with SMTP id h31so681334wxd
        for <linux-acpi@vger.kernel.org>; Thu, 12 Apr 2007 14:12:59 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello all,

[kernel 2.6.20]
I've looked at the battery dir and this seems odd:
euler ~ # cat /proc/acpi/ac_adapter/AC/state
state:                   on-line
euler ~ # cat /proc/acpi/battery/CMB1/info
present:                 yes
design capacity:         3800 mAh
last full capacity:      3800 mAh
battery technology:      rechargeable
design voltage:          10800 mV
design capacity warning: 0 mAh
design capacity low:     0 mAh
capacity granularity 1:  1 mAh
capacity granularity 2:  1 mAh
model number:            CP126160-XX / CP126162-XX
serial number:           1
battery type:            LION
OEM info:                Fujitsu
euler ~ # cat /proc/acpi/battery/CMB1/state
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            0 mA
remaining capacity:      3270 mAh
present voltage:         15807 mV

How am I plugged in but the battery is discharging... anyways, the
computer never powers down! :-)

Cheers,

-- 
Paulo Jorge Matos - pocm at soton.ac.uk
http://www.personal.soton.ac.uk/pocm
PhD Student @ ECS
University of Southampton, UK
