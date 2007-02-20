From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: ec locking issue
Date: Tue, 20 Feb 2007 21:24:36 +0300
Message-ID: <45DB3CE4.8090001@linux.intel.com>
References: <20070215192616.GA31595@isilmar.linta.de> <45D4BF92.5050401@linux.intel.com> <200702161254.55430.lenb@kernel.org> <20070219134431.GG9283@isilmar.linta.de> <20070219214502.GA19762@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:7612 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750986AbXBTSYz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Feb 2007 13:24:55 -0500
In-Reply-To: <20070219214502.GA19762@isilmar.linta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Dominik Brodowski wrote:
> Hi,
>
> On Mon, Feb 19, 2007 at 08:44:31AM -0500, Dominik Brodowski wrote:
>   
>> On Fri, Feb 16, 2007 at 12:54:55PM -0500, Len Brown wrote:
>>     
>>>>> acpi_ec_transaction
>>>>> acpi_ec_read
>>>>> acpi_ec_space_handler
>>>>> acpi_ev_address_space_dispatch
>>>>> acpi_ex_access_region
>>>>> acpi_ex_field_datum_
>>>>> acpi_ex_extract_from_field
>>>>> ...
>>>>> acpi_ex_ns_evaluate
>>>>> acpi_ev_execute_reg_method
>>>>> acpi_ev_reg_run
>>>>> acpi_ns_walk_namespace
>>>>> acpi_ev_execute_reg_methods
>>>>> acpi_install_address_space_handler
>>>>> acpi_ec_start
>>>>> acpi_start_single_object
>>>>> acpi_device_probe
>>>>> really_probe
>>>>> ...
>>>>> bus_add_driver
>>>>> ...
>>>>> acpi_ec_init
>>>>>           
>>> Alexey,
>>> Thanks for the fix -- it is applied.
>>>
>>> Dominik,
>>> Did this fix help, or is the problem elsehwere?
>>>       
>> Unfortunately, this doesn't solve the issue for me -- now I get a panic with
>> EIP at __list_add+0x2d/0x60, with the call trace being
>>
>> 	...
>> 	die
>> 	do_page_fault
>> 	error_code
>> 	__mutex_lock_slowpath
>> 	mutex_lock
>> 	acpi_ec_transaction
>>
>> and then the same as above... Will try it out with lockdep disabled.
>>     
>
> No, doesn't seem to be lockdep-related; same issue continues. "acpi=off"
> fixes the issue, though, of course...
>
> Thanks,
> 	Dominik
>   

Dominik,
Could you send your acpidump and full dmesg please?

Thanks,
    Alex.
