From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Patch] MCE, APEI: Don't enable CMCI when Firmware First mode is
 set in HEST for corrected machine checks
Date: Thu, 9 May 2013 00:15:01 +0200
Message-ID: <20130508221501.GK30955@pd.tnic>
References: <1367881102.4518.68.camel@oc3432500282.ibm.com>
 <20130506232537.GF22041@pd.tnic>
 <1367897566.4518.83.camel@oc3432500282.ibm.com>
 <20130507131946.GC7633@pd.tnic>
 <1367941214.4518.90.camel@oc3432500282.ibm.com>
 <20130508212237.GI30955@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F2DA47E5E@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:46172 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195Ab3EHWMt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 May 2013 18:12:49 -0400
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F2DA47E5E@ORSMSX101.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Max Asbock <masbock@linux.vnet.ibm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>, "naveen.n.rao@in.ibm.com" <naveen.n.rao@in.ibm.com>, "ananth@in.ibm.com" <ananth@in.ibm.com>, "lcm@linux.vnet.ibm.com" <lcm@linux.vnet.ibm.com>

On Wed, May 08, 2013 at 09:55:28PM +0000, Luck, Tony wrote:
> > Because if yes, you won't need any of the HEST header parsing here. So
> > what's up?
> 
> I think[1] HEST can tell you which banks report using APEI (as well as/instead of) CMCI.
> 
> So a full solution should take into account lots of possibilities:

Great, more fun! :-)

> 1) Some banks may not support CMCI at all (bit 30 in MCi_CTL2 register
> ignores attempts to enable). For these banks Linux should poll.

That's the detection method, try setting bit 30 to see if it sticks?

> 2) BIOS may support generation of APEI records for certain classes of
> errors. HEST will say which banks are affected, and if we prefer APEI,
> we should disable CMCI for these banks (and not poll them).

Ok, so it looks like code should iterate over those and remove them from
the mce_banks list we pass on to machine_check_poll.

> 3) Some banks may support CMCI, but don't have BIOS support to
> generate APEI records. We should continue to enable CMCI for these.

How do you get that out of the HEST? The inability to generate APEI
records.

> We should also take advantage of more information provided in the APEI
> record. We only look at mem_err->physical_addr for memory errors - but
> there are a ton of other potentially interesting things in there.

Ok.

> [1] But I may be misreading ACPI spec - unfortunately it just has
> descriptions of *what* bits do, but no rationale as to *why* anyone
> would want to use them, or tradeoffs between different operating
> modes. Willing to be re-educated if this is all horribly wrong.

Me too. If you haven't noticed, I'm avoiding the APEI spec as much as
possible. :-)

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
