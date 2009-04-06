From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ACPI: Adjust Kelvin offset to match local
 implementation
Date: Mon, 6 Apr 2009 15:58:22 +0200
Message-ID: <20090406155822.4fb57037@hyperion.delvare>
References: <20090301140318.5cf56287@hyperion.delvare>
	<1236069854.32297.232.camel@rzhang-dt>
	<20090327105520.6fa31a13@hyperion.delvare>
	<alpine.LFD.2.00.0903271150510.26419@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:10546 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbZDFN6i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Apr 2009 09:58:38 -0400
In-Reply-To: <alpine.LFD.2.00.0903271150510.26419@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Len,

Sorry for the late reply.

On Fri, 27 Mar 2009 11:52:04 -0400 (EDT), Len Brown wrote:
> 
> On Fri, 27 Mar 2009, Jean Delvare wrote:
> 
> > Hi Rui,
> > 
> > On Tue, 03 Mar 2009 16:44:14 +0800, Zhang Rui wrote:
> > > On Sun, 2009-03-01 at 21:03 +0800, Jean Delvare wrote:
> > > > The exact offset between Kelvin and degree Celsius is 273.15. However
> > > > ACPI handles temperature values with a single decimal place. As a
> > > > consequence, some implementations use an offset of 273.1 and others
> > > > use an offset of 273.2. Try to find out which one is being used, to
> > > > present the most accurate and visually appealing number.
> > > > 
> > > > Tested on a Sony Vaio PGC-GR214EP (which uses 273.1) and a Lenovo
> > > > Thinkpad T60p (which uses 273.2).
> > > Sounds reasonable.
> > > 
> > > Acked-by: Zhang Rui <rui.zhang@intel.com>
> > 
> > Thanks. Is this patch queued for 2.6.30 somewhere?
> 
> it was, but I had a conflict between this an another and so I dropped this 
> one until I could look at it - which I havn't yet.  If you'd like to do
> it for me, rebase on top of the acpi test branch.

OK, I have rebased my patch against 2.6.29-git13 (which I seem to
understand contains the latest ACPI code), tested it and it looks OK.
I'll post the updated patch in a minute.

Thanks,
-- 
Jean Delvare
