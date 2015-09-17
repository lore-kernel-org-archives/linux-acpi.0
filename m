From: Bastien Nocera <hadess@hadess.net>
Subject: Re: New Surface 3 (atom x7) having problems with ACPI regions
Date: Thu, 17 Sep 2015 14:41:54 +0200
Message-ID: <1442493714.15118.8.camel@hadess.net>
References: <CAN+gG=FMjShOWf6LXwDd5Fps-ME4cDCtN2h6bTZRvOifhAMRtQ@mail.gmail.com>
	 <55F0FD2A.7050900@intel.com> <20150910073556.GA6863@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:38766 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbbIQMsl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Sep 2015 08:48:41 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 6547B486560
	for <linux-acpi@vger.kernel.org>; Thu, 17 Sep 2015 14:42:00 +0200 (CEST)
In-Reply-To: <20150910073556.GA6863@aaronlu.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yu Chen <yu.c.chen@intel.com>

On Thu, 2015-09-10 at 15:35 +0800, Aaron Lu wrote:
> On Thu, Sep 10, 2015 at 11:46:50AM +0800, Aaron Lu wrote:
> > I'm not so sure of the below part:
> > "
> > The failure of executing the _STA control method will cause the
> > device
> > node not having the acpi_device structure created and then in the
> > SPI
> > ACPI enumerate function acpi_spi_add_device, it will not be created
> > and
> > used.
> > "
> 
> With the above said, I wonder if the following patch which ignores
> the
> error return of the _STA and set status to 0 makes any difference?

For the lurkers on the list, the discussion is happening in bugzilla
now, and the aforementioned patch didn't make a difference:
https://bugzilla.kernel.org/show_bug.cgi?id=104291

Cheers
