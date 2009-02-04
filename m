From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] Enable bit 11 in _PDC to advertise hw coord
Date: Wed, 04 Feb 2009 12:06:42 -0800
Message-ID: <1233778002.4286.61.camel@localhost.localdomain>
References: <20090202195717.GA24510@linux-os.sc.intel.com>
	 <20090204085712.GF30821@kernel.dk>
	 <20090204195331.GA905@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31954 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbZBDUFh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Feb 2009 15:05:37 -0500
In-Reply-To: <20090204195331.GA905@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Jens Axboe <jens.axboe@oracle.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Chris Mason <chris.mason@oracle.com>, Greg KH <gregkh@suse.de>, stable kernel <stable@kernel.org>

On Wed, 2009-02-04 at 11:53 -0800, Henrique de Moraes Holschuh wrote:
> On Wed, 04 Feb 2009, Jens Axboe wrote:
> > On Mon, Feb 02 2009, Pallipadi, Venkatesh wrote:
> > > 
> > > Bit 11 in intel PDC definitions is meant for OS capability to handle
> > > hardware coordination of P-states. In Linux we have always supported
> > > hwardware coordination of P-states. Just let the BIOSes know that we
> > > support it, by setting this bit.
> > > 
> > > Some BIOSes use this bit to choose between hardware or software coordination
> > > and without this change below, BIOSes switch to software coordination, which
> > > is not very optimal in terms of power consumption and extra wakeups from idle.
> > 
> > I can confirm that this fixes the excessive reschedule ipi count on an
> > x60 with the ondemand governor. Can we please get this into 2.6.29?
> 
> And, after that, -stable?
> 

Agreed. This should also go to -stable once it gets into mainline.

Thanks,
Venki

