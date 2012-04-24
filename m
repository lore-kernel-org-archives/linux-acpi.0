From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] acpi_video: Intel video is not always i915
Date: Tue, 24 Apr 2012 23:31:17 +0100
Message-ID: <20120424233117.6de0da6f@pyramind.ukuu.org.uk>
References: <20120424154402.1575.90373.stgit@bluebook>
	<20120424154434.1575.91463.stgit@bluebook>
	<20120424210218.GA25961@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54305 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757347Ab2DXW2k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Apr 2012 18:28:40 -0400
In-Reply-To: <20120424210218.GA25961@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Tue, 24 Apr 2012 22:02:18 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Tue, Apr 24, 2012 at 04:45:01PM +0100, Alan Cox wrote:
> > From: Alan Cox <alan@linux.intel.com>
> > 
> > Handle the GMA500/600/36x0 cases. Also stop it poking at random registers on
> > the i740 cards that may be out there still.
> 
> The PowerVR Intels I'd seen had the opregion address in the 0xfc 
> register as well. Is this no longer true on the latest?

PowerVR does - i740 never did.

The PowerVR 0xfc poking also doesn't currently work once the driver takes
over because it isn't yet implementing the driver end of the weird ACPI
messaging/event stuff.

Once it does the GMA500 will be able to do an ACPI video register, but we
will still need the check to get the ifdeffery right for what drivers are
compiled for the kernel.

Alan
