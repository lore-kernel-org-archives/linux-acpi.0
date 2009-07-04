From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete   acpi_os_validate_address
 interface"
Date: Fri, 03 Jul 2009 19:29:23 -0600
Message-ID: <4A4EB073.1000907@gmail.com>
References: <1246415391.24831.30.camel@minggr.sh.intel.com> <alpine.LFD.2.00.0907012202580.19077@localhost.localdomain> <200907021222.15597.trenn@suse.de> <4911F71203A09E4D9981D27F9D8308582EA5E8FC@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:41363 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691AbZGDB2L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Jul 2009 21:28:11 -0400
Received: by yxe26 with SMTP id 26so3837858yxe.33
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2009 18:28:13 -0700 (PDT)
In-Reply-To: <4911F71203A09E4D9981D27F9D8308582EA5E8FC@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, Jean Delvare <jdelvare@suse.de>, "Lin, Ming M" <ming.m.lin@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On 07/02/2009 09:49 AM, Moore, Robert wrote:
>> -----Original Message-----
>> From: Jean Delvare [mailto:jdelvare@suse.de]
> ...
>> Native Linux drivers trying to access devices which ACPI also wants
>> to access. Most frequently these are SMBus master drivers or hardware
>> monitoring drivers (for Super I/O chips) but virtually any other
>> device type could be affected, due to the fact that ACPI I/O
>> resources do not show up in /proc/ioports and /proc/iomem.
>
>
> I have some concern with this. The implication is that there is a serious hole in ACPI that can only be solved by monitoring exactly what the AML code is doing, because access to resources may conflict with device drivers. I have to think that if this were truly the case, the operating system vendors and the ACPI contributors would have pushed a fix for this problem into the ACPI specification by now (in the 13 years since the first release of ACPI).
>
> The SMBus driver issue is very interesting. I have not heard of any conflicts between AML code and SMBus drivers on other operating systems, nor have we received any other complaints about removing the acpi_os_validate_address interface. I wonder if the Linux SMBus driver is doing something that it should not be doing.
>
> I'd like to see a concrete example of the problem. If someone can send me a DSDT that contains such an example, I would appreciate it. I want to see the exact ASL code that is causing the problem along with the driver code that conflicts with it. This information will help me understand the problem in relation to the ACPICA code, and I can also present this to other ACPI and BIOS experts for their opinions.
>
> As far as an immediate fix for the problem, I suggest that you think about using acpi_walk_namespace to retrieve all objects of type Region (or field). It seems a waste to build an entire list of objects that duplicates information that already exists in the namespace.

My guess is that exactly the same thing will happen if you install 
add-on hardware monitoring software on Windows that loads drivers that 
access SMBus hardware directly on such systems where ACPI accesses the 
same devices. The ACPI code and the native driver will likely stomp on 
each other's hardware accesses. Likely on Linux it's more frequent that 
this kind of native hardware monitoring driver gets used (in some setups 
it seems they will auto-load by default..)
