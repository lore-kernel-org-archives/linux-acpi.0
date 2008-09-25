From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Reading EeePC900 battery info causes stalls
Date: Thu, 25 Sep 2008 12:47:46 +0400
Message-ID: <48DB5032.8020604@gmail.com>
References: <gbduo8$nj4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070705020408040708090009"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:1910 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbYIYIrt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 04:47:49 -0400
Received: by mu-out-0910.google.com with SMTP id g7so259020muf.1
        for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2008 01:47:47 -0700 (PDT)
In-Reply-To: <gbduo8$nj4$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sitsofe Wheeler <sitsofe@yahoo.com>
Cc: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------070705020408040708090009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sitsofe,

I think the least troubling place to add cond_resched() is then ACPICA 
is exiting interpreter.
Please check if the attached patch helps with latencies.

Regards,
Alex.

Sitsofe Wheeler wrote:
> (Long thread that was originally posted over here: 
> http://tinyurl.com/4akxa5 )
>
> I've found that when running on battery (and the battery is not full) 
> the system will stall while battery information is read when using a 
> non preemptive kernel.
>
> I can reliably hear the stalls at runlevel 1 by running
> speaker-test -b75000
> and
> watch --interval=1 cat /proc/acpi/battery/BAT0/info
> within separate terminals within screen.
>
> I have ftraces of the stalls but the traces become large very quickly. 
> To that end I have disabled the tracing of certain functions to allow 
> part of the traces to be produced.
>
> By doing counts across multiple runs I would say that the most 
> frequently called functions are the following (in most frequently 
> called order). The counts are definitely approximate but are 
> reasonable relative to each other.
>
>  475325 acpi_os_release_object (acpi_ut_delete_generic_state)
>  406895 kmem_cache_free (acpi_os_release_object)
>  402838 kmem_cache_alloc (acpi_ut_create_generic_state)
>  132968 acpi_ut_update_ref_count (acpi_ut_update_object_reference)
>  131041 acpi_ut_pop_generic_state (acpi_ut_update_object_reference)
>  131036 acpi_ut_delete_generic_state (acpi_ut_update_object_reference)
>  131025 acpi_ut_create_generic_state (acpi_ut_create_update_state)
>  131023 acpi_ut_create_update_state_and_push 
> (acpi_ut_update_object_reference)
>  131020 acpi_ut_create_update_state 
> (acpi_ut_create_update_state_and_push)
>  131018 acpi_ut_push_generic_state (acpi_ut_create_update_state_and_push)
>   60147 acpi_ns_get_next_node (acpi_ns_delete_namespace_by_owner)
>   28974 acpi_ns_get_next_valid_node (acpi_ns_get_next_node)
>
>
> Here's the command line I used to disable the tracing of certain 
> frequent functions:
>
> echo acpi_os_release_object > set_ftrace_notrace && echo kmem_cache_* 
> >> set_ftrace_notrace && echo acpi_ut_* >> set_ftrace_notrace
>
> Logs with the filtering on can be seen here (15Mbytes decompressed each):
> http://sucs.org/~sits/test/eeepc-debug/20080923/latency_trace.gz
> http://sucs.org/~sits/test/eeepc-debug/20080923/trace.txt.gz
>
> I guess the aim is to find a good point to put cond_resched() or 
> otherwise solve the latency issue.
>


--------------070705020408040708090009
Content-Type: text/x-diff;
 name="add_cond_resched_to_ACPI.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_cond_resched_to_ACPI.patch"

diff --git a/drivers/acpi/executer/exutils.c b/drivers/acpi/executer/exutils.c
index 86c0388..3c715d0 100644
--- a/drivers/acpi/executer/exutils.c
+++ b/drivers/acpi/executer/exutils.c
@@ -143,6 +143,8 @@ void acpi_ex_reacquire_interpreter(void)
  *
  ******************************************************************************/
 
+#include <linux/sched.h>
+
 void acpi_ex_exit_interpreter(void)
 {
 	acpi_status status;
@@ -154,7 +156,7 @@ void acpi_ex_exit_interpreter(void)
 		ACPI_ERROR((AE_INFO,
 			    "Could not release AML Interpreter mutex"));
 	}
-
+	cond_resched();
 	return_VOID;
 }
 

--------------070705020408040708090009--
