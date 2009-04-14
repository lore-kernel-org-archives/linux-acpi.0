From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/2]: the patch set to weaken the dependency between ACPI video driver and i915 driver
Date: Tue, 14 Apr 2009 20:35:38 +0100
Message-ID: <20090414193538.GB8304@srcf.ucam.org>
References: <1239678275.5564.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44859 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408AbZDNTfo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Apr 2009 15:35:44 -0400
Content-Disposition: inline
In-Reply-To: <1239678275.5564.66.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Tue, Apr 14, 2009 at 11:04:35AM +0800, yakui_zhao wrote:

>     Patch 2/2:  weaken the tight dependency between the ACPI video driver and i915 driver
>     Now there exists the tight dependency between the ACPI video driver and i915 driver. 
> If the I915 driver is compiled as built-in module and the acpi video is compiled as module, 
> it will fail in the kernel compilation.
>     At the same time the acpi video driver must be loaded in order to load
> the I915 driver. It is very hack.

No, it's *correct*. In a modesetting world, i915 requires ACPI.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
