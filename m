From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Mon, 01 Sep 2008 16:52:40 +0400
Message-ID: <48BBE598.3020700@suse.de>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com> <20080901122158.GB21970@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:47837 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759028AbYIAMwl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Sep 2008 08:52:41 -0400
In-Reply-To: <20080901122158.GB21970@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

Henrique de Moraes Holschuh wrote:
> On Mon, 01 Sep 2008, Zhao Yakui wrote:
>>     Will the above two patches hit the upstream kernel? If the above two patches hits the upstream kernel, it 
>> seems that the boot option of "ec_intr=" comes back again and EC can't be switched from interrupt mode to polling 
>> mode if EC GPE interrupt is missing. In such case maybe the battery/AC/thermal driver can't work well if the info of
>> battery/AC/thermal is related with EC. Maybe there exists the regression on some laptops.
> 
> Right now, the fact that it gives up on interrupt mode too easily IS causing
> regressions on ThinkPads (like the T43 I own).  Since polling mode does
> work, it is just a performance regression, so you won't get many reports
> about it since most people don't look for such stuff in their kernel logs.
> 
> Some ECs trigger the interrupt/poll-mode checks just on small windows
> (typically during resume -- might even be a bug somewhere in ACPICA or
> Linux, and not on the EC).  We should not be giving up using interrupt mode
> on these so easily.  Maybe retry enabling interrupt mode after some seconds
> a few times (like 3 or 5)?  If it is a transient problem, that will avoid
> the permanent performance regression of polled mode.
Right, I am considering this option too.

Thanks,
Alex.
