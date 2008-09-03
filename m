From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Thu, 04 Sep 2008 02:28:49 +0400
Message-ID: <48BF0FA1.4040807@suse.de>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>	 <48BC57C9.2040409@suse.de>	 <1220421722.4007.4.camel@yakui_zhao.sh.intel.com>  <48BE32AF.0@suse.de>	 <1220429030.4007.22.camel@yakui_zhao.sh.intel.com>	 <48BE427C.3070204@suse.de> <1220430856.4007.38.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:52335 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752000AbYICW2d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2008 18:28:33 -0400
In-Reply-To: <1220430856.4007.38.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lenb@kernel.org

Hi Yakui,

Zhao Yakui wrote:
>> If you _disable_ EC GPE or not enable it in first place, EC(hardware) will be working in
>> poll mode. So, there is no spare code to clean up, sorry. 
> Not understand what you said.
It seems to be not my problem...
> After your three patches hit the upstream kernel, the EC GPE is still
> enabled when EC timeout happens. In such case when EC is accessed, EC
> will work in polling mode. At the same time EC GPE interrupt still can
> be triggered.
One of my patches adds option to not enable EC GPE (ec_intr=0), so it is
possible to run EC driver in hardware poll mode, and all the code for such
operation is needed. I do not know how to say it in simpler terms, sorry.
If it is still unclear, please consult with Len... 
Regards,
Alex.
