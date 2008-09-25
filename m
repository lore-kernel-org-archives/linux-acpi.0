From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Reading EeePC900 battery info causes stalls
Date: Thu, 25 Sep 2008 13:54:54 +0400
Message-ID: <48DB5FEE.4000404@gmail.com>
References: <gbduo8$nj4$1@ger.gmane.org> <48DB5032.8020604@gmail.com> <48DB5B90.9060607@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080402040001010507030808"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:42150 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbYIYJy4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 05:54:56 -0400
Received: by fk-out-0910.google.com with SMTP id 18so338651fkq.5
        for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2008 02:54:54 -0700 (PDT)
In-Reply-To: <48DB5B90.9060607@yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sitsofe Wheeler <sitsofe@yahoo.com>
Cc: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080402040001010507030808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sitsofe Wheeler wrote:
> Hi Alexey,
>
> Alexey Starikovskiy wrote:
>> I think the least troubling place to add cond_resched() is then 
>> ACPICA is exiting interpreter.
>> Please check if the attached patch helps with latencies.
>
> There was no real change (latency was still bad). If you look at the 
> trace (before your patch) on 
> http://sucs.org/~sits/test/eeepc-debug/20080923/latency_trace.gz 
> (700kbyte compressed, 15Mbytes uncompressed) you can see that 
> acpi_ex_exit_interpreter is only called once near the end of the trace:
>
>      cat-5901    0.N.. 270496us : acpi_ex_exit_interpreter 
> (acpi_ev_address_space_dispatch)
>
> By then the time had already been racked up...
>
Ok, let's add it to the end of acpi_ps_complete_op() then... They appear 
every 100usec or so...


--------------080402040001010507030808
Content-Type: text/x-diff;
 name="add_cond_resched_to_ACPI.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_cond_resched_to_ACPI.patch"

diff --git a/drivers/acpi/parser/psloop.c b/drivers/acpi/parser/psloop.c
index c06238e..33cd061 100644
--- a/drivers/acpi/parser/psloop.c
+++ b/drivers/acpi/parser/psloop.c
@@ -564,6 +564,8 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
  *
  ******************************************************************************/
 
+#include <linux/sched.h>
+
 static acpi_status
 acpi_ps_complete_op(struct acpi_walk_state *walk_state,
 		    union acpi_parse_object **op, acpi_status status)
@@ -719,6 +721,8 @@ acpi_ps_complete_op(struct acpi_walk_state *walk_state,
 		*op = NULL;
 	}
 
+	cond_resched();
+
 	return_ACPI_STATUS(AE_OK);
 }
 

--------------080402040001010507030808--
