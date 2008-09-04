From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: RFC: fast transactions in EC [was: a problem about the two	patches
 in bug 10724 & 11428]
Date: Thu, 04 Sep 2008 07:06:36 +0400
Message-ID: <48BF50BC.1050405@suse.de>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>	 <48BC57C9.2040409@suse.de>	 <1220421722.4007.4.camel@yakui_zhao.sh.intel.com>  <48BE32AF.0@suse.de>	 <1220429030.4007.22.camel@yakui_zhao.sh.intel.com>	 <48BE427C.3070204@suse.de>	 <1220430856.4007.38.camel@yakui_zhao.sh.intel.com>	 <48BF07E1.8080304@suse.de> <1220497095.4007.76.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:48326 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753397AbYIDDGO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2008 23:06:14 -0400
In-Reply-To: <1220497095.4007.76.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lenb@kernel.org

Zhao Yakui wrote:
> On Thu, 2008-09-04 at 01:55 +0400, Alexey Starikovskiy wrote:
>> Hi,
>> Here is the patch, which moves almost all transaction functionality into interrupt handler, which is IMHO good.
>>
>> with the enabled DEBUG, the interrupt picture looks like this (single transaction):
> Thanks for your work and efforts. Maybe you have tested the patch on
> your laptop. But IMO this is not reasonable. In the following cases
> maybe the patch can't work well.
>    a. EC GPE storm.  According to ACPI spec the EC uses the pulse
This _is_ the machine with the EC GPE storm. Acer TM 2300. And the patch works...
And you may see it in the quote I gave.
> interrupt and interrupt is firmware generated using an EC GPIO output,
> which is connected with chipset GPIO input. If the pulse waveform is
> very wide, maybe several EC GPE interrupts will be triggered although EC
> firmware generates one pulse waveform. How can we read the corresponding
> data from EC in the GPE interrupt service handler? Maybe the read/write
> data is completely incorrect.
Well, it is not any different from the data I get with unpatched ec.c.
>    b. If there is no EC interrupt although OBF_1 bit is valid.(In theory
> when OBF_1 is valid, EC should trigger GPE interrupt). In such case the
> read/write flowchart will be wrong.
Oh, you mean it does not cover all the error paths yet?
>   At the same time it seems that EC transaction flowchart will become
> more complex in this patch.
How so? It even does not involve second thread any longer :)
