From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/2] for acpi_memhotplug.c
Date: Thu, 22 Jun 2006 15:11:04 +0900
Message-ID: <20060622151104.3790703c.kamezawa.hiroyu@jp.fujitsu.com>
References: <971FCB6690CD0E4898387DBF7552B90E0378BEE7@orsmsx403.amr.corp.intel.com>
	<437F1766.8090705@jp.fujitsu.com>
	<1150853300.5873.49.camel@keithlap>
	<20060621114334.1b954854.kamezawa.hiroyu@jp.fujitsu.com>
	<1150863525.7865.6.camel@keithlap>
	<20060621194832.37124aae.kamezawa.hiroyu@jp.fujitsu.com>
	<1150915426.5830.21.camel@keithlap>
	<1150932228.9235.6.camel@keithlap>
	<20060622091336.be46e7a6.kamezawa.hiroyu@jp.fujitsu.com>
	<1150940220.10001.11.camel@keithlap>
	<20060622105854.18fa1f16.kamezawa.hiroyu@jp.fujitsu.com>
	<1150942799.10001.30.camel@keithlap>
	<20060622121356.6326e4a2.kamezawa.hiroyu@jp.fujitsu.com>
	<1150948503.10001.60.camel@keithlap>
	<20060622142038.86ec6472.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:8424 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751645AbWFVGL4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jun 2006 02:11:56 -0400
In-Reply-To: <20060622142038.86ec6472.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: kmannth@us.ibm.com, prarit@redhat.com, linux-acpi@vger.kernel.org, darnok@us.ibm.com, robert.moore@intel.com, lhms-devel@lists.sourceforge.net

On Thu, 22 Jun 2006 14:20:38 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> - acpi_memory_device_init() -> acpi_memory_register_notify_handler()
>   installs notify handler for memory hotplug against device handle of memory
>   This doesn't check _CID.
> 
> - acpi_bus_add() attachs motherboard driver because of CID.
>   Above _CID is 32bit compressed EISA-type ID (HID is string but..),
>   it is PNP0C01...motherboad driver is called before PNP0C80 driver.
>   (to covert 32bit ID to string, see acpi_ex_eisa_id_to_string(),
>    I attached program.)
> 
> Then what we should do here is...call HID:PNP0C80 driver instead if CID:PNP0C01 driver.
> Because it has driver for HID, calling driver for CID looks not good.
> (But we have to ask acpi people about this..)
> 
Ah... BTW, why PNP0C80(memory) and PNP0C01(motherboard) are described as 
"compatible device" ? Are they compatible ?

-Kame

