From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Oops removing thinkpad_acpi and video on git:linux-acpi-2.6
Date: Sun, 21 Oct 2007 23:32:04 -0200
Message-ID: <20071022013204.GA13019@khazad-dum.debian.net>
References: <87lka1ffwc.fsf@gismo.pca.it> <20071018012106.GA24821@khazad-dum.debian.net> <87tzoo2q3x.fsf@gismo.pca.it> <20071018230334.GD4483@khazad-dum.debian.net> <871wbr2u1r.fsf@gismo.pca.it> <20071020002720.GA21173@khazad-dum.debian.net> <87myuccqen.fsf@gismo.pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40846 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750979AbXJVBcM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Oct 2007 21:32:12 -0400
Content-Disposition: inline
In-Reply-To: <87myuccqen.fsf@gismo.pca.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Capello <luca@pca.it>
Cc: ML Linux-ACPI <linux-acpi@vger.kernel.org>

On Sun, 21 Oct 2007, Luca Capello wrote:
> BTW, I needed to play a bit with module loading/unloading, since the
> first time I removed the thinkpad_acpi module the oops wasn't
> triggered.

Hmm, am I going crazy, or did the OOPS happen with an instance of
thinkpad-acpi *not* loaded with debug=0xffff?  Can you try that again making
sure it always gets the debug=0xfffff parameter?  Apparently, it was active
only the first time you tried to load the module, and I wanted to see the
exit path debug messages of the instance that gets an OOPS...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
