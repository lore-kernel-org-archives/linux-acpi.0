From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/2]: the patch set to weaken the dependency between ACPI video driver and i915 driver
Date: Wed, 15 Apr 2009 05:53:59 +0100
Message-ID: <20090415045359.GA15437@srcf.ucam.org>
References: <1239678275.5564.66.camel@localhost.localdomain> <20090414193538.GB8304@srcf.ucam.org> <1239757961.5564.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49739 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbZDOEyI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Apr 2009 00:54:08 -0400
Content-Disposition: inline
In-Reply-To: <1239757961.5564.109.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Apr 15, 2009 at 09:12:41AM +0800, yakui_zhao wrote:
> > No, it's *correct*. In a modesetting world, i915 requires ACPI.
> Why is the ACPI required by i915 when KMS is used? 
> It seems that we still can use the KMS with ACPI disabled. 
>    In such case it is unnecessary to load the acpi video driver. 

You can, but things will break.

> In fact what I have done is to weaken the tight dependency. When the
> i915 driver is compiled as built-in and the acpi video is compiled as
> module, the kernel compilation will be OK.  
>     Before the acpi video driver is loaded, the system is still OK
> except that there is no backlight control.

I know that that's what you've done. I just don't think it's useful. 
Weakening the dependency means that you're driving the hardware outside 
of its design parameters, and I really don't see any reason to do that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
