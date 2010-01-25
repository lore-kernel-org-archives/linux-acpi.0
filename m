From: yakui.zhao@intel.com
Subject: [PATCH v5 0/2] IPMI/ACPI: Install the ACPI IPMI opregion
Date: Mon, 25 Jan 2010 17:24:31 +0800
Message-ID: <1264411473-11273-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64011 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753033Ab0AYJZL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Jan 2010 04:25:11 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, minyard@acm.org, openipmi-developer@lists.sourceforge.net, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Hi, 
	
    ACPI 4.0 spec adds the ACPI IPMI opregion, which means that the ACPI AML
code can also communicate with the BMC controller. This patch set is to
install the ACPI IPMI opregion space handler and enable the ACPI to access
the BMC controller through the IPMI message. 

[Patch 01/02]: use ACPI detection mechanism firstly to detect IPMI system
	interface.
[Patch 02/02]: Install the IPMI space handler to enable ACPI to access the BMC
controller

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

