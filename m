From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: (Intel Core 2 Duo 2.4gig 4meg cache + Intel S3000AH + Linux) - ACPI kernel option = 1 core?
Date: Tue, 29 May 2007 17:07:14 +0800
Message-ID: <FC1D1B23302A22499C60C967336B2AE0014B6159@pdsmsx411.ccr.corp.intel.com>
References: <465B7ECE.9010308@netwaynetworks.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43769 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbXE2JH2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 May 2007 05:07:28 -0400
Content-class: urn:content-classes:message
In-Reply-To: <465B7ECE.9010308@netwaynetworks.com.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: steve@netwaynetworks.com.au, linux-acpi@vger.kernel.org



>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Steve Evans
>Sent: Tuesday, May 29, 2007 9:16 AM
>To: linux-acpi@vger.kernel.org
>Subject: (Intel Core 2 Duo 2.4gig 4meg cache + Intel S3000AH + Linux) -
>ACPI kernel option = 1 core?
>
>Hey guys
>
>I've been configuring up a Linux 2.6.21.1 kernel from Linus' trusty
>kernel.org.
>
>I configured it up and built it and noticed that the dual core CPU I
was
>using is now a single core chip.
>
>I've spent alittle time on this problem and think I found out how to
>enable or disable the single core.  My base config is:
>- Processor - SMP On
>- Processor - SMT/Hyperthreading scheduler On
>- Processor - Multicore scheduler On
>- Processor - Optimize for any CPU type (ie P4, Core2, i586) or base
>system (ie BigSMB/summit or PC-compatible)
>- Power management support On
>- All other power management pieces turned off
>- All other options are set standard by 'make mrproper'
>
>I compile the kernel with ACPI off and I get 1 cpu/cpu-core.
>
>I then recompile with just the ACPI turned on (ie havn't turned on
>Processor, Fan or any other modules there) and I get to see my second
core.
>
>This server will be well ventilated and will be running multiple VM's.
>To guarantee performance I'd like to have ACPI turned off.
>
>I can also say that this bug seems to be present in 2.6.18 as well.
>
>So I guess my question is, has this issue been fixed?  Or how can I
help
>to fix it?
>
Boot option 'acpi=ht'
