From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Possible kernel memory leaks
Date: Fri, 02 Jun 2006 10:41:37 +0100
Message-ID: <tnx4pz3x5bi.fsf@arm.com>
References: <44797BEF.70206@gmail.com> <tnxk682wbk8.fsf@arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:63620 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751370AbWFBJlp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Jun 2006 05:41:45 -0400
In-Reply-To: <tnxk682wbk8.fsf@arm.com> (Catalin Marinas's message of "Wed,
 31 May 2006 14:47:35 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Catalin Marinas <catalin.marinas@arm.com> wrote:
> Catalin Marinas <catalin.marinas@gmail.com> wrote:
>> There are some possible kernel memory leaks discovered by kmemleak.
> [...]
>> - acpi_ev_execute_reg_method in drivers/acpi/events/evregion.c - I'm not
>> sure about this but kmemleak reports an orphan pointer on the following
>> allocation path:
>>   c0159372: <kmem_cache_alloc>
>>   c01ffa07: <acpi_os_acquire_object>
>>   c0215b3a: <acpi_ut_allocate_object_desc_dbg>
>>   c02159ce: <acpi_ut_create_internal_object_dbg>
>>   c0203784: <acpi_ev_execute_reg_method>
>>   c0203db4: <acpi_ev_reg_run>
>>   c020ed17: <acpi_ns_walk_namespace>
>>   c0203d6b: <acpi_ev_execute_reg_methods>
>> Is acpi_ut_remove_reference actually removing the params[0/1]?
>
> After a quick check, the reference counts after the
> acpi_ns_evaluate_by_handle() call in acpi_ev_execute_reg_method look
> like this (they were both 1 before this call):
>
>   params[0]->common.reference_count = 1
>   params[1]->common.reference_count = 2
>
> and therefore acpi_ut_remove_reference() doesn't free
> params[1]. Kmemleak, however, cannot find the params[1] value while
> scanning the memory and therefore reports it as a leak.

I'll keep investigating this as I think its a real object
leak. Looking at why params[1] has a different reference_count from
params[0], led me to the following backtrace on the ref count
increment (that's getting really complicated):

  acpi_ut_add_reference
  acpi_ds_method_data_get_value
  acpi_ex_resolve_object_to_value
  acpi_ex_resolve_to_value
  acpi_ex_resolve_operands
    (I have a suspicion that the above function should call
     acpi_ut_remove_reference(obj_desc) on an error return path but it
     actually doesn't and, therefore, the ref count remains
     incremented. In this function, params[0] ref count is 3 but the
     one for params[1] becomes 4)
  acpi_ds_exec_end_op (called via walk_state->ascending_callback)
  acpi_ps_parse_loop
  acpi_ps_parse_aml
  acpi_ps_execute_pass
  acpi_ps_execute_method
  acpi_ns_execute_control_method
  acpi_ns_evaluate_by_handle
  acpi_ev_execute_reg_method

Any suggestions/hints? I hope to get to the bottom of this in the next
few days.

Thanks.

-- 
Catalin
