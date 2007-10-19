From: Luca Capello <luca@pca.it>
Subject: Re: Oops removing thinkpad_acpi and video on git:linux-acpi-2.6
Date: Fri, 19 Oct 2007 14:00:32 +0200
Message-ID: <871wbr2u1r.fsf@gismo.pca.it>
References: <87lka1ffwc.fsf@gismo.pca.it>
 <20071018012106.GA24821@khazad-dum.debian.net> <87tzoo2q3x.fsf@gismo.pca.it>
 <20071018230334.GD4483@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mbox.unige.ch ([129.194.9.209]:34979 "EHLO mbox.unige.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405AbXJSMAe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Oct 2007 08:00:34 -0400
Received: from gismo.pca.it ([129.194.56.110])
 by mbox.unige.ch (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9
 2007; 32bit)) with ESMTPSA id <0JQ5005OWQOWKW10@mbox.unige.ch> for
 linux-acpi@vger.kernel.org; Fri, 19 Oct 2007 14:00:32 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ML Linux-ACPI <linux-acpi@vger.kernel.org>

Hi Henrique!

On Fri, 19 Oct 2007 01:03:34 +0200, Henrique de Moraes Holschuh wrote:
> On Thu, 18 Oct 2007, Luca Capello wrote:
>> Since I experienced the oops after having changed the LCD
>> brightness, I pressed several times the brightness up/down Fn keys,
>> then removed only the thinkpad_acpi module and voila, I got the
>> oops again.
[...]
>
> Hmm, I will see if I can reproduce it.

Thank you.

> Do you get that problem if you use 2.6.23 + thinkpad-acpi
> 0.18-20071013 available at:
> http://sourceforge.net/project/showfiles.php?group_id=117042 ?

I tested 2.6.23.1 + 0.18-20071013, oops still there.  Should I test it
with the latest linux-acpi-2.6 git tree, also?  I don't think it's
necessary, but I can do it in case (but please read below).

> There is also a git tree, if you prefer:
> http://repo.or.cz/w/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for
> the gitweb interface, there is more data in that.  Look at the
> release/ branches.

Sorry, I'm quite lost with the git tree: in release/ there's nothing
about the latest linux-acpi-2.6 tree, what I can see is the different
linux releases with spare patches.  And if I correctly read the
README, I should check what's in for-upstream, which I don't really
know how to checkout with git (I performed a `git clone $TREE`).

>> Should I perform my tests again with the new BIOS?  Or is this bug
>> completely unrelated to the BIOS version?
>
> The bug might even be triggered by the BIOS, but it is a real bug in the
> driver.  But the new BIOS will probably behave much better re. brightness
> functions.

Is it OK to wait to upgrade the BIOS until the bug has been fixed?
Because if the bug won't be present anymore with the new BIOS, we
don't have a way to be sure it's fixed.

Thx, bye,
Gismo / Luca
