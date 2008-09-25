From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Reading EeePC900 battery info causes stalls
Date: Thu, 25 Sep 2008 15:07:54 +0400
Message-ID: <48DB710A.2060206@gmail.com>
References: <gbduo8$nj4$1@ger.gmane.org> <48DB5032.8020604@gmail.com> <48DB5B90.9060607@yahoo.com> <48DB5FEE.4000404@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010801000406070401080700"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:10951 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbYIYLH4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 07:07:56 -0400
Received: by mu-out-0910.google.com with SMTP id g7so304041muf.1
        for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2008 04:07:55 -0700 (PDT)
In-Reply-To: <48DB5FEE.4000404@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sitsofe Wheeler <sitsofe@yahoo.com>
Cc: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010801000406070401080700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alexey Starikovskiy wrote:
> Sitsofe Wheeler wrote:
>> Hi Alexey,
>>
>> Alexey Starikovskiy wrote:
>>> I think the least troubling place to add cond_resched() is then 
>>> ACPICA is exiting interpreter.
>>> Please check if the attached patch helps with latencies.
>>
>> There was no real change (latency was still bad). If you look at the 
>> trace (before your patch) on 
>> http://sucs.org/~sits/test/eeepc-debug/20080923/latency_trace.gz 
>> (700kbyte compressed, 15Mbytes uncompressed) you can see that 
>> acpi_ex_exit_interpreter is only called once near the end of the trace:
>>
>>      cat-5901    0.N.. 270496us : acpi_ex_exit_interpreter 
>> (acpi_ev_address_space_dispatch)
>>
>> By then the time had already been racked up...
>>
> Ok, let's add it to the end of acpi_ps_complete_op() then... They 
> appear every 100usec or so...
>
acpi_ps_parse_aml() is called not so often (~10000usec), so maybe it is 
a "sweet spot"



--------------010801000406070401080700
Content-Type: text/x-diff;
 name="add_cond_resched_to_ACPI.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_cond_resched_to_ACPI.patch"

diff --git a/drivers/acpi/parser/psparse.c b/drivers/acpi/parser/psparse.c
index 15e1702..ceab67c 100644
--- a/drivers/acpi/parser/psparse.c
+++ b/drivers/acpi/parser/psparse.c
@@ -439,6 +439,8 @@ acpi_ps_next_parse_state(struct acpi_walk_state *walk_state,
  *
  ******************************************************************************/
 
+#include <linux/sched.h>
+
 acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 {
 	acpi_status status;
@@ -688,5 +690,6 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 	acpi_ut_delete_generic_state(ACPI_CAST_PTR
 				     (union acpi_generic_state, thread));
 	acpi_gbl_current_walk_list = prev_walk_list;
+	cond_resched();
 	return_ACPI_STATUS(status);
 }

--------------010801000406070401080700--
