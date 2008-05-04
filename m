From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 091/171] ACPI: GPE enabling should happen
	after	EC	installation
Date: Mon, 05 May 2008 00:22:33 +0800
Message-ID: <1209918153.5485.42.camel@yakui_zhao.sh.intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
	 <1209551134.12515.47.camel@yakui_zhao.sh.intel.com>
	 <200804300758.54778.carlos@strangeworlds.co.uk>
	 <200804300817.53800.carlos@strangeworlds.co.uk>
	 <1209573782.16111.32.camel@yakui_zhao.sh.intel.com>
	 <4818441D.2010800@suse.de>
	 <1209896900.28197.65.camel@yakui_zhao.sh.intel.com>
	 <481D5A6A.4060603@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53268 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785AbYEDIbY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 May 2008 04:31:24 -0400
In-Reply-To: <481D5A6A.4060603@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, robert.moore@intel.com, "Lin, Ming M" <ming.m.lin@intel.com>

On Sun, 2008-05-04 at 10:40 +0400, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> > But after the patch is applied, it seems that we make a lot of changes
> > about the GPE initialization flowchart in ACPICA.
> And this flowchart is cast in stone?
After the two patches are applied, the issue in bug9916 can be fixed.
But in fact the issue in bug9916 is related with bios.
   In the L02 method the _PSR object of AC will be accessed.
   > Method (_PSR, 0, NotSerialized)
    >                    {
    >                        Return (HPAC)  
    >                    }
    HPAC is defined in EC OperationRegion. IMO Whether the HPAC can be
accessed should be determined by the flag of H8DR, which indicates
whether the EC operation region can be accessed. (1 means that EC
opregion can be accessed. 0 means that EC opregion can't be accessed.) 
   It seems that this is an obvious bios bug. It is more appropriate to
fix this issue by upgrading bios. 
   IMO it is unnecessary to make a lot of changes about GPE
initialization flowchart for the obvious bios bug.
   
   At the same time it is very luck that there exists ECDT table on the
laptop of bug9916. And after the two patches are applied, the GPE can be
enabled after EC installation.  But if the ECDT table doesn't exist(EC
device has no _INI object in DSDT table), it seems that GPE enabling
still happens before EC installation.
> > Will these be easily accepted by ACPICA author?
> You should probably ask him, not me. We are talking Bob Moore here, yes?
> Why don't you add CC to him if you are worried?
CC Bob and Lin Ming to see this issue.
> > At the same time some RUNTIME GPEs will be enabled twice. When
> > acpi_enable_gpe is called in the course of EC installation, some RUNTIME
> > GPEs will also be enabled. In fact when the acpi_ev_install_fadt_gpes is
> > called, all the RUNTIME GPEs will be enabled. In such case it brings
> > that some RUNTIME GPEs are enabled twice. Of course the patch should
> > work fine if it is safe to enable RUNTTME GPEs twice.
> Please advise me, how we are not enabling them twice if EC init happens after?
> The same acpi_enable_gpe will be called from it.

> 
> Regards,
> Alex.

