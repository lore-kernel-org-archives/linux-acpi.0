From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Look Ma, da kernel is b0rken
Date: Wed, 5 Dec 2012 15:47:49 +0000
Message-ID: <20121205154749.2af4ef36@pyramind.ukuu.org.uk>
References: <20121205070901.GA12123@rhlx01.hs-esslingen.de>
	<20121205142935.GA12119@liondog.tnic>
	<20121205152756.5afec12c@pyramind.ukuu.org.uk>
	<20121205153121.GA28556@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53521 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab2LEPml (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Dec 2012 10:42:41 -0500
In-Reply-To: <20121205153121.GA28556@liondog.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andreas Mohr <andi@lisas.de>, linux-kernel@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, linux-acpi@vger.kernel.org

> Hillarious!
> 
> Andrew, would you please pick up Alan's patch? It clearly fixes an
> ancient bug in the pnpacpi code.

And yes btw we should turn this option on in -next, and get these sort of
things out of the tree for good. More importantly it'll mean anyone
adding another one gets a whine on the spot.

Alan
