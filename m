From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Mon, 15 Jul 2013 09:31:27 -0300
Message-ID: <20130715123127.GC28266@khazad-dum.debian.net>
References: <1373888637-20737-1-git-send-email-oliver@neukum.org>
 <1984598.ZdG0izCZul@skinner.arch.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48433 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756005Ab3GOMbd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jul 2013 08:31:33 -0400
Content-Disposition: inline
In-Reply-To: <1984598.ZdG0izCZul@skinner.arch.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: oliver@neukum.org, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, Oliver Neukum <oneukum@suse.de>

On Mon, 15 Jul 2013, Thomas Renninger wrote:
> On Monday, July 15, 2013 01:43:57 PM oliver@neukum.org wrote:
> > Some BIOSes change hardware based on the state of
> > a laptop's lid. If the lid is closed, the touchpad is
> > disabled and the checksum changes. Windows 8 no longer
> > aborts resume if the checksum has changed.

> I expect more machines will show up and ignore s4_hardware_signature
> if Windows does not check it and we should do the same.

Windows *8* does not check.   But what about older versions?  Maybe this
needs to be guarded by verifying the firmware requested windows-8 mode?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
