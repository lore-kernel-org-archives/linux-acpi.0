From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [Fwd: [patch 2.6.18-rc7] ACPI: build warnings begone (x86_64)]
Date: Wed, 20 Sep 2006 08:55:13 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4F8071E@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23131 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1751640AbWITPzj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Sep 2006 11:55:39 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: sergio@sergiomb.no-ip.org, acpi devel <linux-acpi@vger.kernel.org>

Yes, ACPICA started to allow more native kernel data types to be
compiled into itself, breaking many of the existing debug output
statements.

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of David Brownell
> Sent: Wednesday, September 20, 2006 8:50 AM
> To: Moore, Robert
> Cc: sergio@sergiomb.no-ip.org; acpi devel
> Subject: Re: [Fwd: [patch 2.6.18-rc7] ACPI: build warnings begone
> (x86_64)]
> 
> On Wednesday 20 September 2006 8:11 am, Moore, Robert wrote:
> > Problem is to make one version of the code compile everywhere with
no
> warnings.
> 
> Yes, and it's been solved in essentially all other parts of x86
kernels.
> In fact, until somewhere in the 2.6.18 series it was solved for ACPI
...
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
