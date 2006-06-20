From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [Ubuntu PATCH] acpi: Add IBM R60E laptop to proc-idle blacklist
Date: Tue, 20 Jun 2006 12:56:34 -0700
Message-ID: <449852F2.7000704@oracle.com>
References: <4491BC6B.5000704@oracle.com> <20060619203333.5e897ead.akpm@osdl.org> <20060620093016.GA27807@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:45170 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750827AbWFTTzS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 15:55:18 -0400
In-Reply-To: <20060620093016.GA27807@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Mon, Jun 19, 2006 at 08:33:33PM -0700, Andrew Morton wrote:
>>> +	{ set_max_cstate, "IBM ThinkPad R40e", {
>>> +	  DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
>>> +	  DMI_MATCH(DMI_BIOS_VERSION, "1SET70WW") }, (void*)1},
> 
>> It seems that every R40e in the world is in that table.
>>
>> Can/should we wildcard it?  From my reading of dmi_check_system(), we can use
>> "" in place of the "1SET..." string and it'll dtrt?
> 
> Wouldn't that result in every machine with "IBM" as the BIOS vendor 
> having their maximum c-state limited?

Yes.  DMI_MATCH() specifies substring matching, so _if we knew_
that any BIOS version that began with "1SET4", "1SET5", "1SET6",
or "1SET7" needed C-state limiting, the table could be made a lot
smaller.  But then it may need some exceptions, so just sticking
with full version strings seems reasonable to me.

~Randy

