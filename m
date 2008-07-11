From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/9] Check whether ACPI graphics device is physically present
Date: Fri, 11 Jul 2008 10:06:52 +0100
Message-ID: <20080711090652.GC24714@srcf.ucam.org>
References: <1215700265-24908-1-git-send-email-trenn@suse.de> <200807102106.27944.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54360 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbYGKJHv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jul 2008 05:07:51 -0400
Content-Disposition: inline
In-Reply-To: <200807102106.27944.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: andi@firstfloor.org, rui.zhang@intel.com, jwoithe@physics.adelaide.edu.au, malattia@linux.it, corentincj@iksaif.net, mzxreary@0pointer.de, hmh@hmh.eng.br, carlos@strangeworlds.co.uk, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org

On Thu, Jul 10, 2008 at 09:06:24PM +0200, Thomas Renninger wrote:
> This one is needed also.
> Matthew made me a bit nervous about it,but to detect video capabilities it is 
> necessary to know whether the ACPI graphics device is really there.
> The IGD problems should be solved now and this can be added, right? IMO it 
> could have been added before also because the other patches took care about 
> the reported regression.

The patch is good, but the comment still indicates that you want to 
force control over to thinkpad_acpi. We're not going to do that, so 
either resend it without that inference or I can resend it when I get 
back home next week.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
