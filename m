From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RESEND] [PATCH 0/3] Blacklist broken ThinkPads to use 32 bit
	FADT addresses
Date: Mon, 20 Oct 2008 11:32:26 +0800
Message-ID: <1224473546.3944.226.camel@yakui_zhao.sh.intel.com>
References: <200810192349.32949.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32665 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbYJTD0g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Oct 2008 23:26:36 -0400
In-Reply-To: <200810192349.32949.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "devel@acpica.org" <devel@acpica.org>

On Sun, 2008-10-19 at 23:49 +0200, Thomas Renninger wrote:
> Hi,
> 
> can this be taken into .28 if it works out with acpica integration.
> 
> Patches are in OpenSUSE for quite a while now (also 11.0) and the
> issue has been evaluate to the ground now.
> 
> Lenovo confirmed that some rare models which got Vista support added
> late through BIOS upgrades could have wrong 64 bit addresses.
> 
> Vista also takes the broken 64 bit addresses like Linux does (spec conform).
> XP does take the correct 32 bit addresses.
Can you confirm that XSDT address is still used on vista even when it is
broken? If so, how the Vista can work well? For example: the 32X/64x IO
address don't match.

It is appropriate to add the boot option of "acpi_root_table=rsdt". When
there exists 32X/64X address mismatch while using XSDT, it can be
prompted that "RSDT can be tried". Maybe the issue on such systems can
be fixed /workaround by this boot option.
   32X/64X address mismatch can include the following:
   a. DSDT/XDSDT in FADT table
   b. FACS/XFACS in FADT table
   c. PM_CNTRL block
   d. GPE control block
   ...

Thanks.
   Best regards.

> 
> A generic approach (e.g. check through _OSI) does not work, because:
>   - the affected models support Vista (there the wrong addresses are also 
> taken, but
>     the symptoms seem not to happen or are also workarounded)
>   - Those IO addresses are touched before the DSDT is parsed -> no OSI
>     OS feature support check possible.
> 
> Be aware that one patch makes changes in ACPICA code.
> 
> Thanks,
> 
>      Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

