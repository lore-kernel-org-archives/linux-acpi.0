From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: CONFIG_SUSPEND? (was: Re: [GIT PATCH] ACPI patches for
 2.6.23-rc1)
Date: Sat, 28 Jul 2007 11:31:10 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707281130110.3442@woody.linux-foundation.org>
References: <200707251238.50218.lenb@kernel.org>
 <alpine.LFD.0.999.0707280921150.3442@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707280932470.3442@woody.linux-foundation.org>
 <200707282029.03563.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38315 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752378AbXG1Sbp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Jul 2007 14:31:45 -0400
In-Reply-To: <200707282029.03563.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, david@lang.hm, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>



On Sat, 28 Jul 2007, Rafael J. Wysocki wrote:
> 
> OK, I'll prepare a patch to introduce CONFIG_SUSPEND, but that will require
> quite a bit of (compilation) testing on different architectures.

Sure. I'm not too worried, the fallout should be of the trivial kind. 

Also, mind basing it on the (independent) cleanups that Adrian already 
sent out. This is all intertwined..

		Linus
