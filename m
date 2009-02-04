From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Enable bit 11 in _PDC to advertise hw coord
Date: Wed, 4 Feb 2009 17:53:31 -0200
Message-ID: <20090204195331.GA905@khazad-dum.debian.net>
References: <20090202195717.GA24510@linux-os.sc.intel.com> <20090204085712.GF30821@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:40122 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756688AbZBDTxg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2009 14:53:36 -0500
Content-Disposition: inline
In-Reply-To: <20090204085712.GF30821@kernel.dk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Chris Mason <chris.mason@oracle.com>

On Wed, 04 Feb 2009, Jens Axboe wrote:
> On Mon, Feb 02 2009, Pallipadi, Venkatesh wrote:
> > 
> > Bit 11 in intel PDC definitions is meant for OS capability to handle
> > hardware coordination of P-states. In Linux we have always supported
> > hwardware coordination of P-states. Just let the BIOSes know that we
> > support it, by setting this bit.
> > 
> > Some BIOSes use this bit to choose between hardware or software coordination
> > and without this change below, BIOSes switch to software coordination, which
> > is not very optimal in terms of power consumption and extra wakeups from idle.
> 
> I can confirm that this fixes the excessive reschedule ipi count on an
> x60 with the ondemand governor. Can we please get this into 2.6.29?

And, after that, -stable?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
