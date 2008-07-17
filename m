From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 10/11] thinkpad_acpi: fingers off backlight if video.ko is serving this functionality
Date: Thu, 17 Jul 2008 11:46:22 +0100
Message-ID: <20080717104622.GA24906@srcf.ucam.org>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <20080716124703.GA376@srcf.ucam.org> <20080716133839.GB3329@khazad-dum.debian.net> <200807161727.57026.trenn@suse.de> <20080716152938.GA8676@srcf.ucam.org> <487F0C9B.4010502@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37783 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbYGQKqc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 06:46:32 -0400
Content-Disposition: inline
In-Reply-To: <487F0C9B.4010502@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Renninger <trenn@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, jwoithe@physics.adelaide.edu.au, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

On Thu, Jul 17, 2008 at 11:10:51AM +0200, Andi Kleen wrote:
> Matthew Garrett wrote:
> >The patch is queued and will be in 2.6.27. It's fine.
> 
> I admit I have lost track of the state of these patches. If there's an 
> agreed subset of patches that should go in post .27 via ACPI please 
> resend them for review.

The opregion brightness control code is part of the DRM tree, not ACPI. 
It ought to be entirely orthogonal to Thomas' patches.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
