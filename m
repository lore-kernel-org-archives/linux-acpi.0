From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Look Ma, da kernel is b0rken
Date: Wed, 5 Dec 2012 21:39:44 +0000
Message-ID: <20121205213944.0d27a3f2@pyramind.ukuu.org.uk>
References: <20121205070901.GA12123@rhlx01.hs-esslingen.de>
	<20121205142935.GA12119@liondog.tnic>
	<20121205152756.5afec12c@pyramind.ukuu.org.uk>
	<20121205153121.GA28556@liondog.tnic>
	<20121205154749.2af4ef36@pyramind.ukuu.org.uk>
	<20121206075721.18c0c05aa767b330f47d77eb@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54030 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab2LEVew (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Dec 2012 16:34:52 -0500
In-Reply-To: <20121206075721.18c0c05aa767b330f47d77eb@canb.auug.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Andreas Mohr <andi@lisas.de>, linux-kernel@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, linux-acpi@vger.kernel.org

> While I appreciate your confidence, I don't notice quite a few new
> warnings (because there are so many of them already :-().  Is there some
> reason to not turn this on in our "normal" builds?  Does it produce many
> false positives?  What compiler version is required?

I've not seen any false positives from it yet. Unlike some of the
variable related ones it seems pretty solid.

> I also currently don't carry patches that only ever appear in linux-next
> (well, not intentionally anyway).  I assume it would require a patch to
> the Makefile(s) to turn this on.

Yes. I guess it belongs to the build scripts maintainers ?

Alan
