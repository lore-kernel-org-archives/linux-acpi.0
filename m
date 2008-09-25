From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Re: Reading EeePC900 battery info causes stalls
Date: Thu, 25 Sep 2008 12:56:10 +0100
Message-ID: <48DB7C5A.6070900@yahoo.com>
References: <gbduo8$nj4$1@ger.gmane.org> <48DB5032.8020604@gmail.com> <48DB5B90.9060607@yahoo.com> <48DB5FEE.4000404@gmail.com> <48DB710A.2060206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ptb-relay03.plus.net ([212.159.14.147]:33225 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775AbYIYL4F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 07:56:05 -0400
In-Reply-To: <48DB710A.2060206@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

Alexey Starikovskiy wrote:
> acpi_ps_parse_aml() is called not so often (~10000usec), so maybe it is 
> a "sweet spot"

The latency is pretty bad with this patch (assuming you did not want it 
applied on top of your previous patch)

Here's the tail end of a full trace:
http://sucs.org/~sits/test/eeepc-debug/20080925/1250/latency_trace_all_tail.gz 
(3.3Mbytes but close 100Mbytes when decompressed)
  latency: 2912285 us, #1000038/5344107, CPU#0 | (M:desktop VP:0, KP:0, 
SP:0 HP:0
)

Here's a complete (but filtered) trace:
http://sucs.org/~sits/test/eeepc-debug/20080925/1250/latency_trace.gz
  latency: 315814 us, #227600/227600, CPU#0 | (M:desktop VP:0, KP:0, 
SP:0 HP:0)

-- 
Sitsofe | http://sucs.org/~sits/
