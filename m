From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Thu, 04 Sep 2008 07:47:43 +0400
Message-ID: <48BF5A5F.6060508@suse.de>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>	 <48BC57C9.2040409@suse.de>	 <1220421722.4007.4.camel@yakui_zhao.sh.intel.com>  <48BE32AF.0@suse.de>	 <1220429030.4007.22.camel@yakui_zhao.sh.intel.com>	 <48BE427C.3070204@suse.de>	 <1220430856.4007.38.camel@yakui_zhao.sh.intel.com>	 <48BF0FA1.4040807@suse.de> <1220499806.4007.113.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:52380 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753709AbYIDDrU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2008 23:47:20 -0400
In-Reply-To: <1220499806.4007.113.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lenb@kernel.org

Zhao Yakui wrote:
> Hi, Alexey
>    After investigation I found that the laptop in bug 11428 is the same
> as that in bug 8459. Is the EC on such laptop that you mean "optimized"
> EC? But in fact the OBF and IBF can reflect the EC status correctly
> although sometimes there is no GPE interrupt confirmation.
Why you use "but in fact" here? There is no reason to repeat to me my own
findings as a "new truth"...
> At the same time maybe EC will send a notification event requiring OS's
> attention. In such case OS can detect whether the notification event is
> sent  by checking the SCI_EVT bit in the EC GPE interrupt service
> routine.(I.E . acpi_ec_gpe_handler). In fact only checking notification
> event in ec gpe handler is enough to make EC work.
> 
> If so, the EC work flowchart will become very simple. I will try to
> write this patch and consult with Len.
You just described software poll mode of EC driver,
"missing confirmations" are the switch from pure interrupt mode to "the 
poll for IBF/OBF changes, but expect interrupt for SCI change".
Do you plan to drop pure interrupt mode now?
> 
> There is another issue. From the log in  comment #26 of bug 11428 I find
> that OS still issues the burst disable command although EC already exits
> the burst mode. Maybe we should check whether the EC is in burst mode
> before issuing EC burst disable command.
Does it hurt? 
>     >ACPI: EC: transaction start
>     >[  124.540016] ACPI: EC: <--- command = 0x83
>     >[  124.540016] ACPI: EC: ---> status = 0x0a
>     >[  124.542009] ACPI: EC: ---> status = 0x08
>     >[  124.542009] ACPI: EC: transaction end
> 
> Thanks.
>   
>  
>    
> 
>> Alex.
> 

