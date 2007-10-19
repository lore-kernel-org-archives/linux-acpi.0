From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Oops removing thinkpad_acpi and video on git:linux-acpi-2.6
Date: Fri, 19 Oct 2007 11:02:45 -0200
Message-ID: <20071019130245.GB20188@khazad-dum.debian.net>
References: <87lka1ffwc.fsf@gismo.pca.it> <20071018012106.GA24821@khazad-dum.debian.net> <87tzoo2q3x.fsf@gismo.pca.it> <20071018230334.GD4483@khazad-dum.debian.net> <871wbr2u1r.fsf@gismo.pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34749 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752952AbXJSNCt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Oct 2007 09:02:49 -0400
Content-Disposition: inline
In-Reply-To: <871wbr2u1r.fsf@gismo.pca.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Capello <luca@pca.it>
Cc: ML Linux-ACPI <linux-acpi@vger.kernel.org>

On Fri, 19 Oct 2007, Luca Capello wrote:
> I tested 2.6.23.1 + 0.18-20071013, oops still there.  Should I test it
> with the latest linux-acpi-2.6 git tree, also?  I don't think it's
> necessary, but I can do it in case (but please read below).

It is probably not liking something in 2.6.23.  I will test that and get
back to you as soon as I have an answer (might take a few days).

> Sorry, I'm quite lost with the git tree: in release/ there's nothing
> about the latest linux-acpi-2.6 tree, what I can see is the different

That tree is just for thinkpad-acpi, it usually has nothing related to other
linux-acpi changes, unless they actually are required for something
thinkpad-acpi needs to do.

> Is it OK to wait to upgrade the BIOS until the bug has been fixed?
> Because if the bug won't be present anymore with the new BIOS, we
> don't have a way to be sure it's fixed.

Sure, it is OK to wait to upgrade the BIOS.  As I said, I am certain there
is a driver bug somewhere, regardless of any possible BIOS problems.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
