From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] acpi_video: Intel video is not always i915
Date: Wed, 25 Apr 2012 13:24:38 +0100
Message-ID: <20120425132438.562c52cf@pyramind.ukuu.org.uk>
References: <20120424154402.1575.90373.stgit@bluebook>
	<20120424154434.1575.91463.stgit@bluebook>
	<20120424210218.GA25961@srcf.ucam.org>
	<20120424233117.6de0da6f@pyramind.ukuu.org.uk>
	<20120424223022.GA27765@srcf.ucam.org>
	<20120425112711.613a3cf9@pyramind.ukuu.org.uk>
	<20120425113152.GA8667@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:50697 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab2DYMV7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Apr 2012 08:21:59 -0400
In-Reply-To: <20120425113152.GA8667@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Wed, 25 Apr 2012 12:31:52 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Wed, Apr 25, 2012 at 11:27:11AM +0100, Alan Cox wrote:
> > On Tue, 24 Apr 2012 23:30:22 +0100
> > Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > Right now you seem to set opregion unconditionally on PVR, which seems 
> > > to be equivalent to the 0xfc check that was there before - I can 
> > > understand excluding i740, but the PVR check could be left with the gen 
> > > hardware one?
> > 
> > Not really - they are two drivers. If you build with i915 and not GMA500
> > you need the opregion for one and the acpi fallback for the other, and
> > vice versa. So we have to check both CONFIG_xxx macro sets.
> > 
> > Right now GMA500 needs the ACPI video stuff never to be enabled on some
> > machines. Until we've got full opregion support in the driver that won't
> > change.
> 
> opregion always seems to be set to 1 if is_gma_pvr() is true, which 
> means we'll now never bind the acpi video driver on PVR hardware. If 
> that's what you want, why distinguish between PVR and GEN?

Because as I said before there are two drivers involved and you may only
have one compiled into your kernel. If you have

CONFIG_DRM_GMA500=y
CONFIG_DRM_I915=n

you want the acpi stuff to autoregister even if an i915 is found, but not
if a GMA500 is found. Ditto the reverse.

Alan
