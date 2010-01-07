From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/5] ACPI, APEI, EINJ support
Date: Thu, 7 Jan 2010 08:12:29 +0100
Message-ID: <20100107071229.GC1689@ucw.cz>
References: <1261980744-4450-1-git-send-email-ying.huang@intel.com> <1261980744-4450-2-git-send-email-ying.huang@intel.com> <1261980744-4450-3-git-send-email-ying.huang@intel.com> <1261980744-4450-4-git-send-email-ying.huang@intel.com> <1261980744-4450-5-git-send-email-ying.huang@intel.com> <20100106070807.GA1494@ucw.cz> <1262762186.17852.7.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55217 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab0AGHMe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2010 02:12:34 -0500
Content-Disposition: inline
In-Reply-To: <1262762186.17852.7.camel@yhuang-dev.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed 2010-01-06 15:16:26, Huang Ying wrote:
> Hi, Pavel,
> 
> On Wed, 2010-01-06 at 15:08 +0800, Pavel Machek wrote:
> > On Mon 2009-12-28 14:12:23, Huang Ying wrote:
> > > EINJ provides a hardware error injection mechanism, this is useful for
> > > debugging and testing of other APEI and RAS features.
> > > 
> > > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > > ---
> > >  drivers/acpi/apei/Kconfig  |    7 +
> > >  drivers/acpi/apei/Makefile |    1 +
> > >  drivers/acpi/apei/einj.c   |  471 ++++++++++++++++++++++++++++++++++++++++++++
> > 
> > 
> > Can we get more meaningfull name? err_inject.c?
> 
> einj is the abbreviation used in ACPI specification. I think following
> specification can avoid some confusion. Do you think so?

The spec is way too ugly to follow here.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
