From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 4/4] ACPI, APEI, Add APEI _OSC support
Date: Wed, 22 Jun 2011 10:21:20 +0800
Message-ID: <4E0151A0.90505@intel.com>
References: <1308640587-24502-1-git-send-email-ying.huang@intel.com> <1308640587-24502-5-git-send-email-ying.huang@intel.com> <20110621132256.GB4902@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2473 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757755Ab1FVCVW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Jun 2011 22:21:22 -0400
In-Reply-To: <20110621132256.GB4902@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 06/21/2011 09:22 PM, Matthew Garrett wrote:
> On Tue, Jun 21, 2011 at 03:16:27PM +0800, Huang Ying wrote:
> 
>> +	rc = apei_osc_setup();
>> +	if (rc)
>> +		pr_info(GHES_PFX "Evaluate APEI _OSC failed!\n");
> 
> Hm. This is maybe a little strong. It'd be valid for a machine to return 
> an error here but still have the GHES functionality enabled via the 
> generic call, but this message would still show up and potentially 
> confuse the user. Can we keep a flag to check whether the generic method 
> gave us control, and only give the error if both fail to enable it?

At least on some of my testing machine, generic _OSC call will not
return any error even it does not support APEI bit.  So I think
sometimes it may be helpful to printk something here.  To avoid
confusion, can we change the message as follow.

- generic _OSC succeeded, APEI _OSC failed: APEI firmware first mode is
enabled by APEI bit.
- generic _OSC failed, APEI _OSC succeeded: APEI firmware first mode is
enabled by APEI _OSC.
- both succeeded: APEI firmware first mode is enabled by APEI bit and
APEI _OSC.
- both failed: Failed to enable APEI firmware first mode!

Best Regards,
Huang Ying
