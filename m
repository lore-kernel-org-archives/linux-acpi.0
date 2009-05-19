From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] i915/acpi: add lid status notification and detection
Date: Tue, 19 May 2009 18:15:45 +0100
Message-ID: <20090519171545.GA17801@srcf.ucam.org>
References: <20090513115734.338b7d55@jbarnes-g45> <1242264144.3773.415.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57059 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbZESRPx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2009 13:15:53 -0400
Content-Disposition: inline
In-Reply-To: <1242264144.3773.415.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, May 14, 2009 at 09:22:24AM +0800, yakui_zhao wrote:
> On Thu, 2009-05-14 at 02:57 +0800, Jesse Barnes wrote:
> > In the i915 driver we want to know if the lid is open or closed and
> > when its status changes, since we want to use the closed state to
> > indicate that the LFP is unavailable (disconnected in KMS terms) and
> > open to indicate that it's usable.
> > 
> > To that end, this patch adds some code to the ACPI button driver to
> > send us lid notifications as they occur and provide us with current lid
> > status when called.
> > 
> > It's a bit ugly, and I don't handle the inter-module dependencies very
> > well at this point, but you should get the idea.
> The tight module dependency. If the ACPI button is compiled as module
> and i915 is compiled as built-in kernel, we will fail in kernel
> compilation. 

Yes, it needs a Kconfig fixup.

> > There's also a policy question here.  On some machines, a lid close
> > will cause the ACPI firmware to program the GPU, disabling the pipe
> > associated with the panel.  Should we detect this and turn it back on
> > at open time?  That could be dangerous if userspace has received the
> > LVDS hotplug event and changed the config out from under us...
> > 
> > Comments?
> It seems that the LID status is used to determine whether the LVDS is
> connected.
> It is not reliable. On some boxes the initial LID status is incorrect.
> Maybe the LID status is open. But the ACPI returns that the LID is
> close. In such case the LVDS is not initialized and user can't get the
> output.

Really? I haven't seen any cases of this. They'll fail in all sorts of 
fun ways with modern userland.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
