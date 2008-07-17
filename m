From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 10/11] thinkpad_acpi: fingers off backlight if video.ko is serving this functionality
Date: Thu, 17 Jul 2008 12:25:30 +0100
Message-ID: <20080717112530.GA25454@srcf.ucam.org>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <20080716124703.GA376@srcf.ucam.org> <20080716133839.GB3329@khazad-dum.debian.net> <200807161727.57026.trenn@suse.de> <20080716152938.GA8676@srcf.ucam.org> <487F0C9B.4010502@linux.intel.com> <20080717104622.GA24906@srcf.ucam.org> <20080717111808.GC16009@corsac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33568 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbYGQLZk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 07:25:40 -0400
Content-Disposition: inline
In-Reply-To: <20080717111808.GC16009@corsac.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Andi Kleen <ak@linux.intel.com>, Thomas Renninger <trenn@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, jwoithe@physics.adelaide.edu.au, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

On Thu, Jul 17, 2008 at 01:18:08PM +0200, Yves-Alexis Perez wrote:
> On Thu, Jul 17, 2008 at 11:46:22AM +0100, Matthew Garrett wrote:
> > The opregion brightness control code is part of the DRM tree, not ACPI. 
> > It ought to be entirely orthogonal to Thomas' patches.
> 
> For an "end user", what does this mean? What patches should we apply,
> against which tree, in order to be able to test and validate Thomas's
> patches?

Easiest is to wait for the DRM tree to be merged. The patch is against 
DRM master, which doesn't apply directly to Linux - it needs some 
post-processing first.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
