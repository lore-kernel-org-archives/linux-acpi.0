From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Wed, 9 May 2007 01:22:57 -0700
Message-ID: <20070509012257.ceb825c4.akpm@linux-foundation.org>
References: <20070430102837.748238000@linutronix.de>
	<20070430102852.042964000@linutronix.de>
	<20070505003421.00ec45ba.akpm@linux-foundation.org>
	<20070505115127.GA17815@elte.hu>
	<1178463784.31213.46.camel@localhost.localdomain>
	<20070508225920.258d8d34.akpm@linux-foundation.org>
	<20070509001032.dbb982ca.akpm@linux-foundation.org>
	<1178698697.3042.461.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:56707 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751250AbXEIIXS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 May 2007 04:23:18 -0400
In-Reply-To: <1178698697.3042.461.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Wed, 09 May 2007 10:18:17 +0200 Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 2007-05-09 at 00:10 -0700, Andrew Morton wrote:
> > > > find an updated patch below. It fixes the problem on Ingo's
> > > > VAIO-of-fun-emulator and I got confirmation from several other affected
> > > > users, that the patch series is still solving their problems.
> > > > 
> > > 
> > > The machine is still hanging with this patch applied.
> 
> What did change since yesterday ?

I suspect I just tested the wrong thing yesterday.  Let me recheck just
these patches against 2.6.21.
