From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Reading EeePC900 battery info causes stalls
Date: Wed, 24 Sep 2008 18:52:15 +0100
Message-ID: <gbduo8$nj4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:33944 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752293AbYIXSFG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Sep 2008 14:05:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KiYjW-0001oc-6k
	for linux-acpi@vger.kernel.org; Wed, 24 Sep 2008 18:05:02 +0000
Received: from 87.112.30.55.plusnet.ptn-ag1.dyn.plus.net ([87.112.30.55])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 24 Sep 2008 18:05:02 +0000
Received: from sitsofe by 87.112.30.55.plusnet.ptn-ag1.dyn.plus.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 24 Sep 2008 18:05:02 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

(Long thread that was originally posted over here: 
http://tinyurl.com/4akxa5 )

I've found that when running on battery (and the battery is not full) 
the system will stall while battery information is read when using a non 
preemptive kernel.

I can reliably hear the stalls at runlevel 1 by running
speaker-test -b75000
and
watch --interval=1 cat /proc/acpi/battery/BAT0/info
within separate terminals within screen.

I have ftraces of the stalls but the traces become large very quickly. 
To that end I have disabled the tracing of certain functions to allow 
part of the traces to be produced.

By doing counts across multiple runs I would say that the most 
frequently called functions are the following (in most frequently called 
order). The counts are definitely approximate but are reasonable 
relative to each other.

  475325 acpi_os_release_object (acpi_ut_delete_generic_state)
  406895 kmem_cache_free (acpi_os_release_object)
  402838 kmem_cache_alloc (acpi_ut_create_generic_state)
  132968 acpi_ut_update_ref_count (acpi_ut_update_object_reference)
  131041 acpi_ut_pop_generic_state (acpi_ut_update_object_reference)
  131036 acpi_ut_delete_generic_state (acpi_ut_update_object_reference)
  131025 acpi_ut_create_generic_state (acpi_ut_create_update_state)
  131023 acpi_ut_create_update_state_and_push 
(acpi_ut_update_object_reference)
  131020 acpi_ut_create_update_state (acpi_ut_create_update_state_and_push)
  131018 acpi_ut_push_generic_state (acpi_ut_create_update_state_and_push)
   60147 acpi_ns_get_next_node (acpi_ns_delete_namespace_by_owner)
   28974 acpi_ns_get_next_valid_node (acpi_ns_get_next_node)


Here's the command line I used to disable the tracing of certain 
frequent functions:

echo acpi_os_release_object > set_ftrace_notrace && echo kmem_cache_* >> 
set_ftrace_notrace && echo acpi_ut_* >> set_ftrace_notrace

Logs with the filtering on can be seen here (15Mbytes decompressed each):
http://sucs.org/~sits/test/eeepc-debug/20080923/latency_trace.gz
http://sucs.org/~sits/test/eeepc-debug/20080923/trace.txt.gz

I guess the aim is to find a good point to put cond_resched() or 
otherwise solve the latency issue.

-- 
Sitsofe | http://sucs.org/~sits/

