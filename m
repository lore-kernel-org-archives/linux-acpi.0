From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] -mm: acpi idle __read_mostly and de-init static var
Date: Wed, 19 Apr 2006 12:01:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0604191144380.32445@scrub.home>
References: <20060418190045.GA25749@rhlx01.fht-esslingen.de>
 <20060418233041.272264b6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:30100 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750872AbWDSKCB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Apr 2006 06:02:01 -0400
In-Reply-To: <20060418233041.272264b6.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, linux-acpi@vger.kernel.org, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Apr 2006, Andrew Morton wrote:

> Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> >
> > - don't remove static init value of nocst and bm_history
> >    since __read_mostly may be special
> >    (see e.g. http://www.ussg.iu.edu/hypermail/linux/kernel/0010.0/0771.html)
> > 
> 
> hm, that was six years ago.  I'm vaguely surprised that the initialisation
> was needed even then.  It isn't needed now.  Or if it is, we need to find
> out why and fix it.

I guess 2.7.2 was still a valid compiler then. :)
All later versions don't behave like this, although it's still documented 
like this: http://gcc.gnu.org/onlinedocs/gcc/Variable-Attributes.html

bye, Roman
