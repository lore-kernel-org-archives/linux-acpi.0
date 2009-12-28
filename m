From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 3/5] thinkpad-acpi: make volume subdriver optional
Date: Mon, 28 Dec 2009 11:17:45 -0200
Message-ID: <20091228131744.GC19362@khazad-dum.debian.net>
References: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
 <1261875137-27565-4-git-send-email-hmh@hmh.eng.br>
 <s5hr5qgvjsa.wl%tiwai@suse.de>
 <20091227183220.GB3027@khazad-dum.debian.net>
 <4B37E1AF.6030105@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49256 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751061AbZL1NRs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Dec 2009 08:17:48 -0500
Content-Disposition: inline
In-Reply-To: <4B37E1AF.6030105@collabora.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ian Molton <ian.molton@collabora.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>, Amerigo Wang <amwang@redhat.com>, Helight Xu <helight.xu@gmail.com>

On Sun, 27 Dec 2009, Ian Molton wrote:
> Not directly related to your patch but I thought I'd mention...
> 
> I've noticed issues with my X200 re: routing audio before / after docking.

ThinkPads used to route line-out to the dock, with a fixed 1.1dB amplifier
(0.1dB increase) in the audio path, and had the volume control for
headphones and speakers done in a different audio path, extracted before the
line-out amplifier.  The PeeCee beeper channel was routed to the headphones
and speakers, only.

If Lenovo tried to reproduce that with the HDA mixer but without the "Laptop
Apudio Controller" the IBM thinkpads had, I wouldn't be surprised if it
causes massive ALSA disruption should the firmware screw with the HDA mixer
registers behind ALSA's back.  Try asking the kernel to enable OSI(Linux) in
ACPI...  I always forget the kernel command line parameter to do that, but
it is documented in the usual place.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
