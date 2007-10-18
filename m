From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Oops removing thinkpad_acpi and video on git:linux-acpi-2.6
Date: Thu, 18 Oct 2007 21:03:34 -0200
Message-ID: <20071018230334.GD4483@khazad-dum.debian.net>
References: <87lka1ffwc.fsf@gismo.pca.it> <20071018012106.GA24821@khazad-dum.debian.net> <87tzoo2q3x.fsf@gismo.pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51702 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751816AbXJRXDn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Oct 2007 19:03:43 -0400
Content-Disposition: inline
In-Reply-To: <87tzoo2q3x.fsf@gismo.pca.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Capello <luca@pca.it>
Cc: ML Linux-ACPI <linux-acpi@vger.kernel.org>

On Thu, 18 Oct 2007, Luca Capello wrote:
> Since I experienced the oops after having changed the LCD brightness,
> I pressed several times the brightness up/down Fn keys, then removed
> only the thinkpad_acpi module and voila, I got the oops again.  So,
> the problem is a thinkpad_acpi one, confirmed by the fact that the
> same test with the video module only didn't generate the oops.
> However, if the video module is not present, thinkpad_acpi doesn't
> trigger the oops.

Hmm, I will see if I can reproduce it.  Do you get that problem if you use
2.6.23 + thinkpad-acpi 0.18-20071013 available at:
http://sourceforge.net/project/showfiles.php?group_id=117042  ?

There is also a git tree, if you prefer:
http://repo.or.cz/w/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
for the gitweb interface, there is more data in that.  Look at the release/
branches.

> Should I perform my tests again with the new BIOS?  Or is this bug
> completely unrelated to the BIOS version?

The bug might even be triggered by the BIOS, but it is a real bug in the
driver.  But the new BIOS will probably behave much better re. brightness
functions.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
