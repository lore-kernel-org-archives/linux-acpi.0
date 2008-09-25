From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Re: Reading EeePC900 battery info causes stalls
Date: Thu, 25 Sep 2008 12:17:28 +0100
Message-ID: <48DB7348.20502@yahoo.com>
References: <gbduo8$nj4$1@ger.gmane.org> <48DB5032.8020604@gmail.com> <48DB5B90.9060607@yahoo.com> <48DB5FEE.4000404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fhw-relay07.plus.net ([212.159.14.148]:43218 "EHLO
	fhw-relay07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbYIYLRW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 07:17:22 -0400
In-Reply-To: <48DB5FEE.4000404@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

Alexey Starikovskiy wrote:
> Ok, let's add it to the end of acpi_ps_complete_op() then... They appear 
> every 100usec or so...

(I know you've posted something later but I've only just got results for 
this test - talk about fast!)

Massively better. I can still provoke small stalls that are now only 
noticeable when playing games.

wakeup latency trace v1.1.5 on 2.6.27-rc7-tipskw-00756-g6522eab-dirty
--------------------------------------------------------------------
  latency: 13900 us, #25557/25557, CPU#0 | (M:desktop VP:0, KP:0, SP:0 HP:0)
     -----------------
     | task: a7xpg-5739 (uid:1000 nice:0 policy:2 rt_prio:5)
     -----------------

The trace can be seen on 
http://sucs.org/~sits/test/eeepc-debug/20080925/acpi/latency_trace.gz .

Here are the top called functions from this much shorter trace:
    2526 acpi_ut_update_ref_count (acpi_ut_update_object_reference)
    2525 kmem_cache_free (acpi_os_release_object)
    2521 acpi_os_release_object (acpi_ut_delete_generic_state)
    2520 acpi_ut_delete_generic_state (acpi_ut_update_object_reference)
    2519 acpi_ut_pop_generic_state (acpi_ut_update_object_reference)
    2514 acpi_ut_create_generic_state (acpi_ut_create_update_state)
    2513 kmem_cache_alloc (acpi_ut_create_generic_state)
    2513 acpi_ut_push_generic_state (acpi_ut_create_update_state_and_push)
    2512 acpi_ut_create_update_state_and_push 
(acpi_ut_update_object_reference)
    2511 acpi_ut_create_update_state (acpi_ut_create_update_state_and_push)
     231 __slab_free (kmem_cache_free)

OK time to investigate your next mail...

-- 
Sitsofe | http://sucs.org/~sits/
