From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 10/11] thinkpad_acpi: fingers off backlight if video.ko
	is serving this functionality
Date: Wed, 16 Jul 2008 10:38:39 -0300
Message-ID: <20080716133839.GB3329@khazad-dum.debian.net>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <1216205553-8486-11-git-send-email-trenn@suse.de> <20080716124044.GA3329@khazad-dum.debian.net> <20080716124703.GA376@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:44983 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756339AbYGPNim (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 09:38:42 -0400
Content-Disposition: inline
In-Reply-To: <20080716124703.GA376@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, jwoithe@physics.adelaide.edu.au, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

On Wed, 16 Jul 2008, Matthew Garrett wrote:
> On Wed, Jul 16, 2008 at 09:40:44AM -0300, Henrique de Moraes Holschuh wrote:
> > One question: is there a good reason to actually have the hotkey
> > handling for IGD mode directly in thinkpad-acpi?  We don't do it for
> > Vista BIOS, video.ko doesn't do it either (anymore)... and I would make
> > it configurable for IBM firmware if I could.
> 
> No. There's no reason to have IGD handling in thinkpad-acpi at all.

Then please leave that part out of the final patch.  It will make the
patch a LOT simpler (no need to muck with anything hotkey_*).

But the observation about extending brightness_mode to
force-select/unselect igdmode stands anyway.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
