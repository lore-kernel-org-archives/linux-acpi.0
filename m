From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: bisected: Re: 4.3.0-rc3-00042: ACPI Warning: AcpiEnable failed
Date: Mon, 12 Oct 2015 07:48:12 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BAC712B@SHSMSX101.ccr.corp.intel.com>
References: <alpine.LRH.2.20.1509291519111.3351@math.ut.ee>
 <alpine.LRH.2.20.1510010927010.10113@math.ut.ee>
 <2057337.qekm8qivoU@vostro.rjw.lan>
 <alpine.LRH.2.20.1510020901590.17033@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:63641 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbbJLHs0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Oct 2015 03:48:26 -0400
In-Reply-To: <alpine.LRH.2.20.1510020901590.17033@math.ut.ee>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Hi, Rafael

The bug has been fixed.
The root cause is the previous commit doesn't cover a hidden logic:
 acpi_enable() should rely on the existence of FADT while currently it relies on the number of loaded tables.
The fix that removes the hidden logic is an ACPICA commit.
Shall we wait until it is merged via an ACPICA release cycle or make it a bit faster by merging Linuxized version first?

Thanks and best regards
-Lv

> From: mroos@math.ut.ee [mailto:mroos@math.ut.ee] On Behalf Of Meelis Roos
> Sent: Friday, October 02, 2015 2:14 PM
> 
> > > > 4.2.0 worked fine, 4.3.0-rc3-00042-g3225031 was the next one tested
> > > > after that and with this kernel, ACPI enabling fails. This is Pentium
> > > > III, 1 GHz, Intel 815 chipset, DMI tells something about "Packard Bell
> > > > NEC" as the mainboard type.
> > > >
> > > > Full dmesg and config are below. What additional information can I
> > > > provide besides bisecting (will take time)?
> > >
> > > Bisecting done, here is the culprit:
> > >
> > > 8ec3f459073e67e5c6d78507dec693064b3040a2 is the first bad commit
> > > commit 8ec3f459073e67e5c6d78507dec693064b3040a2
> > > Author: Lv Zheng <lv.zheng@intel.com>
> > > Date:   Tue Aug 25 10:29:01 2015 +0800
> > >
> > >     ACPICA: Tables: Fix global table list issues by removing fixed table indexes
> > >
> > >     ACPICA commit c0b38b4c3982c2336ee92a2a14716107248bd941
> >
> > Thanks a lot for bisecting this!
> >
> > It will help if you file a bug entry at bugzilla.kernel.org agaist ACPI for
> > this issue (please mark it as a regression) and attach the output of acpidump
> > from the affected system to it.
> 
> Done, https://bugzilla.kernel.org/show_bug.cgi?id=105351
> 
> --
> Meelis Roos (mroos@linux.ee)
