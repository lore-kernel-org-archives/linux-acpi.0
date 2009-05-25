From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [RFC] [PATCH]: ACPI: Rename ACPI processor device bus ID
Date: Mon, 25 May 2009 08:59:40 +0800
Message-ID: <1243213180.8523.200.camel@localhost.localdomain>
References: <1242892973.8523.53.camel@localhost.localdomain>
	 <20090523031811.GB10163@khazad-dum.debian.net>
	 <1243056014.8523.188.camel@localhost.localdomain>
	 <20090523210156.GA11172@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50448 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbZEYA6V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 May 2009 20:58:21 -0400
In-Reply-To: <20090523210156.GA11172@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Sun, 2009-05-24 at 05:01 +0800, Henrique de Moraes Holschuh wrote:
> On Sat, 23 May 2009, yakui_zhao wrote:
> > On Sat, 2009-05-23 at 11:18 +0800, Henrique de Moraes Holschuh wrote:
> > > On Thu, 21 May 2009, yakui_zhao wrote:
> > > > +	sprintf(acpi_device_bid(device), "CPU%X", pr->id);
> > > 
> > > Is this safe against overflows, i.e. is pr->id something *we* set?  Because
> > > if it is in any way read from the ACPI firmware, you have to either use
> > > snprintf, or use the format string to limit the %X to a safe lenght...
> > Thanks for pointing out this issue.
> > Now the array size of acpi_bus_id is 5. And when the cpu number is above
> > 256, the overflow will happen. But it is very luck that the following
> > three bytes are not used by other variable because of align. And this
> > still can work.
> > Of course I already sent a patch, in which the array size is changed
> > from 5 to 8.
> > 
> > At the same time if the cpu number is less than or equal to 256, the
> > length of format string is safe.
> 
> Yeah, but I was really asking if, even with space for 8 chars, isn't there a
> risk of pr->id being, say, 0xfffffffe due to some wierdness...

If the pr->id is set to 0xfffffffe, it is a risk.
But in fact OS will get the correct cpu id by using the function of
get_cpu_id. The result value is -1 or other correct cpu id.

So it is unnecessary to worry that the incorrect value is assigned to
pr->id.

Of course it will be OK to use the snprintf instead of sprintf.
thanks.
> If there is such a risk, you should use snprintf, or a a length limit in the
> format...

> 

