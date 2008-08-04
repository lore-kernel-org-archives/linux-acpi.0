From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPIdrivers - version 4
Date: Mon, 4 Aug 2008 14:24:50 +0100
Message-ID: <20080804132450.GA3703@srcf.ucam.org>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <200808041220.29892.trenn@suse.de> <20080804103929.GC28887@corsac.net> <200808041319.44362.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51158 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171AbYHDNY5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Aug 2008 09:24:57 -0400
Content-Disposition: inline
In-Reply-To: <200808041319.44362.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Yves-Alexis Perez <corsac@debian.org>, Zhang Rui <rui.zhang@intel.com>, ak@linux.intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, hmh@debian.org

On Mon, Aug 04, 2008 at 01:19:42PM +0200, Thomas Renninger wrote:

> I just tried to find them in the tree that I thought Matthew stated that they 
> are queued their in the master branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

It got dropped after the vblank IRQ rewrite code got merged. I'll have 
it remerged today.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
