From: "David W. Hankins" <David_Hankins@isc.org>
Subject: 8 cstates but only 4 to use?
Date: Sat, 4 Mar 2006 05:54:23 +0000
Message-ID: <20060304055423.GC26099@isc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from farside.isc.org ([204.152.187.5]:46064 "EHLO farside.isc.org")
	by vger.kernel.org with ESMTP id S1750998AbWCDFyX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 4 Mar 2006 00:54:23 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I looked through the excellent Howto/FAQ provided by Glenn Ariel (thank
you, sir), and he answered a lot of my questions, but was unable to find
the answer to one remaining niggling curiosity.

The 'power' procfile lists a max_cstate of C8, but only lists C1-C4 as
usable states to enter...I notice it is also this way in the example
file output provided in Mr. Ariel's howto, so this must not be uncommon
or new.

But, if 8 states are avaialble, why are only 4 in use?

>From a cursory investigation of the sources, it seems through #def's,
this is a fixed upper limit.

And I figure it can't be just that no one ever thought to #define 5-9,
that would be silly.

Thanks in advance, sorry if this is in a FAQ elsewhere, google is getting
a lot of folks' dmesg output when I try to find answers along these lines.

-- 
David W. Hankins		"If you don't do it right the first time,
Software Engineer			you'll just have to do it again."
Internet Systems Consortium, Inc.		-- Jack T. Hankins
