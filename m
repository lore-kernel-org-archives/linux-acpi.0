From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: T43 BIOS and AHCI
Date: Tue, 06 Feb 2007 17:02:58 +0300
Message-ID: <45C88A92.5000905@linux.intel.com>
References: <20070205235904.GA18392@khazad-dum.debian.net> <B41635854730A14CA71C92B36EC22AAC804186@mssmsx411> <20070206133914.GC18392@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:38476 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752197AbXBFODI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Feb 2007 09:03:08 -0500
In-Reply-To: <20070206133914.GC18392@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>, linux-acpi@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Tue, 06 Feb 2007, Starikovskiy, Alexey Y wrote:
>   
>> T43 2668-NG2 BIOS 1.23 EC 1.03
>>     
>
>   
I updated to 1.29/1.06 and still have 6 seconds resume time...
> We use the same BIOS (TP-1Y), but you are using a very old version.  A lot
> might have changed since then, including AHCI support going away.  I don't
> think I ever run a 1.23 bios on my machine...
>
> And I know for a fact that the ACPI DSDT tables *did* change since 1.23, as
> I have been looking at the DSDT changes in later versions of the BIOS as I
> upgrade them.
>
> Anyway, do you have anything in the BIOS that allows you to select AHCI
> mode, or did Linux just load AHCI and skipped merrily along?  Here, AHCI
> won't load with an error (supposedly because the ICH is already set to
> non-AHCI mode).
>   
Sorry, my mistake here ahci only says that it failed to find device, and 
then all output comes from pii_ata...

Regards,
    Alex.
