From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 2/3] acpi_video: Intel video is not always i915
Date: Wed, 25 Apr 2012 13:48:45 +0100
Message-ID: <20120425124845.GB10621@srcf.ucam.org>
References: <20120424154402.1575.90373.stgit@bluebook>
 <20120424154434.1575.91463.stgit@bluebook>
 <20120424210218.GA25961@srcf.ucam.org>
 <20120424233117.6de0da6f@pyramind.ukuu.org.uk>
 <20120424223022.GA27765@srcf.ucam.org>
 <20120425112711.613a3cf9@pyramind.ukuu.org.uk>
 <20120425113152.GA8667@srcf.ucam.org>
 <20120425132438.562c52cf@pyramind.ukuu.org.uk>
 <20120425124018.GA10533@srcf.ucam.org>
 <20120425134940.19ada92f@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53921 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564Ab2DYMsr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Apr 2012 08:48:47 -0400
Content-Disposition: inline
In-Reply-To: <20120425134940.19ada92f@pyramind.ukuu.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Wed, Apr 25, 2012 at 01:49:40PM +0100, Alan Cox wrote:
> On Wed, 25 Apr 2012 13:40:18 +0100
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > No you don't - there's various platforms that will hang if you do that. 
> > It's necessary to make sure that the DIDL fields are set up before 
> > calling any ACPI video functions on opregion hardware.
> 
> Then the existing driver code is already broken, because it ifdefs out
> the check if i915 is not compiled for the kernel.

Yes, that does seem broken. I'm fine with just removing the #ifdefs and 
adding the i740 check.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
