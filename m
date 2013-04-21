From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Sun, 21 Apr 2013 12:46:46 -0300
Message-ID: <20130421154646.GC16086@khazad-dum.debian.net>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
 <20130318212546.GC3964@thinkpad-t410>
 <20130419122403.GI4699@thinkpad-t410>
 <5063522.ljsshHL4Hy@vostro.rjw.lan>
 <20130421022956.GA25614@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49507 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751143Ab3DUPqw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Apr 2013 11:46:52 -0400
Content-Disposition: inline
In-Reply-To: <20130421022956.GA25614@thinkpad-t410>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Aaron Lu <aaron.lu@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>

On Sat, 20 Apr 2013, Seth Forshee wrote:
> pre-Win8 behavior, but of course that requires quirking. If we could
> assume that all graphics drivers will export backlight control then just
> disabling the ACPI interface for these machines would work nearly as
> well, but I don't think we can count on that, and it probably requires
> quirking as well.

You can certainly do that for all thinkpads with win8 compatibility.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
