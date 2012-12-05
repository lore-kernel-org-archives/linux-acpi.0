From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Look Ma, da kernel is b0rken
Date: Wed, 5 Dec 2012 15:27:56 +0000
Message-ID: <20121205152756.5afec12c@pyramind.ukuu.org.uk>
References: <20121205070901.GA12123@rhlx01.hs-esslingen.de>
	<20121205142935.GA12119@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53495 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab2LEPWy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Dec 2012 10:22:54 -0500
In-Reply-To: <20121205142935.GA12119@liondog.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Andreas Mohr <andi@lisas.de>, linux-kernel@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, linux-acpi@vger.kernel.org

On Wed, 5 Dec 2012 15:29:35 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Dec 05, 2012 at 08:09:01AM +0100, Andreas Mohr wrote:
> > Hi,
> > 
> > drivers/pnp/pnpacpi/core.c: In function 'ispnpidacpi':
> > drivers/pnp/pnpacpi/core.c:65:2: warning: logical 'or' of collectively
> > exhaustive tests is always true [-Wlogical-op]
> > drivers/pnp/pnpacpi/core.c:66:2: warning: logical 'or' of collectively
> > exhaustive tests is always true [-Wlogical-op]
> > drivers/pnp/pnpacpi/core.c:67:2: warning: logical 'or' of collectively
> > exhaustive tests is always true [-Wlogical-op]
> > 
> > 
> > That's already the second less enticing -Wlogical-op issue
> > which was discovered by accident during less than two days

No it's not. It's been reported in bugzilla. I sent patches ages ago.
They were ignored. Coverity has had it tagged for years (and a ton more
of them you've not noticed yet)

http://article.gmane.org/gmane.linux.acpi.devel/56753/match=test_alpha

This isn't discovered, this is in the "If you stick your fingers in your
ears and hum you can't hear the screaming" category.

Alan
