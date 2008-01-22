From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 6/10] ACPI: register ACPI Video LCD as generic thermal
	cooling device
Date: Tue, 22 Jan 2008 16:01:42 +0800
Message-ID: <1200988902.7424.14.camel@acpi-sony.sh.intel.com>
References: <1200556282.2935.122.camel@acpi-sony.sh.intel.com>
	 <20080117122431.GA32133@srcf.ucam.org>
	 <1200619900.2935.161.camel@acpi-sony.sh.intel.com>
	 <20080118014254.GA14818@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31186 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbYAVH4V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jan 2008 02:56:21 -0500
In-Reply-To: <20080118014254.GA14818@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Thomas, Sujith" <sujith.thomas@intel.com>

Hi, Matthew,

On Fri, 2008-01-18 at 09:42 +0800, Matthew Garrett wrote:
> On Fri, Jan 18, 2008 at 09:31:40AM +0800, Zhang Rui wrote:
> 
> > Just like I don't think lcd should be used for ACPI thermal
> management
> > before I saw it is listed in _TZD and intel_menlow requires to
> throttle
> > it when overheating, why not let the individual drivers implement
> the
> > callbacks if there is clearly a request to do this.
> > And we can add this to the generic acpi_device struct then if this
> is a
> > common feature for all ACPI devices.
> 
> It'll probably never be common for all ACPI devices,
I agree.
>  but it's already
> required for three types. I think that's a strong argument for making
> it generic.
I don't think it's worth doing this as it's only the common feature for
three ACPI devices.
> > Well, you're right.
> > But in order to throttle the lcd, this is reasonable, right?
> 
> Moving the common code into its own routine and then calling that from
> each of the others would probably work.
Yes.
I can send an on top patch if the patch "Rationalise ACPI backlight
implementation" is applied.

Thanks,
Rui

