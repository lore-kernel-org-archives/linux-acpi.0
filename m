From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Fri, 26 Sep 2008 06:42:19 +0100
Message-ID: <48DC763B.7080203@yahoo.com>
References: <20080925170030.15311.27823.stgit@thinkpad>	 <48DBCFE0.8050905@yahoo.com> <1222391199.4023.125.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pih-relay08.plus.net ([212.159.14.20]:39078 "EHLO
	pih-relay08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbYIZFmQ (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 01:42:16 -0400
In-Reply-To: <1222391199.4023.125.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Zhao Yakui wrote:
>     I think that the problem on the asus-EEEPC can't be resolved really
> by the Alexey's patch. IMO it is only lucky.

How lucky? It really does go from excruciatingly slow to quite fast on 
that laptop. What will happen should my luck fail? What are the odds of 
my luck failing?

>    In fact the main problem on Asus-EEEPC is related with the broken EC.
> Before an EC notification event is processed, another EC notification
> event arrives again.
>    If EC driver check whether the SCI_EVT bit is set after processing
> one EC notification event, the problem will be resolved. 
>     http://bugzilla.kernel.org/show_bug.cgi?id=11089
>     Alan Jenkins already sent a patch about how to fix the issue on the
> Asus-EEEPC.

I'll cc Alan and see what he makes of this patch.

>    But if the above patch is merged , maybe it will break some laptops.

Fair enough but can those people with such laptops test the patch too 
and report back? Can you say in what form the breakages will take? From 
what you are saying it sounds like this patch shouldn't have had any 
affect for me but it does. What happens when they try it? What happens 
when you try it?

-- 
Sitsofe | http://sucs.org/~sits/
