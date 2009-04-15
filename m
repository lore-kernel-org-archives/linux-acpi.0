From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH 0/2]: the patch set to weaken the dependency between
	ACPI video driver and i915 driver
Date: Wed, 15 Apr 2009 09:12:41 +0800
Message-ID: <1239757961.5564.109.camel@localhost.localdomain>
References: <1239678275.5564.66.camel@localhost.localdomain>
	 <20090414193538.GB8304@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58024 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbZDOBLR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Apr 2009 21:11:17 -0400
In-Reply-To: <20090414193538.GB8304@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2009-04-15 at 03:35 +0800, Matthew Garrett wrote:
> On Tue, Apr 14, 2009 at 11:04:35AM +0800, yakui_zhao wrote:
> 
> >     Patch 2/2:  weaken the tight dependency between the ACPI video driver and i915 driver
> >     Now there exists the tight dependency between the ACPI video driver and i915 driver. 
> > If the I915 driver is compiled as built-in module and the acpi video is compiled as module, 
> > it will fail in the kernel compilation.
> >     At the same time the acpi video driver must be loaded in order to load
> > the I915 driver. It is very hack.
> 
> No, it's *correct*. In a modesetting world, i915 requires ACPI.
Why is the ACPI required by i915 when KMS is used? 
It seems that we still can use the KMS with ACPI disabled. 
   In such case it is unnecessary to load the acpi video driver. 

In fact what I have done is to weaken the tight dependency. When the
i915 driver is compiled as built-in and the acpi video is compiled as
module, the kernel compilation will be OK.  
    Before the acpi video driver is loaded, the system is still OK
except that there is no backlight control.

Is this reasonable?

Thanks.   
> 

