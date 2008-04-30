From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 091/171] ACPI: GPE enabling should happen after EC
	installation
Date: Wed, 30 Apr 2008 11:53:11 -0300
Message-ID: <20080430145311.GD3543@khazad-dum.debian.net>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org> <204470272c3b055b352d5f127d5d5c7dce5fa597.1209457069.git.len.brown@intel.com> <1209551134.12515.47.camel@yakui_zhao.sh.intel.com> <200804300758.54778.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59716 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759316AbYD3OxO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Apr 2008 10:53:14 -0400
Content-Disposition: inline
In-Reply-To: <200804300758.54778.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>

On Wed, 30 Apr 2008, Carlos Corbacho wrote:
> On Wednesday 30 April 2008 11:25:34 Zhao Yakui wrote:
> > On Tue, 2008-04-29 at 04:44 -0400, Len Brown wrote:
> > > From: Alexey Starikovskiy <astarikovskiy@suse.de>
> > >
> > > GPE could try to access EC region, so should not be enabled before
> > > EC is installed
> >
> > It is caused by broken bios if GPE method tries to access EC region
> > before EC is initialized correctly. It is more appropriate to fix this
> > issue by upgrading bios rather than by the patch.
> > And this patch will cause some potential problems.
> 
> 1) Does the BIOS in question work under Windows?
> 2) Does the system in question require a BIOS upgrade under Windows for this 
> issue?
> 
> If the answer to both of those is 'no', then the answer is that it's a Linux 
> bug, and a patch of some description is appropriate.

3) Did the vendor issue an O.S. "driver workaround"?  If so, it means we
add a *quirk*, and not that we hose ACPI for everyone else.

> Just because there are crappy BIOS's out there, and we'd rather not put in 
> nasty fixes, doesn't mean that we shouldn't.

But it means we need to limit the damage these nasty fixes can do to
others.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
