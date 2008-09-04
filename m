From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: RFC: fast transactions in EC [was: a problem about the two	patches
 in bug 10724 & 11428]
Date: Thu, 04 Sep 2008 07:56:02 +0400
Message-ID: <48BF5C52.4060708@suse.de>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>	 <48BC57C9.2040409@suse.de>	 <1220421722.4007.4.camel@yakui_zhao.sh.intel.com>  <48BE32AF.0@suse.de>	 <1220429030.4007.22.camel@yakui_zhao.sh.intel.com>	 <48BE427C.3070204@suse.de>	 <1220430856.4007.38.camel@yakui_zhao.sh.intel.com>	 <48BF07E1.8080304@suse.de> <1220497095.4007.76.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:53211 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751856AbYIDDzi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2008 23:55:38 -0400
In-Reply-To: <1220497095.4007.76.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lenb@kernel.org

Zhao Yakui wrote:
>    a. EC GPE storm.  According to ACPI spec the EC uses the pulse
> interrupt and interrupt is firmware generated using an EC GPIO output,
> which is connected with chipset GPIO input. If the pulse waveform is
> very wide, maybe several EC GPE interrupts will be triggered although EC
> firmware generates one pulse waveform. How can we read the corresponding
> data from EC in the GPE interrupt service handler? Maybe the read/write
> data is completely incorrect.
Sorry, I missed the whole idea on first reading :)
You've started talking hardware terms :)
EC in our case exposes two I/O ports 0x62 (status/command) and 0x66 (data r/w).
It always exposes two, but numbers sometime differ... We always did status read
in interrupt context, which is inb(0x62), and always relayed on that being working.
Now you are telling that there is a huge difference between that and inb(0x66), which
will accomplish EC_READ command.
So, could you please tell, how reading of port 0x62 might be all good from interrupt context,
and reading of port 0x66 is completely wrong idea?

Regards,
Alex.
