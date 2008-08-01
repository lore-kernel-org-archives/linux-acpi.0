From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI OSI disaster on latest HP laptops - critical temperature
	shutdown
Date: Fri, 1 Aug 2008 19:36:57 -0300
Message-ID: <20080801223657.GD23558@khazad-dum.debian.net>
References: <200807241727.41715.trenn@suse.de> <alpine.LFD.1.10.0807241952270.6098@localhost.localdomain> <200807251319.12786.trenn@suse.de> <alpine.LFD.1.10.0807250948320.3884@localhost.localdomain> <alpine.LFD.1.10.0808011706350.3011@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53266 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756110AbYHAWhD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Aug 2008 18:37:03 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808011706350.3011@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, Arjan van de Ven <arjan@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Christian Kornacker <ckornacker@suse.de>

On Fri, 01 Aug 2008, Len Brown wrote:
> It is better to expose ourselves to the known tested Windows functionality
> -- even if it seems arbitrary, at least it is tested.  The !Windows case
> results in running _completely_ untested BIOS code.

Actually, we should masquerade properly as the latest Windows version
available for that machine, then.  AFAIK, Windows does not set ALL the OSI
strings, just one.  We ARE running untested code in some BIOSes because of
it.

Maybe it would be better if every ACPICA-using OS defined a
_OSI(NotWindows), plus the relevant Windows OSI string they want to support,
and Intel would send word that this string is to be used ONLY to disable all
Windows bug workarounds, not to activate or deactivate any specific
functionality?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
