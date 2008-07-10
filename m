From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RESEND] [PATCH -next 2/2] acpi,rfkill,backlight:
	comapl-laptop update - use rfkill switch subsystem
Date: Wed, 9 Jul 2008 22:07:49 -0300
Message-ID: <20080710010749.GB15729@khazad-dum.debian.net>
References: <20080709231059.778d16f4@debian> <200807092333.01355.IvDoorn@gmail.com> <20080709234419.12d6eabc@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:35356 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753144AbYGJBHy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jul 2008 21:07:54 -0400
Content-Disposition: inline
In-Reply-To: <20080709234419.12d6eabc@debian>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
Cc: Ivo van Doorn <ivdoorn@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@linux-foundation.org>

On Wed, 09 Jul 2008, Cezary Jackiewicz wrote:
> Does calling rfkill_force_state () is mandatory? This driver implement 
> get_state() hook, @state is always up-to-date.

It is not mandatory, but you will get delays and anti-social behaviour if
you don't implement rfkill_force_state() on hardware that can do
HARD_BLOCKED, and rfkill will be able to notice changes only when
"provoked".

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
