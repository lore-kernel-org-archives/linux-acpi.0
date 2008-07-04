From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver v0.94
Date: Fri, 4 Jul 2008 09:22:47 -0300
Message-ID: <20080704122247.GF7435@khazad-dum.debian.net>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080704034419.GG4381@prithivi.gnumonks.org> <20080704091031.GA8905@srcf.ucam.org> <20080704120754.GC7435@khazad-dum.debian.net> <20080704121116.GA11510@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57889 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752766AbYGDMWw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jul 2008 08:22:52 -0400
Content-Disposition: inline
In-Reply-To: <20080704121116.GA11510@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Harald Welte <laforge@gnumonks.org>, linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>

On Fri, 04 Jul 2008, Matthew Garrett wrote:
> On Fri, Jul 04, 2008 at 09:07:54AM -0300, Henrique de Moraes Holschuh wrote:
> > Unless someone posts a recipe here of how to get HAL to connect to an input
> > device, and how to tell it to run code when a KEY_* event is received (which
> > you could add to the driver documentation), I'd say proc_generate_event will
> > have to be tolerated.  It is all most people know how to deal with in
> > userspace.
> 
> hal has bound to input devices for years. It won't run code directly, 
> since that's a policy decision, but lshal -m should show events come 
> from input devices.

Is there an easy way to duplicate what acpid does (i.e. give HAL some config
file that tells it to run an extrenal script when it gets a certain event)?
If there is not, it is no wonder people don't want to go away from acpid and
we have to keep proc_generate_event around...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
