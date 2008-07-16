From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 10/11] thinkpad_acpi: fingers off backlight if video.ko is serving this functionality
Date: Wed, 16 Jul 2008 13:47:03 +0100
Message-ID: <20080716124703.GA376@srcf.ucam.org>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <1216205553-8486-11-git-send-email-trenn@suse.de> <20080716124044.GA3329@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45827 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576AbYGPMrJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jul 2008 08:47:09 -0400
Content-Disposition: inline
In-Reply-To: <20080716124044.GA3329@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, jwoithe@physics.adelaide.edu.au, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

On Wed, Jul 16, 2008 at 09:40:44AM -0300, Henrique de Moraes Holschuh wrote:

> One question: is there a good reason to actually have the hotkey
> handling for IGD mode directly in thinkpad-acpi?  We don't do it for
> Vista BIOS, video.ko doesn't do it either (anymore)... and I would make
> it configurable for IBM firmware if I could.

No. There's no reason to have IGD handling in thinkpad-acpi at all.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
