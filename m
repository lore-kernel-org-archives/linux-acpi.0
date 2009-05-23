From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [RFC] [PATCH]: ACPI: Rename ACPI processor device bus ID
Date: Sat, 23 May 2009 13:20:14 +0800
Message-ID: <1243056014.8523.188.camel@localhost.localdomain>
References: <1242892973.8523.53.camel@localhost.localdomain>
	 <20090523031811.GB10163@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48144 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbZEWFSz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 May 2009 01:18:55 -0400
In-Reply-To: <20090523031811.GB10163@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Sat, 2009-05-23 at 11:18 +0800, Henrique de Moraes Holschuh wrote:
> On Thu, 21 May 2009, yakui_zhao wrote:
> > +	sprintf(acpi_device_bid(device), "CPU%X", pr->id);
> 
> Is this safe against overflows, i.e. is pr->id something *we* set?  Because
> if it is in any way read from the ACPI firmware, you have to either use
> snprintf, or use the format string to limit the %X to a safe lenght...
Thanks for pointing out this issue.
Now the array size of acpi_bus_id is 5. And when the cpu number is above
256, the overflow will happen. But it is very luck that the following
three bytes are not used by other variable because of align. And this
still can work.
Of course I already sent a patch, in which the array size is changed
from 5 to 8.

At the same time if the cpu number is less than or equal to 256, the
length of format string is safe.

thanks.

Best regards.
	Yakui 
> 

