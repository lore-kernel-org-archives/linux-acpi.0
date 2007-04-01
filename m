From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.21-rc5: Thinkpad X60 gets critical thermal shutdowns
Date: Sun, 1 Apr 2007 19:44:26 -0300
Message-ID: <20070401224425.GA28561@khazad-dum.debian.net>
References: <460E0158.7090705@goop.org> <200703311131.54704.ak@suse.de> <20070401163031.GA5762@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48193 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965233AbXDAWod (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Apr 2007 18:44:33 -0400
Content-Disposition: inline
In-Reply-To: <20070401163031.GA5762@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andi Kleen <ak@suse.de>, Jeremy Fitzhardinge <jeremy@goop.org>, "Brown, Len" <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Sun, 01 Apr 2007, Pavel Machek wrote:
> Are you running lm_sensors?

lm-sensors can't confuse any recent thinkpad's thermal management.  The i2c
buses that matter are all behind the EC, you have to ask the EC for data.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
