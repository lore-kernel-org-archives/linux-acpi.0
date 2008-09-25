From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Re: Reading EeePC900 battery info causes stalls
Date: Thu, 25 Sep 2008 10:36:16 +0100
Message-ID: <48DB5B90.9060607@yahoo.com>
References: <gbduo8$nj4$1@ger.gmane.org> <48DB5032.8020604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pih-relay04.plus.net ([212.159.14.17]:36508 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbYIYJgL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 05:36:11 -0400
In-Reply-To: <48DB5032.8020604@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi Alexey,

Alexey Starikovskiy wrote:
> I think the least troubling place to add cond_resched() is then ACPICA 
> is exiting interpreter.
> Please check if the attached patch helps with latencies.

There was no real change (latency was still bad). If you look at the 
trace (before your patch) on 
http://sucs.org/~sits/test/eeepc-debug/20080923/latency_trace.gz 
(700kbyte compressed, 15Mbytes uncompressed) you can see that 
acpi_ex_exit_interpreter is only called once near the end of the trace:

      cat-5901    0.N.. 270496us : acpi_ex_exit_interpreter 
(acpi_ev_address_space_dispatch)

By then the time had already been racked up...

-- 
Sitsofe | http://sucs.org/~sits/
