From: Raphael Clifford <raphael@clifford.net>
Subject: Re: 2.6.16-rc1  will not boot on msi rs480m2 when either acpi or
 apic is enabled
Date: Mon, 23 Jan 2006 19:05:43 +0000
Message-ID: <43D52907.7090204@clifford.net>
References: <43D4FE2F.5080700@clifford.net> <200601231000.46575.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pih-relay05.plus.net ([212.159.14.132]:18059 "EHLO
	pih-relay05.plus.net") by vger.kernel.org with ESMTP
	id S964894AbWAWS6e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jan 2006 13:58:34 -0500
In-Reply-To: <200601231000.46575.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

Bjorn Helgaas wrote:
> On Monday 23 January 2006 09:02, Raphael Clifford wrote:
>   
>> MSI rs480m2 system  (AMD64 processor) will not boot when either acpi or apic are
>> enabled in the boot arguments.  This has been tested in many kernels (gentoo and vanilla) up
>> to and including 2.6.16-rc1.  
>>     
>
> Can you try "pci=routeirq"?  Can you capture the entire boot output
> with a serial console or netconsole?  Are any BIOS updates available
> for this box?
>   


I forgot to mention. I have the latest BIOS version 3.80 already.

Raphael
