From: yakui.zhao@intel.com
Subject: [PATCH v4 0/2] IPMI/ACPI: Install the ACPI IPMI opregion
Date: Fri, 18 Dec 2009 15:56:59 +0800
Message-ID: <1261123021-22836-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62022 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbZLRH6z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Dec 2009 02:58:55 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com, minyard@acm.org, openipmi-developer@lists.sourceforge.net, Zhao Yakui <yakui.zhao@intel.com>

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

