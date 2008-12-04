From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: HOWTO Get original DSDT?
Date: Thu, 04 Dec 2008 13:34:27 +0800
Message-ID: <1228368867.4035.236.camel@yakui_zhao.sh.intel.com>
References: <91b13c310812032007w6db30ebekfa8e95931c5c17c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51931 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478AbYLDF0l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Dec 2008 00:26:41 -0500
In-Reply-To: <91b13c310812032007w6db30ebekfa8e95931c5c17c6@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cheng Renquan <crquan@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "lenb@kernel.org" <lenb@kernel.org>

On Thu, 2008-12-04 at 12:07 +0800, Cheng Renquan wrote:
> Here we unfourtunately have many Dell Optiple 320 machines,
> 
> its hardware profile has been sent out to smolts:
> http://www.smolts.org/client/show/pub_32cc3df5-67af-42e9-806a-20dd25f47757
> 
> It have notorious ACPI support problem, almost all Linux distros cannot run well
> on this hardware (CDROM cannot boot, or cannot install,
> or can install but cannot boot from hard disk)
> except a China Linux distro RedFlag 5.0 (it runs with ACPI enabled
> well, but why?)
> 
> some distros can run with acpi=off on it,
> 
> Today I found the article on override DSDT, I think this may solve this problem,
> 
> http://www.lesswatts.org/projects/acpi/overridingDSDT.php
> 
> But with this section,
> 
> How to Build a custom DSDT into the kernel
> 
>    1. Get original DSDT:
> 
>       # cp /proc/acpi/dsdt DSDT
> 
>       or
> 
>       # acpidump > acpidump.out
> 
> The problem is how to get /proc/acpi/dsdt with acpi=off?
> 
> if boot without "acpi=off", the kernel will hang, reproduce always,
> if boot with "acpi=off", there's no /proc/acpi nor
> /sys/devices/platform/acpi/...
> 
> So the problem is:
You can use the acpidump tool to get the acpidump.out and then get the
DSDT file from acpidump.out.
And the two tools will be used.(acpixtract, iasl)
The acpixtract can found in the
pmtools(http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/)

The iasl can be found in the 
http://www.acpica.org/downloads/unix_source_code_cont.php

Thanks.

> 
> Is there any other approach to get the DSDT?
> 

