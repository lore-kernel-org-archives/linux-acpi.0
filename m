From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete
 acpi_os_validate_address interface"
Date: Thu, 2 Jul 2009 08:49:35 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308582EA5E8FC@orsmsx503.amr.corp.intel.com>
References: <1246415391.24831.30.camel@minggr.sh.intel.com>
 <alpine.LFD.2.00.0907012202580.19077@localhost.localdomain>
 <200907021222.15597.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36443 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346AbZGBPtd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2009 11:49:33 -0400
In-Reply-To: <200907021222.15597.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, Jean Delvare <jdelvare@suse.de>
Cc: "Lin, Ming M" <ming.m.lin@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

>-----Original Message-----
>From: Jean Delvare [mailto:jdelvare@suse.de]
...
>Native Linux drivers trying to access devices which ACPI also wants
>to access. Most frequently these are SMBus master drivers or hardware
>monitoring drivers (for Super I/O chips) but virtually any other
>device type could be affected, due to the fact that ACPI I/O
>resources do not show up in /proc/ioports and /proc/iomem.


I have some concern with this. The implication is that there is a serious hole in ACPI that can only be solved by monitoring exactly what the AML code is doing, because access to resources may conflict with device drivers. I have to think that if this were truly the case, the operating system vendors and the ACPI contributors would have pushed a fix for this problem into the ACPI specification by now (in the 13 years since the first release of ACPI).

The SMBus driver issue is very interesting. I have not heard of any conflicts between AML code and SMBus drivers on other operating systems, nor have we received any other complaints about removing the acpi_os_validate_address interface. I wonder if the Linux SMBus driver is doing something that it should not be doing.

I'd like to see a concrete example of the problem. If someone can send me a DSDT that contains such an example, I would appreciate it. I want to see the exact ASL code that is causing the problem along with the driver code that conflicts with it. This information will help me understand the problem in relation to the ACPICA code, and I can also present this to other ACPI and BIOS experts for their opinions.

As far as an immediate fix for the problem, I suggest that you think about using acpi_walk_namespace to retrieve all objects of type Region (or field). It seems a waste to build an entire list of objects that duplicates information that already exists in the namespace. 

Bob

>-----Original Message-----
>From: Thomas Renninger [mailto:trenn@suse.de]
>Sent: Thursday, July 02, 2009 3:22 AM
>To: Len Brown
>Cc: Lin, Ming M; Moore, Robert; Zhao, Yakui; linux-acpi
>Subject: Re: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete
>acpi_os_validate_address interface"
>
>On Thursday 02 July 2009 04:03:55 Len Brown wrote:
>> I can't apply a patch that adds a known memory leak,
>> even if it removes a conflict between drivers.
>Can you revert it with Lin's added on top (after discussing it), please.
>It's always a good idea (or a must) to have a stable patch in mainline
>first.
>I doubt we find a proper solution for 2.6.31.
>
>> The reason is that there is a workaround for the driver conflict,
>> but no workaround for the memory leak.
>There is one now.
>
>Thanks,
>
>   Thomas
