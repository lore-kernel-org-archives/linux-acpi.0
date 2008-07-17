From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] acpi: Avoid dropping rapid hotkey events (or other
	GPEs) on Asus EeePC
Date: Thu, 17 Jul 2008 15:50:32 -0300
Message-ID: <20080717185032.GD18457@khazad-dum.debian.net>
References: <487D23C3.5070301@student.cs.york.ac.uk> <487F31D7.30803@suse.de> <20080717121309.GF31732@khazad-dum.debian.net> <487F3B6D.3090507@suse.de> <20080717162628.GB18457@khazad-dum.debian.net> <487F7724.5080905@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:55371 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756218AbYGQSui (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jul 2008 14:50:38 -0400
Content-Disposition: inline
In-Reply-To: <487F7724.5080905@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 17 Jul 2008, Alan Jenkins wrote:
> Actually Alexey has another patch in bugzilla (#10919) which resolves
> this issue in a better way.  It avoids polling altogether, which is good
> because it means you get events immediately.  My laptop has backlight
> adjustment hotkeys with hardware autorepeat, so it looks really jerky
> with polling.

We need to get ALL pending events from the EC, whether in polling mode or in
interrupt mode (and we must make sure that we ARE going to queue any new
interrupt before we stop checking for an empty pending event queue,
otherwise there is a small window where a new event might get queued, and we
are still masking the GPE and don't notice it).  As long as the fix does
that, it is all I care :-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
