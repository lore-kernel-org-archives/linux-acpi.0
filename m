From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] ACPI Video: Ignore devices that aren't present in hardware
Date: Thu, 3 Jul 2008 17:08:22 +0100
Message-ID: <20080703160822.GA29110@srcf.ucam.org>
References: <200807031805.52883.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52549 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYGCQI3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jul 2008 12:08:29 -0400
Content-Disposition: inline
In-Reply-To: <200807031805.52883.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Julia Jomantaite <julia.jomantaite@gmail.com>, marcus@better.se, dannybaumann@web.de, corsac@debian.org

On Thu, Jul 03, 2008 at 06:05:51PM +0200, Thomas Renninger wrote:
> Can these two go to linux-next or -mm, pls.

Not until the opregion code is merged, no. If you'd like that to happen 
faster, then figuring out why it triggers a 750ms delay on brightness 
changes on the T61 would be a great help, because I haven't a clue why 
it's broken...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
