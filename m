From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Fri, 27 Mar 2009 16:20:19 -0700
Message-ID: <49CD5F33.7050100@goop.org>
References: <49C484B7.20100@goop.org> <0A882F4D99BBF6449D58E61AAFD7EDD60E5E877B@pdsmsx502.ccr.corp.intel.com> <49C88647.8080404@goop.org> <200903241045.19194.bjorn.helgaas@hp.com> <49C91832.8090300@goop.org> <4F65016F6CB04E49BFFA15D4F7B798D9944E2524@orsmsx506.amr.corp.intel.com> <alpine.LFD.2.00.0903271744340.26419@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:44166 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbZC0XUY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Mar 2009 19:20:24 -0400
In-Reply-To: <alpine.LFD.2.00.0903271744340.26419@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Cihula, Joseph" <joseph.cihula@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wang, Shane" <shane.wang@intel.com>

Len Brown wrote:
>> diff -r 855cb34ca992 drivers/acpi/acpica/hwsleep.c
>> --- a/drivers/acpi/acpica/hwsleep.c     Tue Mar 17 19:53:17 2009 -0400
>> +++ b/drivers/acpi/acpica/hwsleep.c     Tue Mar 24 09:37:22 2009 -0700
>> @@ -45,6 +45,7 @@
>>  #include <acpi/acpi.h>
>>  #include "accommon.h"
>>  #include "actables.h"
>> +#include <asm/tboot.h>
>>
>>  #define _COMPONENT          ACPI_HARDWARE
>>  ACPI_MODULE_NAME("hwsleep")
>> @@ -332,6 +333,39 @@ acpi_status asmlinkage acpi_enter_sleep_
>>
>>         PM1Acontrol |= sleep_enable_reg_info->access_bit_mask;
>>         PM1Bcontrol |= sleep_enable_reg_info->access_bit_mask;
>> +
>> +#ifdef CONFIG_TXT
>> +#define TB_COPY_GAS(tbg, g)                 \
>> +       tbg.space_id = g.space_id;          \
>> +       tbg.bit_width = g.bit_width;        \
>> +       tbg.bit_offset = g.bit_offset;      \
>> +       tbg.access_width = g.access_width;  \
>> +       tbg.address = g.address;
>> +
>> +       if (tboot_in_measured_env()) {
>> +               TB_COPY_GAS(tboot_shared->acpi_sinfo.pm1a_cnt_blk,
>> +                           acpi_gbl_FADT.xpm1a_control_block);
>> +               TB_COPY_GAS(tboot_shared->acpi_sinfo.pm1b_cnt_blk,
>> +                           acpi_gbl_FADT.xpm1b_control_block);
>>     
>
> Who'd a thunk that suddently everybody would want to scribble
> on acpi_enter_sleep_state()?
>
> Note that acpica/hwsleep.c is a file from ACPICA that we share
> with BSD etc.  Yes, we manage local changes in Linux, but we
> try to reduce them to zero over time, else we create a big
> maintenace headache.
>
> perhaps tboot_in_measured_env() could compile in as 0
> for !CONFIG_TXT and you can get rid of the #ifdefs?
>
> Jeremy, I'm not excited about a proposed change to acpixf.h --
> this is the API to ACPICA...
>   
Do you have an issue with the mechanism (using weak function, etc), or 
just the placement of the prototypes in that header?  Would there be a 
better header to put them in?  Or would you prefer some other mechanism?

It certainly seems like Xen and tboot should be able to share the same 
hook, given that they're doing similar things for similar reasons.

(I don't really understand the structure of all the acpi stuff; I'm just 
wading in and making a mess of things until I can close the lid of 
laptop successfully.)

    J
