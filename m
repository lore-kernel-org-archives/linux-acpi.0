From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: bisected: Re: 4.3.0-rc3-00042: ACPI Warning: AcpiEnable failed
Date: Thu, 01 Oct 2015 23:56:14 +0200
Message-ID: <2057337.qekm8qivoU@vostro.rjw.lan>
References: <alpine.LRH.2.20.1509291519111.3351@math.ut.ee> <alpine.LRH.2.20.1510010927010.10113@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49812 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750715AbbJAV1w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Oct 2015 17:27:52 -0400
In-Reply-To: <alpine.LRH.2.20.1510010927010.10113@math.ut.ee>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Meelis Roos <mroos@ut.ee>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>

On Thursday, October 01, 2015 09:36:57 AM Meelis Roos wrote:
> > 4.2.0 worked fine, 4.3.0-rc3-00042-g3225031 was the next one tested 
> > after that and with this kernel, ACPI enabling fails. This is Pentium 
> > III, 1 GHz, Intel 815 chipset, DMI tells something about "Packard Bell 
> > NEC" as the mainboard type.
> > 
> > Full dmesg and config are below. What additional information can I 
> > provide besides bisecting (will take time)?
> 
> Bisecting done, here is the culprit:
> 
> 8ec3f459073e67e5c6d78507dec693064b3040a2 is the first bad commit
> commit 8ec3f459073e67e5c6d78507dec693064b3040a2
> Author: Lv Zheng <lv.zheng@intel.com>
> Date:   Tue Aug 25 10:29:01 2015 +0800
> 
>     ACPICA: Tables: Fix global table list issues by removing fixed table indexes
>     
>     ACPICA commit c0b38b4c3982c2336ee92a2a14716107248bd941

Thanks a lot for bisecting this!

It will help if you file a bug entry at bugzilla.kernel.org agaist ACPI for
this issue (please mark it as a regression) and attach the output of acpidump
from the affected system to it.

Thanks,
Rafael

