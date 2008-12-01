From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [intel/acpi] backlight
Date: Mon, 1 Dec 2008 19:32:15 +0000
Message-ID: <20081201193215.GA23773@srcf.ucam.org>
References: <1227854824.3477.9.camel@hidalgo> <alpine.LFD.2.00.0811302220060.3314@localhost.localdomain> <20081201083855.GB7380@srcf.ucam.org> <200812011127.09720.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44110 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbYLATcY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 14:32:24 -0500
Content-Disposition: inline
In-Reply-To: <200812011127.09720.jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Len Brown <lenb@kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, Yves-Alexis Perez <corsac@debian.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Dec 01, 2008 at 11:27:09AM -0800, Jesse Barnes wrote:
> On Monday, December 1, 2008 12:38 am Matthew Garrett wrote:
> > Jesse, are IRQs being delivered to the drm code when X isn't the
> > foreground VT? If not, this would seem to need fixing.
> 
> The X driver calls into the DRM to disable IRQs when it releases the VT, but 
> we could make that just affect vblank interrupts if needed (yay more 
> i915_irq.c changes).

Yeah, I think that's going to be necessary unfortunately, otherwise we 
lose support for changing brightness outside X.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
