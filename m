From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI/APIC bug
Date: Wed, 2 May 2007 12:44:27 -0300
Message-ID: <20070502154427.GA18127@khazad-dum.debian.net>
References: <46389B41.3060204@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35119 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753655AbXEBPoc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2007 11:44:32 -0400
Content-Disposition: inline
In-Reply-To: <46389B41.3060204@tzi.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Janosch Machowinski <scotch@tzi.de>
Cc: linux-acpi@vger.kernel.org

On Wed, 02 May 2007, Janosch Machowinski wrote:
> can someone with more knowledge than me please take a look at this bug :
> http://bugzilla.kernel.org/show_bug.cgi?id=8367
> and say weather this is a bios or linux bug.

It is about a bug on a ASUS M6Ne laptop, which hard-locks if the lapic is
used.  Booting with nolapic fixes the crash.

Janosh, does your M6Ne also crashes hard if the lapic is enabled? That
information is not clear in the bug report.

Anyway, looks like, at the very least, a blacklist entry for that machine
would be in order.  And that's supposing we are doing nothing wrong while
setting up the lapic in it, as I know nothing about lapics.

I don't trust Windows to be using the lapic at all, if you know how to
verify that, you might want to do so and send that information to the bug
report.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
