From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/3] acpi_video: Intel video is not always i915
Date: Tue, 24 Apr 2012 23:30:22 +0100
Message-ID: <20120424223022.GA27765@srcf.ucam.org>
References: <20120424154402.1575.90373.stgit@bluebook>
 <20120424154434.1575.91463.stgit@bluebook>
 <20120424210218.GA25961@srcf.ucam.org>
 <20120424233117.6de0da6f@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52415 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757347Ab2DXWa1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Apr 2012 18:30:27 -0400
Content-Disposition: inline
In-Reply-To: <20120424233117.6de0da6f@pyramind.ukuu.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Tue, Apr 24, 2012 at 11:31:17PM +0100, Alan Cox wrote:
> On Tue, 24 Apr 2012 22:02:18 +0100
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > The PowerVR Intels I'd seen had the opregion address in the 0xfc 
> > register as well. Is this no longer true on the latest?
> 
> PowerVR does - i740 never did.
> 
> The PowerVR 0xfc poking also doesn't currently work once the driver takes
> over because it isn't yet implementing the driver end of the weird ACPI
> messaging/event stuff.
> 
> Once it does the GMA500 will be able to do an ACPI video register, but we
> will still need the check to get the ifdeffery right for what drivers are
> compiled for the kernel.

Right now you seem to set opregion unconditionally on PVR, which seems 
to be equivalent to the 0xfc check that was there before - I can 
understand excluding i740, but the PVR check could be left with the gen 
hardware one?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
