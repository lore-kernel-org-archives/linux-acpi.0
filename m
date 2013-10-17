From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/9] bitops: Introduce a more generic BITMASK macro
Date: Thu, 17 Oct 2013 01:55:12 -0700
Message-ID: <1382000112.22110.103.camel@joe-AO722>
References: <1381935366-11731-1-git-send-email-gong.chen@linux.intel.com>
	 <1381935366-11731-4-git-send-email-gong.chen@linux.intel.com>
	 <1381978749.22110.76.camel@joe-AO722>
	 <20131017063059.GB14946@gchen.bj.intel.com>
	 <1381993136.22110.95.camel@joe-AO722>
	 <20131017073824.GC14946@gchen.bj.intel.com>
	 <1381998750.22110.101.camel@joe-AO722> <20131017084014.GD5036@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:40103 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751099Ab3JQIzQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Oct 2013 04:55:16 -0400
In-Reply-To: <20131017084014.GD5036@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Chen Gong <gong.chen@linux.intel.com>, tony.luck@intel.com, naveen.n.rao@linux.vnet.ibm.com, m.chehab@samsung.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Winischhofer <thomas@winischhofer.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Thu, 2013-10-17 at 10:40 +0200, Borislav Petkov wrote:
> On Thu, Oct 17, 2013 at 01:32:30AM -0700, Joe Perches wrote:
> > On Thu, 2013-10-17 at 03:38 -0400, Chen Gong wrote:
> > > the point is we can use GENMASK like GENMASK(end_bit, start_bit) but
> > > we don't know the value of end_bit/start_bit at compile-time.
> > 
> > True.
> > 
> > The BUILD_BUG_ON idea is just to avoid people using
> > 	GENMASK(1, 2)
> 
> They'll notice the 0 pretty quickly when they test their code.
> 
> Let's add those checks only when it is really necessary and people have
> actually made that mistake repeatedly.

It's cost free to add the BUILD_BUG_ON
and perhaps you underestimate the runtime
bug checking effort,

