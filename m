From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: Bad libata resume behaviour due to ACPICA change (in acpi-test)
Date: Thu, 08 Feb 2007 20:50:38 +0300
Message-ID: <45CB62EE.8020300@linux.intel.com>
References: <20070203004140.GB619@khazad-dum.debian.net> <B41635854730A14CA71C92B36EC22AAC803F9D@mssmsx411> <20070208153025.GA466@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:23526 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750774AbXBHRun (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Feb 2007 12:50:43 -0500
In-Reply-To: <20070208153025.GA466@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

first thing to check is timing of acpi_hw_disable_all_gpes() at 
drivers/acpi/events/evgpe.c:647,
printk() around it should be good.


Henrique de Moraes Holschuh wrote:
> On Mon, 05 Feb 2007, Starikovskiy, Alexey Y wrote:
>   
>> I cannot reproduce your problem with T43 here on linux-acpi-test with
>> defconfig (relevant ACPI modules were tried both dynamic and static).
>> Resume time is about 4-6 seconds, not 20-40 as you mention.
>> Could you please send your .config and try defconfig on your machine?
>>     
>
> Sorry for the delay on doing the tests.  2.6.20+acpi-test defconfig does NOT
> do ACPI S3, so I had to use defconfig with SMP turned off (that was the only
> change).  Are you sure you tried linux-acpi-test in 2.6.20 defconfig without
> any changes?
>
> gcc is Debian 3.4.6-5.  I am avoiding 4.1.1 because of the reports of it
> miscompiling the kernel sometimes.
>
> The bug changed behaviour a little in defconfig.  Now, I get the "Restarting
> tasks ... done" right away after the line that used to hang (SCSI device
> sda: write cache...", and THEN it hangs for about 20s.
>
> In my default T43 kernel, I get "Restarting tasks ... done" *before* the
> (SCSI device sda: write cache..." line.
>
> So the hang is still there, it is still 100% reproducible here, but I am not
> sure it has much to do with libata.  It might have something to do with
> whatever happens after "Restarting tasks ... done", and libata resume just
> happens to be running in another thread at that time and outputs its stuff
> through printk.
>
> Any ideas on how to debug this further?
>
>   
