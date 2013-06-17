From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] Re: [Patch] MCE, APEI: Don't enable CMCI when Firmware
 First mode is set in
Date: Mon, 17 Jun 2013 13:41:03 +0530
Message-ID: <20130617081103.GA4197@naverao1-tp.in.ibm.com>
References: <3908561D78D1C84285E8C5FCA982C28F2DA47F03@ORSMSX101.amr.corp.intel.com>
 <20130614181721.11206.95341.stgit@localhost.localdomain>
 <20130615144830.GA13310@pd.tnic>
 <51BEB3F5.8070002@gmail.com>
 <20130617070650.GA7203@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130617070650.GA7203@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "ananth@in.ibm.com" <ananth@in.ibm.com>, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com
List-Id: linux-acpi@vger.kernel.org

On 2013/06/17 09:06AM, Borislav Petkov wrote:
> On Mon, Jun 17, 2013 at 12:30:05PM +0530, Naveen N. Rao wrote:
> > >Hmm, so if CMCI is not supported, you just disabled polling of this bank
> > >and returned here. Not good.
> > 
> > This is on purpose. If the bank doesn't support CMCI and we were
> > polling it earlier, we want to disable that. The firmware should be
> > notifying us of error events in either case.
> 
> Not for corrected errors - for those we poll since the hardware doesn't
> generate an exception for them.

Yes, we used to poll since we do not get notified via MCE/CMCI. However,
with firmware first set in CMC structure, the firmware is now controlling
all corrected error reporting for these banks. So, we should not be looking
at these MCA banks at all.

> 
> Basically, the absence of CMCI support shouldn't change the old polling
> behavior.

Again, this changes with firmware first mode. The firmware should now
notify us of all corrected errors through GHES.

Thanks,
Naveen

> 
> Thanks.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Sent from a fat crate under my desk. Formatting is fine.
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
