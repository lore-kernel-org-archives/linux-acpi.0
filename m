From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] acpi_video: Intel video is not always i915
Date: Wed, 25 Apr 2012 13:49:40 +0100
Message-ID: <20120425134940.19ada92f@pyramind.ukuu.org.uk>
References: <20120424154402.1575.90373.stgit@bluebook>
	<20120424154434.1575.91463.stgit@bluebook>
	<20120424210218.GA25961@srcf.ucam.org>
	<20120424233117.6de0da6f@pyramind.ukuu.org.uk>
	<20120424223022.GA27765@srcf.ucam.org>
	<20120425112711.613a3cf9@pyramind.ukuu.org.uk>
	<20120425113152.GA8667@srcf.ucam.org>
	<20120425132438.562c52cf@pyramind.ukuu.org.uk>
	<20120425124018.GA10533@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:57410 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730Ab2DYMq5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Apr 2012 08:46:57 -0400
In-Reply-To: <20120425124018.GA10533@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Wed, 25 Apr 2012 13:40:18 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Wed, Apr 25, 2012 at 01:24:38PM +0100, Alan Cox wrote:
> 
> > Because as I said before there are two drivers involved and you may only
> > have one compiled into your kernel. If you have
> > 
> > CONFIG_DRM_GMA500=y
> > CONFIG_DRM_I915=n
> > 
> > you want the acpi stuff to autoregister even if an i915 is found, but not
> > if a GMA500 is found. Ditto the reverse.
> 
> No you don't - there's various platforms that will hang if you do that. 
> It's necessary to make sure that the DIDL fields are set up before 
> calling any ACPI video functions on opregion hardware.

Then the existing driver code is already broken, because it ifdefs out
the check if i915 is not compiled for the kernel.

Alan
