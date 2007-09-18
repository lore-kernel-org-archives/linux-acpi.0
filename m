From: Len Brown <lenb@kernel.org>
Subject: Re: git-acpi breaks resume-from-ram on the Vaio
Date: Tue, 18 Sep 2007 11:21:41 -0400
Message-ID: <200709181121.41368.lenb@kernel.org>
References: <20070917211213.8e0372d6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55266 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755822AbXIRPV7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 11:21:59 -0400
In-Reply-To: <20070917211213.8e0372d6.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

On Tuesday 18 September 2007 00:12, Andrew Morton wrote:
> 
> It suspends OK, then during resume it gets partway through it, then everything
> just stops.

Hmmm, i thought your vaio resume problems were in linus' tree --
did that go away -- or maybe it was in -mm and not in linus' tree all along?

> Would prefer not to have to bisect this one - I've done enough bisecting this
> week to last a lifetime, and bisecting git-acpi is painful due to build bustage
> at various points (cpuidle).

bisecting the acpi git three should work well, because it uses topic branches.
This includes cpuidle.  ie.  unless the breakage is within the cpuidle branch itself,
the whole cpuidle topic can be removed by skipping the single merge commit that
pulls it in.

If you like, I can build the topic branch heads and export plain patches
for you to try.  Also, I'll probably be re-writing the test branch history
later today -- so let me know if you dig into it and i'll delay that until
you're done.

thanks,
-Len
