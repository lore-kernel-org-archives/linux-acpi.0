From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Look Ma, da kernel is b0rken
Date: Sat, 8 Dec 2012 23:04:19 +0000
Message-ID: <20121208230419.20544263@pyramind.ukuu.org.uk>
References: <20121205070901.GA12123@rhlx01.hs-esslingen.de>
	<20121205142935.GA12119@liondog.tnic>
	<20121205152756.5afec12c@pyramind.ukuu.org.uk>
	<20121205153121.GA28556@liondog.tnic>
	<20121205133853.770451ca.akpm@linux-foundation.org>
	<20121207165218.GA13421@rhlx01.hs-esslingen.de>
	<20121207174405.GF27523@liondog.tnic>
	<20121208073634.GA30690@rhlx01.hs-esslingen.de>
	<20121208105234.GA14569@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:57708 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab2LHW7J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Dec 2012 17:59:09 -0500
In-Reply-To: <20121208105234.GA14569@liondog.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Andreas Mohr <andi@lisas.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>

On Sat, 8 Dec 2012 11:52:34 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Sat, Dec 08, 2012 at 08:36:34AM +0100, Andreas Mohr wrote:
> > And that demand actually applies to both the '@' change (questionable)
> > and the much less disputed (obviously correct) wrong conditional
> > fixup, since both introduce a notable change (either large, or
> > possibly improper) in behaviour.
> 
> Well, I think Alan's fix is obviously correct and doesn't necessarily
> need confirmation. But it will have ~3 months verification time in 3.8,
> just in case.

And to answer the question '@' is used in ISAPnP. Whether it is valid is
a rather different question 8)

Alan
