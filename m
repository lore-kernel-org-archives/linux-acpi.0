From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/5] thinkpad-acpi: improve Kconfig help text
Date: Mon, 28 Dec 2009 11:35:22 -0200
Message-ID: <20091228133522.GD19362@khazad-dum.debian.net>
References: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
 <1261875137-27565-6-git-send-email-hmh@hmh.eng.br>
 <20091228133006.GD4429@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53975 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750905AbZL1NfZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Dec 2009 08:35:25 -0500
Content-Disposition: inline
In-Reply-To: <20091228133006.GD4429@thunk.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tytso@mit.edu
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Mon, 28 Dec 2009, tytso@mit.edu wrote:
> By the way, just as a point of information, Ubuntu Karmic seems to
> have some kind of bug with their sound system (I suspect their
> Pulseaudio integration) which cases sound to be completely
> non-functional if ALSA is built in.  I had to build ALSA as modules in
> order for Ubuntu to work correctly.

Maybe they are depending on module parameters for it to work, and adding
those automagically behind your back in the modprobe.d config stuff but
ignoring the kernel command line?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
