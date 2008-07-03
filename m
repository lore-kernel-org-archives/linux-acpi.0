From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/2] ACPI Video: Ignore devices that aren't present in hardware
Date: Thu, 3 Jul 2008 18:15:11 +0200
Message-ID: <200807031815.13291.trenn@suse.de>
References: <200807031805.52883.trenn@suse.de> <20080703160822.GA29110@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:46337 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001AbYGCQPP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Jul 2008 12:15:15 -0400
In-Reply-To: <20080703160822.GA29110@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Julia Jomantaite <julia.jomantaite@gmail.com>, marcus@better.se, dannybaumann@web.de, corsac@debian.org

On Thursday 03 July 2008 18:08:22 Matthew Garrett wrote:
> On Thu, Jul 03, 2008 at 06:05:51PM +0200, Thomas Renninger wrote:
> > Can these two go to linux-next or -mm, pls.
>
> Not until the opregion code is merged, no.
Why?

> If you'd like that to happen 
> faster, then figuring out why it triggers a 750ms delay on brightness
> changes on the T61 would be a great help, because I haven't a clue why
> it's broken...

Try the next patch, it works for the T61.
These IGD parts could take quite a while still, while Toshibas and others
remain broken (and T61 poke on wrong hardware which could cause
all kind of badness).
The patch has an easy switch to allow video.ko to take over again
if IGD is detected and Linux is capable of it.

Please consider to take these two.

Thanks,

   Thomas
