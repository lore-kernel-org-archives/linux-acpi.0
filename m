From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] [PATCH]: ACPI: Rename ACPI processor device bus ID
Date: Sat, 23 May 2009 18:01:56 -0300
Message-ID: <20090523210156.GA11172@khazad-dum.debian.net>
References: <1242892973.8523.53.camel@localhost.localdomain> <20090523031811.GB10163@khazad-dum.debian.net> <1243056014.8523.188.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50344 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752399AbZEWVB6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 May 2009 17:01:58 -0400
Content-Disposition: inline
In-Reply-To: <1243056014.8523.188.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Sat, 23 May 2009, yakui_zhao wrote:
> On Sat, 2009-05-23 at 11:18 +0800, Henrique de Moraes Holschuh wrote:
> > On Thu, 21 May 2009, yakui_zhao wrote:
> > > +	sprintf(acpi_device_bid(device), "CPU%X", pr->id);
> > 
> > Is this safe against overflows, i.e. is pr->id something *we* set?  Because
> > if it is in any way read from the ACPI firmware, you have to either use
> > snprintf, or use the format string to limit the %X to a safe lenght...
> Thanks for pointing out this issue.
> Now the array size of acpi_bus_id is 5. And when the cpu number is above
> 256, the overflow will happen. But it is very luck that the following
> three bytes are not used by other variable because of align. And this
> still can work.
> Of course I already sent a patch, in which the array size is changed
> from 5 to 8.
> 
> At the same time if the cpu number is less than or equal to 256, the
> length of format string is safe.

Yeah, but I was really asking if, even with space for 8 chars, isn't there a
risk of pr->id being, say, 0xfffffffe due to some wierdness...

If there is such a risk, you should use snprintf, or a a length limit in the
format...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
