From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: battery: current a factor of 10 off?
Date: Thu, 20 Nov 2008 23:31:52 -0200
Message-ID: <20081121013152.GA18318@khazad-dum.debian.net>
References: <87skplx6ho.fsf@szonett.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45919 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752132AbYKUBb7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Nov 2008 20:31:59 -0500
Content-Disposition: inline
In-Reply-To: <87skplx6ho.fsf@szonett.ki.iif.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-acpi@vger.kernel.org

On Fri, 21 Nov 2008, Ferenc Wagner wrote:
> on my ThinkPad R50e the current_now reading seems something like 10
> times the actual value.  Documentation/power/power_supply_class.txt
> says it's in uA, and a tipical discharge value is around 15259000,
> that is, 15 A on my system.  At the same time voltage is 11756000,
> that is, 12 V, which sounds reasonable, but then the power is 15*12 VA,
> ie 180 W, which is insane.  However, the numerical derivative of
> energy_now gives 18 W, which is both reasonable and consistent with
> the assumed factor of 10 error in current_now.  Is this possibly a bug
> in 2.6.26.6?  During a quick glance over battery.c nothing obvious
> jumped at me, but I'm no expert on this.

You could also patch in tp_smapi and compare with the data you get from both
drivers.  If they are both wrong, you need a BIOS/EC firmware update.  If
there is none, we will need DMI quirks on both drivers to work around the
issue.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
