From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Wed, 09 May 2007 10:59:43 +0200
Message-ID: <1178701183.3042.469.camel@localhost.localdomain>
References: <20070430102837.748238000@linutronix.de>
	 <20070430102852.042964000@linutronix.de>
	 <20070505003421.00ec45ba.akpm@linux-foundation.org>
	 <20070505115127.GA17815@elte.hu>
	 <1178463784.31213.46.camel@localhost.localdomain>
	 <20070508225920.258d8d34.akpm@linux-foundation.org>
	 <20070509001032.dbb982ca.akpm@linux-foundation.org>
	 <1178698697.3042.461.camel@localhost.localdomain>
	 <20070509012257.ceb825c4.akpm@linux-foundation.org>
	 <20070509013119.dbea7233.akpm@linux-foundation.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:51184 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754198AbXEII4x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 04:56:53 -0400
In-Reply-To: <20070509013119.dbea7233.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Wed, 2007-05-09 at 01:31 -0700, Andrew Morton wrote:
> > I suspect I just tested the wrong thing yesterday.  Let me recheck just
> > these patches against 2.6.21.
> 
> yup, same hang with just these three:
> 
> origin
> clocksource-fix-resume-logic
> clockevents-fix-resume-logic-updated-version

I have no idea, how this affects acpi_evaluate_object()

	tglx



