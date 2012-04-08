From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Mon, 9 Apr 2012 01:54:08 +0200
Message-ID: <201204090154.09183.rjw@sisk.pl>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com> <20120405025609.GA5208@localhost.amd.com> <1333594904.11327.27.camel@minggr>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59205 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425Ab2DHXtl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 8 Apr 2012 19:49:41 -0400
In-Reply-To: <1333594904.11327.27.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Aaron Lu <aaron.lu@amd.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>

On Thursday, April 05, 2012, Lin Ming wrote:
> On Thu, 2012-04-05 at 10:56 +0800, Aaron Lu wrote:
> > Hi,
> > 
> > On Thu, Apr 05, 2012 at 10:31:20AM +0800, Lin Ming wrote:
> > > > 
> > > > The only situation where a device can be put into ACPI D3_hot (which is not
> > > > the same as PCI D3_hot, mind you) is when:
> > > > 
> > > > (1) There is _PR3 listing some of the device's power resources as "on".
> > > > (2) The power resources listed by the _PR3 as "off" are turned off and the
> > > >     power resources listed by the _PR3 as "on" are left in the "on" state.
> > > 
> > > I don't understand item (2):
> > > 
> > > If the power resource is listed as "off", which means it's already
> > > turned off. Then why should it be turned off again?
> > 
> > Rafael,
> > I think you misunderstand the meaning of _PR3.
> > The _PR3 will evaluate a list of power resources, not two lists(one "on"
> > list and one "off" list), as illustrated by Ming below.
> > 
> > And for a device to be put to D3 hot, it should:
> > 1 execuate _PS3 first if available
> > 2 turn on all the power resources referenced by _PR3
> 
>   3 turn off all the power resources referenced by previous state

But leave the ones listed by _PR3 in the "on" state, you mean?

Rafael
