From: yakui.zhao@intel.com
Subject: [RFC PATCH 0/4_v13] IPMI/ACPI: Install the ACPI IPMI opregion
Date: Tue, 30 Nov 2010 08:26:17 +0800
Message-ID: <1291076781-9438-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7352 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754776Ab0K3AcZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Nov 2010 19:32:25 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: minyard@acm.org
Cc: openipmi-developer@lists.sourceforge.net, lenb@kernel.org, linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Hi, 
	
    ACPI 4.0 spec adds the ACPI IPMI opregion, which means that the ACPI AML
code can also communicate with the BMC controller. This patch set is to
install the ACPI IPMI opregion space handler and enable the ACPI to access
the BMC controller through the IPMI message.

[RFC Patch 01/04]: Add one interface to get more info of low-level interface
	It will return the corresponding info of low-level interface based 
	on the expected type(For example: SI_ACPI, SI_PCI and so on.)

[RFC Patch 02/04]: Remove the redudant definition of ipmi_addr_src type

[RFC Patch 03/04]: Add the document description about how to use the function
of ipmi_get_smi_info

[RFC Patch 04/04]: Install the IPMI space handler to enable ACPI to access the BMC
controller

V12->V13: Change the function prototype of ipmi_put_smi_info and remove the
incorrect refcount.

V11->V12: Change back to copy mechanism in V10 and care the refcount of dev when
calling the function of ipmi_get_smi_info. At the same time the addr_source type is
not passed as the argument any more. Instead the caller does the comparison.

V10->V11: Delete the incorrect refcount in V10. At the same time the function of
ipmi_get_smi_info will return the reference pointer to avoid the memory copy.

V9-V10: Redefine the interface function to get more info of low-level IPMI
device. And add the document description about how to use it. 

V8-V9: This patch set is based on the mechanism that add one interface that can 
get more info of low-level IPMI device. For example: the ACPI device handle will
be returned for the pnp_acpi. Then the second patch will use the added interface
to check whether the IPMI device is what ACPI wanted to communicated with in the
new_smi callback function of smi_watcher. If it is, we will install the IPMI
opregion handler and enable ACPI to communicate with BMC.

V7->V8: Based on Bjorn's comment, use acpi ipmi notifier hook function to
avoid the discovery of ACPI pnp IPMI device again. Then in course of binding
/unbinding ipmi pnp driver with the corresponding device, the notifier chain
function will be called to install/uninstall the ACPI IPMI opregion space
handler. 

V6->V7: Based on Corey Minyard's comments, the IPMI opregion handler is put
into the separate file again as it only uses the API interface provided
by IPMI system. Now it is put into the ACPI subsystem.

V5->V6: Adjust the patch order and refresh the patch set.

V4->V5: According to Bjorn's comment, remove the unnecessary comment.
The debug info will be printed by using dev_err/dev_warn instead of by
using printk directly.

V3->V4: According to Bjorn's comment, delete the meaningless variable
initialization and check. We also do some cleanup. 

V2->V3: According to Bjorn's comment, this IPMI opregion code is put into
the IPMI subsystem(ipmi_si_intf.c). In such case the part of IPMI opregion
code  will be installed automatically when IPMI detection module is loaded.
When the IPMI system interface is detected by loading PNP device driver, we
will record every IPMI system interface defined in ACPI namespace and then
install the corresponding IPMI opregion space handler, which is used to enable
ACPI AML code to access the BMC controller.

V1->V2: According to Bjorn's comment, we won't install the IPMI space handler
by loading an ACPI device driver. Instead we will enumerate the ACPI IPMI
device directly in ACPI device tree and then install the IPMI space handler.
Then ACPI AML code and access the BMC controller through the IPMI space
handler.

Best regards.
   Yakui

