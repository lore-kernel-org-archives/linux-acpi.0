From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Thu, 10 Jul 2008 12:53:17 +0100
Message-ID: <20080710115317.GA7013@srcf.ucam.org>
References: <200807031809.03172.trenn@suse.de> <200807101315.21904.trenn@suse.de> <20080710111900.GA6303@srcf.ucam.org> <200807101336.08035.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54075 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbYGJLxW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jul 2008 07:53:22 -0400
Content-Disposition: inline
In-Reply-To: <200807101336.08035.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>

On Thu, Jul 10, 2008 at 01:36:04PM +0200, Thomas Renninger wrote:
> On Thursday 10 July 2008 13:19:00 Matthew Garrett wrote:
> > No, I said that on Thinkpads with a PWM method, the PWM method has to be
> > called in order to avoid the delay. There's no need for a blacklist.
> 
> Ok.
> I just got a report that Dells must not use the video driver:
> https://bugzilla.novell.com/show_bug.cgi?id=404627
> 
> They have a really ugly dcdbas driver which issues SMIs triggered from 
> userspace.

If the ACPI video driver has bound, then using the dcdbas mechanism for 
backlight control is incorrect. I wasn't aware that any Dells actually 
implemented that. The correct thing is for userspace to stop using 
dcdbas if a real backlight control is available, not to cripple the 
ACPI video driver.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
