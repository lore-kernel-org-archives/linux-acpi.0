From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: Compaq V2000 Fan Control
Date: Tue, 28 Mar 2006 11:15:13 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD10F0194@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:40039 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751222AbWC1Ddq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2006 22:33:46 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, "Bonilla, Alejandro" <abonilla@linuxwireless.org>
Cc: linux-acpi@vger.kernel.org

>> I know I don't have it. Is there a way to debug this and see 
>if it could
>> occur or if it just could be that it needs a tweak? Or is 
>definitely not
>> going to work?
>
>Your laptop doesn't expose the fan as an ACPI object. As a result, 
>there's no way to control it through the standard ACPI interfaces.

Not precisely.  Fan control sometimes are side effect of AML methods.
If you do want to understand how fan control is implemented in AML
methods,
probably, you need to hack DSDT. 

If no explict Fan control, at least we need to make sure implicit fan
control works
But, it depends on platform vendor to implement Fan control in ACPI or
not.

Thanks,
Luming
