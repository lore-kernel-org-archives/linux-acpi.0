From: Andrew Morton <akpm@osdl.org>
Subject: Fw: PROBLEM: HP dv6000z Laptop ACPI/nVidia/bcm43xx issues
Date: Sat, 2 Sep 2006 11:13:24 -0700
Message-ID: <20060902111324.102387ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:20401 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750861AbWIBSN1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Sep 2006 14:13:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: M W <wumarkus@hotmail.com>



Begin forwarded message:

Date: Sat, 2 Sep 2006 14:04:51 -0400
From: "M W" <wumarkus@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: HP dv6000z Laptop ACPI/nVidia/bcm43xx issues


Upon boot-up, I am seeing the following error message on both 2.16 and 2.17
kernels (32 or 64 bit):
 
PCI: Failed to allocate mem resource #6:20000@e0000000 for 0000:05:00.0
 
I am also unable to boot the system properly unless I boot with "acpi=off"
This may be related to my bcm43xx wireless card that I have been unable to
get working properly both with the native driver or ndiswrapper. 
 
Here is the information on my system:
HP dv6000z Laptop (just released in the past month)
AMD Turion x64 ML-52
nVidia nForce chipset (410/430?)
nVidia GeForce Go 7200 Video Chipset (256 "TurboCache)
Broadcom a/b/g wireless w/Bluetooth (bcm4306)
nVidia onboard NIC
Conexant HD audio? (works sometimes with generic nVidia driver in ubuntu)

I believe the mem resource issue may have something to do with the
"TurboCache" feature of the chipset, which I believe borrows some of the
system RAM. I can verify that the 000:05:00 address refers to the graphics
card. Also, there is a LED for the wireless functions, which stays blue
during boot-up with ACPI turned-on. When turned-off, the light stays red and
audio functions do not work.

I have tried several distributions (ubuntu, gentoo, suse) and have witnessed
this issue on all distributions (both the system lock-ups and the mem
resource message). Recompiling the kernel with the latest test build
resulted in the same issue, as well. At this point, I assume since this
hardware is so new that this is just a configuration that hasn't been
considered yet.


-- 
VGER BF report: U 0.500599
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-- 
VGER BF report: U 0.5
