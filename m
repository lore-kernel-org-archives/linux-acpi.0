From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] bay: Exit if notify handler cannot be installed
Date: Wed, 7 May 2008 09:43:30 -0300
Message-ID: <20080507124330.GB19475@khazad-dum.debian.net>
References: <20080505202508.GA3690@homac> <20080506091522.GA4378@homac> <1210065811.12668.1.camel@sli10-desk.sh.intel.com> <20080506151846.GA22828@khazad-dum.debian.net> <1210122279.27316.2.camel@sli10-desk.sh.intel.com> <20080507011354.GA8163@khazad-dum.debian.net> <1210123658.30944.6.camel@sli10-desk.sh.intel.com> <20080507123715.GA19475@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53693 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758932AbYEGMnd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 May 2008 08:43:33 -0400
Content-Disposition: inline
In-Reply-To: <20080507123715.GA19475@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Holger Macht <hmacht@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Accardi, Kristen C" <kristen.c.accardi@intel.com>

Forgot one detail:
On Wed, 07 May 2008, Henrique de Moraes Holschuh wrote:
> 2. Even if a bay can take different types of devices, the same bay may
> appear as a number of different EJ0 handlers.  In that case, the
> firmware is to know which handler to use based on which type of device
> is inside the bay.  Thinkpads do this.

But calling EJ0 on any of the devices that might fit the bay will eject
whatever is in the bay, regardless of it being the "active device" in
the bay or not.

This is why bay can be used in a thinkpad to eject BAT1 (a battery),
their EJ0 handlers do exactly the same thing.  You don't get the bay
request eject and bay ejected events since bay.c doesn't tie itself to
the battery ACPI node, but you can eject it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
