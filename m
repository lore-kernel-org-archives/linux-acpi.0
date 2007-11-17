From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 01/15] ACPI: thinkpad-acpi: refactor hotkey_get and
	hotkey_set
Date: Sat, 17 Nov 2007 18:15:01 -0200
Message-ID: <20071117201501.GG30919@khazad-dum.debian.net>
References: <1195097822-24738-1-git-send-email-hmh@hmh.eng.br> <1195097822-24738-2-git-send-email-hmh@hmh.eng.br> <200711151314.12935.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45936 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759838AbXKQUPI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Nov 2007 15:15:08 -0500
Content-Disposition: inline
In-Reply-To: <200711151314.12935.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Thu, 15 Nov 2007, Len Brown wrote:
> > This patch:
> 
> a nit to prove that I read this before dumping it into my test branch...

Hey, I never doubted you read all my patchsets :-)

> the "perfect patch" never refers to itself as a patch
> in its check-in comments -- since by the time it is checked
> in, it is sort of self-evident it is a patch:-)

I will remember that one :-)

> but, Henrique, we're waxing about perfection here -- your
> patch hygene is already some of the best on the list.

I will take that as "applied" ;-)  Thanks!

I now have to decide whether I should follow my heart (indent levels with
tabs, everything else with spaces), or just decide that the kernel
hopelessly chained to tabs-as-8-spaces-only land and pipe thinkpad-acpi
entirely through unexpand to get rid of a huge ammount of checkpatch.pl
nagging...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
