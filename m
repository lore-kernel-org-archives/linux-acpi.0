From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Oops removing thinkpad_acpi and video on git:linux-acpi-2.6
Date: Fri, 19 Oct 2007 22:27:20 -0200
Message-ID: <20071020002720.GA21173@khazad-dum.debian.net>
References: <87lka1ffwc.fsf@gismo.pca.it> <20071018012106.GA24821@khazad-dum.debian.net> <87tzoo2q3x.fsf@gismo.pca.it> <20071018230334.GD4483@khazad-dum.debian.net> <871wbr2u1r.fsf@gismo.pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37308 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759035AbXJTA10 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Oct 2007 20:27:26 -0400
Content-Disposition: inline
In-Reply-To: <871wbr2u1r.fsf@gismo.pca.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Capello <luca@pca.it>
Cc: ML Linux-ACPI <linux-acpi@vger.kernel.org>

On Fri, 19 Oct 2007, Luca Capello wrote:
> On Fri, 19 Oct 2007 01:03:34 +0200, Henrique de Moraes Holschuh wrote:
> > On Thu, 18 Oct 2007, Luca Capello wrote:
> >> Since I experienced the oops after having changed the LCD
> >> brightness, I pressed several times the brightness up/down Fn keys,
> >> then removed only the thinkpad_acpi module and voila, I got the
> >> oops again.
> [...]
> >
> > Hmm, I will see if I can reproduce it.
> 
> Thank you.

Unfortunately, I can't reproduce it.  Might be a 32/64 bit issue, since I
can only test x86-32, or I could not duplicate exactly what is causing the
problem, but...

Please compile thinkpad-acpi and ACPI with the debug modes enabled, and load
thinkpad-acpi with the debug=0xffff parameter.  Then reproduce the oops, and
send me the entire kernel output since driver load until the oops.

You could also try turning on some of the ACPI debug bits, one of them
(sorry, I don't know which) will tell you exactly which device's notify
handler it is calling.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
