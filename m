From: Bret Hughes <bhughes@elevating.com>
Subject: Re: serial port discovery on a motion computing tablet
Date: Wed, 14 Mar 2007 10:03:06 -0500
Message-ID: <45F80EAA.6010808@elevating.com>
References: <45F7688B.8000101@elevating.com> <20070314134323.GC1467@srcf.ucam.org> <45F806B1.3060807@elevating.com> <20070314143534.GA2655@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from h186.102.16.72.ip.alltel.net ([72.16.102.186]:53186 "EHLO
	mail1.imperiumsolutions.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161327AbXCNPDV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Mar 2007 11:03:21 -0400
In-Reply-To: <20070314143534.GA2655@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org



Matthew Garrett wrote:
> On Wed, Mar 14, 2007 at 09:29:05AM -0500, Bret Hughes wrote:
>   
>> nothing there:
>> [root@localhost serial]# ls -a /sys/bus/pnp/devices/
>> .  ..
>>     
>
> That's, uh, surprising - is CONFIG_PNPACPI set?
>
>   

not there:

[root@localhost linux-2.6.9]# grep PNPACPI .config
[root@localhost linux-2.6.9]#


>> Now that I am back at the office and looking at the kernel .config via 
>> make xconfig I see that 8250/16550 device discovery via ACPI namespace 
>> (SERIAL_8250_ACPI) is not enabled.  Is is safe to assume that it should 
>> be (go ahead and groan, I probably would) anything else that should be 
>> included? 
>>     
>
> Hm. How old is this kernel? SERIAL_8250_ACPI was merged into 
> SERIAL_8250_PNP a while back.
>
>   
2.6.9-42 Latest Centos kernel.  Too old?

Bret
