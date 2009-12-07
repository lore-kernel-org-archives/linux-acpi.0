From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: AER/hotplug _OSC wierdness?
Date: Mon, 07 Dec 2009 18:26:40 +0900
Message-ID: <4B1CCA50.80702@jp.fujitsu.com>
References: <4B1C7CC5.5070709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:45730 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933589AbZLGJ0p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2009 04:26:45 -0500
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id nB79Qo2w004219
	for <linux-acpi@vger.kernel.org> (envelope-from kaneshige.kenji@jp.fujitsu.com);
	Mon, 7 Dec 2009 18:26:50 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 8990D2B6A43
	for <linux-acpi@vger.kernel.org>; Mon,  7 Dec 2009 18:26:48 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (s6.gw.fujitsu.co.jp [10.0.50.96])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 5AF4E1EF083
	for <linux-acpi@vger.kernel.org>; Mon,  7 Dec 2009 18:26:48 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id A234C1DB8040
	for <linux-acpi@vger.kernel.org>; Mon,  7 Dec 2009 18:26:47 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.249.87.104])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 1892CE3800A
	for <linux-acpi@vger.kernel.org>; Mon,  7 Dec 2009 18:26:47 +0900 (JST)
In-Reply-To: <4B1C7CC5.5070709@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-acpi@vger.kernel.org

Robert Hancock wrote:
> I've been looking into why I get these messages on bootup on an Asus 
> P7P55D PRO motherboard:
> 
> Firmware did not grant requested _OSC control
> aer 0000:00:03.0:pcie02: AER service couldn't init device: no _OSC support
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> Firmware did not grant requested _OSC control
> Firmware did not grant requested _OSC control
> Firmware did not grant requested _OSC control
> Firmware did not grant requested _OSC control
> 
> The AML code for _OSC in the DSDT (below) is almost identical to the 
> example code in the ACPI spec. From looking at the _OSC method, I don't 
> see why it should reject any requests for PCI Express hotplug or AER 
> control.
> 
> I can't quite make sense of the ACPI code that is supposed to handle 
> this. When the AER driver calls acpi_pci_osc_control_set, it first does 
> this:
> 
>     /* Need to query controls first before requesting them */
>     if (!root->osc_queried) {
>         status = acpi_pci_query_osc(root, root->osc_support_set);
>         if (ACPI_FAILURE(status))
>             goto out;
>     }


Just in case, does removing this 'if' statement fix the problem?


>     if ((root->osc_control_qry & control_req) != control_req) {
>         printk(KERN_DEBUG
>                "Firmware did not grant requested _OSC control\n");
>         status = AE_SUPPORT;
>         goto out;
>     }
> 
> Inside acpi_pci_query_osc:
> 
>     /* do _OSC query for all possible controls */
>     support_set = root->osc_support_set | (flags & OSC_SUPPORT_MASKS);
>     capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
>     capbuf[OSC_SUPPORT_TYPE] = support_set;
>     capbuf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
> 
>     status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
>     if (ACPI_SUCCESS(status)) {
>         root->osc_support_set = support_set;
>         root->osc_control_qry = result;
>         root->osc_queried = 1;
>     }
> 
> The comment says "do _OSC query for all possible controls", but it 
> doesn't look like that's what the code is actually doing. The first time 
> this gets called, assuming osc_support_set is 0, it looks like 
> support_set passed into _OSC will also be 0. Then osc_queried would be 
> set to 1, _OSC would never get called again and the cached query result 
> is based on 0 support flags being passed into _OSC, which is wrong. Or 
> am I missing something?
> 

Though I might be missing something, I think _OSC is evaluated
and osc_control_qry is updated, whenever acpi_pci_osc_support()
gets called.

Thanks,
Kenji Kaneshige

