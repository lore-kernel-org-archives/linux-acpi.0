From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Oops removing thinkpad_acpi and video on git:linux-acpi-2.6
Date: Fri, 2 Nov 2007 17:42:47 -0200
Message-ID: <20071102194247.GA32647@khazad-dum.debian.net>
References: <20071018012106.GA24821@khazad-dum.debian.net> <87tzoo2q3x.fsf@gismo.pca.it> <20071018230334.GD4483@khazad-dum.debian.net> <871wbr2u1r.fsf@gismo.pca.it> <20071020002720.GA21173@khazad-dum.debian.net> <87myuccqen.fsf@gismo.pca.it> <20071022013204.GA13019@khazad-dum.debian.net> <87prz7myq9.fsf@gismo.pca.it> <20071022170021.GA30584@khazad-dum.debian.net> <87d4ushgw8.fsf@gismo.pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37308 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752648AbXKBTmw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Nov 2007 15:42:52 -0400
Content-Disposition: inline
In-Reply-To: <87d4ushgw8.fsf@gismo.pca.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Capello <luca@pca.it>
Cc: ML Linux-ACPI <linux-acpi@vger.kernel.org>

On Fri, 02 Nov 2007, Luca Capello wrote:
> The oops removing ACPI's video module occurred both in 2.6.23.1 (with
> thinkpad-acpi-0.18) or today's git pull for linux-acpi-2.6.

Yeah, it is as I feared. Something is broken in 2.6.23.1 and later
(actually, LOTs of things are broken in 2.6.24-rc :p).

> the laptop with the BIOS upgraded.  So, if any urgent test is needed,
> I can perform it during the week-end.

Don't worry about it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
