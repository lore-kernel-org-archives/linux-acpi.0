From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: ACPI errors
Date: Mon, 5 Jun 2006 20:49:44 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD11206F0@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49239 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751075AbWFEMtv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2006 08:49:51 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Emiliano Grilli <emiliano.grilli@poste.it>
Cc: linux-acpi@vger.kernel.org


Sure, Please open a bug at bugzilla.kernel.org.
Please post acpidump output, and dmesg.

Thanks,
Luming

>I get a lot of these errors in dmesg:
>
> ACPI-0339: *** Error: Looking up [\_TZ_.THRM] in namespace,
>AE_NOT_FOUND
>search_node dfff7800 start_node dfff7800 return_node 00000000
>    ACPI-0508: *** Error: Method execution failed [\_GPE._L1C] (Node
>dfff7800), AE_NOT_FOUND
>    ACPI-0549: *** Error: AE_NOT_FOUND while evaluating method [_L1C]
>for GPE[ 0]
>
>This happens with 2.6.14 and 2.6.16 kernels
>
>
>Can you help me?
>
>
