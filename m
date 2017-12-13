From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Subject: Re: [PATCH] acpi: acpica: add acpi status check prior walking
 through namespace
Date: Wed, 13 Dec 2017 06:52:01 -0800
Message-ID: <20171213145201.GA6692@localhost.localdomain>
References: <1513094360-1414-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <1513094360-1414-2-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B74FBD84@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-sn1nam01on0053.outbound.protection.outlook.com ([104.47.32.53]:11449
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752175AbdLMOwI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Dec 2017 09:52:08 -0500
Content-Disposition: inline
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B74FBD84@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vadim.lomovtsev@cavium.com" <vadim.lomovtsev@cavium.com>, "Schmauss, Erik" <erik.schmauss@intel.com>

On Tue, Dec 12, 2017 at 09:52:21PM +0000, Moore, Robert wrote:
> Another way to look at this is that the kernel should not be calling ACPI interfaces if ACPI is disabled.

Yes, I agree. So in this case the ltp_acpi test case has to be updated with such checking
before calling ACPI interfaces. However, it seems that such calls was put there intentionally,
without ACPI state check, as part of kernel testing strategy.

WBR,
Vadim

> 
> > -----Original Message-----
> > From: Vadim Lomovtsev [mailto:Vadim.Lomovtsev@caviumnetworks.com]
> > Sent: Tuesday, December 12, 2017 7:59 AM
> > To: Moore, Robert <robert.moore@intel.com>; Zheng, Lv
> > <lv.zheng@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>;
> > lenb@kernel.org; linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> > kernel@vger.kernel.org
> > Cc: vadim.lomovtsev@cavium.com
> > Subject: [PATCH] acpi: acpica: add acpi status check prior walking
> > through namespace
> > 
> > From: Vadim Lomovtsev <vadim.lomovtsev@cavium.com>
> > 
> > While having kernel built with ACPI support enabled and booted over FDT,
> > the ltp_acpi test from LTP suite causes kernel crash while calling
> > acpi_ns_walk_namespace(). The acpi_get_devices is high level wrapper for
> > it, so we need to protect kernel from crashes by adding acpi status
> > check before walking through namespace which is not loaded because of
> > acpi is disabled.
> > 
> > Signed-off-by: Vadim Lomovtsev <vadim.lomovtsev@cavium.com>
> > ---
> >  drivers/acpi/acpica/nsxfeval.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/acpi/acpica/nsxfeval.c
> > b/drivers/acpi/acpica/nsxfeval.c index 783f4c8..e0eb9ae 100644
> > --- a/drivers/acpi/acpica/nsxfeval.c
> > +++ b/drivers/acpi/acpica/nsxfeval.c
> > @@ -52,6 +52,8 @@
> >  #define _COMPONENT          ACPI_NAMESPACE
> >  ACPI_MODULE_NAME("nsxfeval")
> > 
> > +extern int acpi_disabled;
> > +
> >  /* Local prototypes */
> >  static void acpi_ns_resolve_references(struct acpi_evaluate_info
> > *info);
> > 
> > @@ -812,6 +814,11 @@ static void acpi_ns_resolve_references(struct
> > acpi_evaluate_info *info)
> > 
> >  	ACPI_FUNCTION_TRACE(acpi_get_devices);
> > 
> > +	/* check if ACPI disabled to prevent kernel crash later */
> > +	if (acpi_disabled) {
> > +		return_ACPI_STATUS(AE_NOT_CONFIGURED);
> > +	}
> > +
> >  	/* Parameter validation */
> > 
> >  	if (!user_function) {
> > --
> > 1.8.3.1
> 
