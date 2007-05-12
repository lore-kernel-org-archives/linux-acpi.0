From: Matt Mackall <mpm@selenic.com>
Subject: Re: Re: [announce] Intel announces the PowerTOP utility for Linux
Date: Fri, 11 May 2007 21:39:05 -0500
Message-ID: <20070512023904.GY11115@waste.org>
References: <4644F726.1050806@linux.intel.com> <20070512001718.GY11166@waste.org> <20070512014052.GA4082@co.sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from waste.org ([66.93.16.53]:49291 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753686AbXELCjN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2007 22:39:13 -0400
Content-Disposition: inline
In-Reply-To: <20070512014052.GA4082@co.sapo.pt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sat, May 12, 2007 at 02:40:52AM +0100, Jose Celestino wrote:
> Words by Matt Mackall [Fri, May 11, 2007 at 07:17:19PM -0500]:
> > On Fri, May 11, 2007 at 04:07:18PM -0700, Arjan van de Ven wrote:
> > > 
> > > What's eating the battery life of my laptop? Why isn't it many more 
> > > hours? Which software component causes the most power to be burned? 
> > > These are important questions without a good answer... until now.
> > 
> > I get:
> > 
> > No detailed statistics available; please enable the CONFIG_TIMER_STATS
> > kernel option
> > 
> 
> Must run as root (rw to /proc/timer_stats is needed).

That file doesn't exist, despite CONFIG_TIMER_STATS being in
/proc/config.gz.

-- 
Mathematics is the supreme nostalgia of our time.
