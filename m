From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: git-acpi breaks resume-from-ram on the Vaio
Date: Mon, 17 Sep 2007 21:40:54 -0700
Message-ID: <20070917214054.bb622420.akpm@linux-foundation.org>
References: <20070917211213.8e0372d6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56973 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754140AbXIREl7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 00:41:59 -0400
In-Reply-To: <20070917211213.8e0372d6.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, 17 Sep 2007 21:12:13 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> 
> It suspends OK, then during resume it gets partway through it, then everything
> just stops.
> 
> Would prefer not to have to bisect this one - I've done enough bisecting this
> week to last a lifetime, and bisecting git-acpi is painful due to build bustage
> at various points (cpuidle).

And git-acpi breaks suspend-to-disk as well.  It gets up to "Suspending console(s)"
and then the cursor stops blinking at it wedges up.
