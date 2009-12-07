From: Robert Hancock <hancockrwd@gmail.com>
Subject: AER/hotplug _OSC wierdness?
Date: Sun, 06 Dec 2009 21:55:49 -0600
Message-ID: <4B1C7CC5.5070709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45841 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933300AbZLGD4I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Dec 2009 22:56:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NHUhp-0007tM-S7
	for linux-acpi@vger.kernel.org; Mon, 07 Dec 2009 04:56:13 +0100
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 07 Dec 2009 04:56:13 +0100
Received: from hancockrwd by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 07 Dec 2009 04:56:13 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: kaneshige.kenji@jp.fujitsu.com

I've been looking into why I get these messages on bootup on an Asus 
P7P55D PRO motherboard:

Firmware did not grant requested _OSC control
aer 0000:00:03.0:pcie02: AER service couldn't init device: no _OSC support
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Firmware did not grant requested _OSC control
Firmware did not grant requested _OSC control
Firmware did not grant requested _OSC control
Firmware did not grant requested _OSC control

The AML code for _OSC in the DSDT (below) is almost identical to the 
example code in the ACPI spec. From looking at the _OSC method, I don't 
see why it should reject any requests for PCI Express hotplug or AER 
control.

I can't quite make sense of the ACPI code that is supposed to handle 
this. When the AER driver calls acpi_pci_osc_control_set, it first does 
this:

	/* Need to query controls first before requesting them */
	if (!root->osc_queried) {
		status = acpi_pci_query_osc(root, root->osc_support_set);
		if (ACPI_FAILURE(status))
			goto out;
	}
	if ((root->osc_control_qry & control_req) != control_req) {
		printk(KERN_DEBUG
		       "Firmware did not grant requested _OSC control\n");
		status = AE_SUPPORT;
		goto out;
	}

Inside acpi_pci_query_osc:

	/* do _OSC query for all possible controls */
	support_set = root->osc_support_set | (flags & OSC_SUPPORT_MASKS);
	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
	capbuf[OSC_SUPPORT_TYPE] = support_set;
	capbuf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;

	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
	if (ACPI_SUCCESS(status)) {
		root->osc_support_set = support_set;
		root->osc_control_qry = result;
		root->osc_queried = 1;
	}

The comment says "do _OSC query for all possible controls", but it 
doesn't look like that's what the code is actually doing. The first time 
this gets called, assuming osc_support_set is 0, it looks like 
support_set passed into _OSC will also be 0. Then osc_queried would be 
set to 1, _OSC would never get called again and the cached query result 
is based on 0 support flags being passed into _OSC, which is wrong. Or 
am I missing something?

     Name (PEHP, One)
     Name (SHPC, Zero)
     Name (PEPM, One)
     Name (PEER, One)
     Name (PECS, One)

...

         Method (_OSC, 4, NotSerialized)
         {
             Name (SUPP, Zero)
             Name (CTRL, Zero)
             CreateDWordField (Arg3, Zero, CDW1)
             CreateDWordField (Arg3, 0x04, CDW2)
             CreateDWordField (Arg3, 0x08, CDW3)
             If (LEqual (Arg0, Buffer (0x10)
                     {
                         /* 0000 */    0x5B, 0x4D, 0xDB, 0x33, 0xF7, 
0x1F, 0x1C, 0x40,
                         /* 0008 */    0x96, 0x57, 0x74, 0x41, 0xC0, 
0x3D, 0xD7, 0x66
                     }))
             {
                 Store (CDW2, SUPP)
                 Store (CDW3, CTRL)
                 If (LNotEqual (And (SUPP, 0x16), 0x16))
                 {
                     And (CTRL, 0x1E, CTRL)
                 }

                 If (LNot (PEHP))
                 {
                     And (CTRL, 0x1E, CTRL)
                 }

                 If (LNot (SHPC))
                 {
                     And (CTRL, 0x1D, CTRL)
                 }

                 If (LNot (PEPM))
                 {
                     And (CTRL, 0x1B, CTRL)
                 }

                 If (LNot (PEER))
                 {
                     And (CTRL, 0x15, CTRL)
                 }

                 If (LNot (PECS))
                 {
                     And (CTRL, 0x0F, CTRL)
                 }

                 If (Not (And (CDW1, One)))
                 {
                     If (And (CTRL, One)) {}
                     If (And (CTRL, 0x04)) {}
                     If (And (CTRL, 0x10)) {}
                 }

                 If (LNotEqual (Arg1, One))
                 {
                     Or (CDW1, 0x08, CDW1)
                 }

                 If (LNotEqual (CDW3, CTRL))
                 {
                     Or (CDW1, 0x10, CDW1)
                 }

                 And (CTRL, 0xEF, CTRL)
                 Store (CTRL, CDW3)
                 Return (Arg3)
             }
             Else
             {
                 Or (CDW1, 0x04, CDW1)
                 Return (Arg3)
             }
         }

