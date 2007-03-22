From: Andrew Morton <akpm@linux-foundation.org>
Subject: Fw: Re: 2.6.21-rc4-mm1 + 4 hotfixes -- BUG: unable to handle kernel
 paging request at virtual address 6b6b6ceb -- EIP is at module_put+0x7/0x1f
Date: Thu, 22 Mar 2007 09:52:32 -0800
Message-ID: <20070322095232.f992794a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:42502 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934167AbXCVRwh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Mar 2007 13:52:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org, Greg KH <greg@kroah.com>


It looks like the cpuidle patches are doing incorrect things
with their kobject protocol.


Begin forwarded message:

Date: Thu, 22 Mar 2007 09:24:38 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: 2.6.21-rc4-mm1 + 4 hotfixes -- BUG: unable to handle kernel paging request at virtual address 6b6b6ceb -- EIP is at module_put+0x7/0x1f


I cannot reproduce the BUG with your ml.bz2 patch applied.
I am seeing this with both 2.6.21-rc4-mm1 + hotfixes, and with
2.6.21-rc4 + ml.bz2:

Mar 22 09:10:35 FractalPath kernel: ACPI: CPU0 (power states: C1[C1]
C2[C2] C3[C3])
Mar 22 09:10:35 FractalPath kernel: The kobject at, or inside
per_cpu__cpuidle_devices+0x40/0x558 is not dynamically allocated.
Mar 22 09:10:35 FractalPath kernel: The kobject at, or inside
per_cpu__cpuidle_devices+0xd4/0x558 is not dynamically allocated.
Mar 22 09:10:35 FractalPath kernel: The kobject at, or inside
per_cpu__cpuidle_devices+0x168/0x558 is not dynamically allocated.
Mar 22 09:10:35 FractalPath kernel: cpuidle: using driver acpi_idle

Not sure if this is a problem.  Also, the first time I booted the ml.bz2
build, it hung.  I don't have netconsole or a serial debugging system
set up, so I have no idea what the problem was.  The second boot,
ipw2200 loaded with no errors, but NetworkManager wouldn't
connect until I removed and reinserted the module.

All the best,
           Miles
