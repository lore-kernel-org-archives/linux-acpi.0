From: "Kleen, Andi" <andi.kleen@intel.com>
Subject: RE: [PATCH] ACPI: Ignore AE_NOT_FOUND error of EC _REG method and continue to initialize EC
Date: Thu, 31 Jul 2008 21:04:26 +0100
Message-ID: <38E5333AA17D0A4DABBB33D71000D2907CB700@swsmsx411.ger.corp.intel.com>
References: <5f6f8c5f0807301903p5018e656y743d131822b4056e@mail.gmail.com>	 <9D39833986E69849A2A8E74C1078B6B3BFA98A@orsmsx415.amr.corp.intel.com> <1217485738.4006.73.camel@yakui_zhao.sh.intel.com> <48920EE0.6030808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36451 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbYGaUE0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jul 2008 16:04:26 -0400
Content-class: urn:content-classes:message
In-Reply-To: <48920EE0.6030808@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>, "Zhao, Yakui" <yakui.zhao@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Joshua C." <joshuacov@googlemail.com>, linux-acpi@vger.kernel.org, "Lin, Ming M" <ming.m.lin@intel.com>

 

>As already mentioned, there is no point to put this workaround in ec.c.
>Instead, it should be placed into 
>acpi_register_operation_region, or may 
>be even
>higher (like a flag to ignore errors during execution of the method).

Ok I will remove the patch again.  But we'll need an replacement patch
that does all this in a general way.

-Andi
