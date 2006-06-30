From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 2/6] ACPI: Atlas ACPI driver
Date: Fri, 30 Jun 2006 14:39:27 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6E16BE4@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1193 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S933001AbWF3Sjh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jun 2006 14:39:37 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, jayakumar.acpi@gmail.com, dtor_core@ameritech.net, "Yu, Luming" <luming.yu@intel.com>

> +	if (function == ACPI_WRITE) {
> +		status = acpi_bus_generate_event(dev, 0x80, address);
> +		atlas_input_report((u8) address);

What is the reasoning to simultaneously report the same event
via both ACPI and input?

Is there a volunteer to maintain this driver?

thanks,
-Len
