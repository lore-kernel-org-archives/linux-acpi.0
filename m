From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [2.6 patch] let SUSPEND select HOTPLUG_CPU
Date: Sat, 28 Jul 2007 10:42:45 +0200
Message-ID: <46AB0185.3020405@s5r6.in-berlin.de>
References: <200707251238.50218.lenb@kernel.org> <200707262117.26353.rjw@sisk.pl> <alpine.LFD.0.999.0707261255380.3442@woody.linux-foundation.org> <200707262248.09187.rjw@sisk.pl> <alpine.LFD.0.999.0707261351430.3442@woody.linux-foundation.org> <20070727222503.GB15129@stusta.de> <46AA7609.1040900@s5r6.in-berlin.de> <20070727230307.GC15129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:51411 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbXG1In1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jul 2007 04:43:27 -0400
In-Reply-To: <20070727230307.GC15129@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, david@lang.hm, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

Adrian Bunk wrote:
> On Sat, Jul 28, 2007 at 12:47:37AM +0200, Stefan Richter wrote:
>> Yes, that's the price to pay if you want to select something that in
>> turn depends on a number of other things.
> 
> Yes, but a good user interface is worth it.

That's right.  But a hypothetical other way would be to leave Kconfigs
minimal ands put the necessary features into scripts/kconfig.
-- 
Stefan -ENOPATCH Richter
-=====-=-=== -=== ===--
http://arcgraph.de/sr/
