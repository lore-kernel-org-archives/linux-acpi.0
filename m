From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 00/37] PNP resource_table cleanups
Date: Wed, 26 Mar 2008 17:13:00 -0600
Message-ID: <200803261713.03248.bjorn.helgaas@hp.com>
References: <20080326171058.099442579@ldl.fc.hp.com> <200803261842.11023.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:20437 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbYCZXJF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 19:09:05 -0400
In-Reply-To: <200803261842.11023.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

On Wednesday 26 March 2008 04:42:10 pm Len Brown wrote:
> i386:
> 
> #1 errs.ACPI.ACPI_DEBUG.ACPI_PROCFS.HIBERNATION.X86_LOCAL_APIC.X86_IO_APIC
> Cleaning...Building...
> ERROR: "pnp_get_resource" [sound/oss/sb.ko] undefined!
> ERROR: "pnp_get_resource" [sound/oss/ad1848.ko] undefined!

Oops, sorry, I forgot to export pnp_get_resource().  I'll post an
updated patch as a response to the original.  Is that easy for you
to handle, Len?  If not, let me know what you'd prefer.

Bjorn

