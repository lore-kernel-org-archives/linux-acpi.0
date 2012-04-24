From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/3] acpi_video: Intel video is not always i915
Date: Tue, 24 Apr 2012 22:02:18 +0100
Message-ID: <20120424210218.GA25961@srcf.ucam.org>
References: <20120424154402.1575.90373.stgit@bluebook>
 <20120424154434.1575.91463.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51468 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757643Ab2DXVCV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Apr 2012 17:02:21 -0400
Content-Disposition: inline
In-Reply-To: <20120424154434.1575.91463.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Tue, Apr 24, 2012 at 04:45:01PM +0100, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> Handle the GMA500/600/36x0 cases. Also stop it poking at random registers on
> the i740 cards that may be out there still.

The PowerVR Intels I'd seen had the opregion address in the 0xfc 
register as well. Is this no longer true on the latest?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
