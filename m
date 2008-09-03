From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Wed, 03 Sep 2008 11:53:32 +0400
Message-ID: <48BE427C.3070204@suse.de>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>	 <48BC57C9.2040409@suse.de>	 <1220421722.4007.4.camel@yakui_zhao.sh.intel.com>  <48BE32AF.0@suse.de> <1220429030.4007.22.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:54305 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751086AbYICHxR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2008 03:53:17 -0400
In-Reply-To: <1220429030.4007.22.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lenb@kernel.org

Zhao Yakui wrote:
> On Wed, 2008-09-03 at 10:46 +0400, Alexey Starikovskiy wrote:
>> Zhao Yakui wrote:
>>> On Tue, 2008-09-02 at 00:59 +0400, Alexey Starikovskiy wrote:
>>>> Alexey Starikovskiy wrote:
>>> Hi, Alexey
>>>     In this patch after the EC timeout happens, the EC_FLAGS_GPE_MODE of
>>> ec->flags will be clear and EC_FLAGS_NO_GPE bit will be set. But the EC
>>> GPE won't be disabled again. Right?
>> Right
>>>     In such case when  EC is accessed, EC will work in polling mode. At
>>> the same time EC interrupt still can be triggered. But the
>>> EC_FLAGS_GPE_MODE can't be set again. Right?
>> Almost. EC by itself (hardware device) still will be working in its 
>> "optimized gpe mode" as before, but EC driver (software) will be working in poll mode.
>> Regards,
> If EC always works in such mode, it seems that we can make EC work more
> simply. 
If you _disable_ EC GPE or not enable it in first place, EC(hardware) will be working in
poll mode. So, there is no spare code to clean up, sorry. 
> If so, a lot of source code in EC will be useless and we can do a
> cleanup. After this, the EC driver will be easier to understand. When
> new problems appears, we can easily identify the root cause.
> 
> Thanks.
>    Yakui
