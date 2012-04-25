From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/3] acpi_video: Intel video is not always i915
Date: Wed, 25 Apr 2012 13:40:18 +0100
Message-ID: <20120425124018.GA10533@srcf.ucam.org>
References: <20120424154402.1575.90373.stgit@bluebook>
 <20120424154434.1575.91463.stgit@bluebook>
 <20120424210218.GA25961@srcf.ucam.org>
 <20120424233117.6de0da6f@pyramind.ukuu.org.uk>
 <20120424223022.GA27765@srcf.ucam.org>
 <20120425112711.613a3cf9@pyramind.ukuu.org.uk>
 <20120425113152.GA8667@srcf.ucam.org>
 <20120425132438.562c52cf@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36462 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab2DYMkW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Apr 2012 08:40:22 -0400
Content-Disposition: inline
In-Reply-To: <20120425132438.562c52cf@pyramind.ukuu.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Wed, Apr 25, 2012 at 01:24:38PM +0100, Alan Cox wrote:

> Because as I said before there are two drivers involved and you may only
> have one compiled into your kernel. If you have
> 
> CONFIG_DRM_GMA500=y
> CONFIG_DRM_I915=n
> 
> you want the acpi stuff to autoregister even if an i915 is found, but not
> if a GMA500 is found. Ditto the reverse.

No you don't - there's various platforms that will hang if you do that. 
It's necessary to make sure that the DIDL fields are set up before 
calling any ACPI video functions on opregion hardware.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
