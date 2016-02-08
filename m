From: Timur Tabi <timur@codeaurora.org>
Subject: platform_get_irq_byname() supported on ACPI?
Date: Mon, 8 Feb 2016 10:48:33 -0600
Message-ID: <56B8C6E1.1040804@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48165 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698AbcBHQsg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2016 11:48:36 -0500
Received: from [10.222.143.167] (rrcs-67-52-129-61.west.biz.rr.com [67.52.129.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: timur@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id CE8626023A
	for <linux-acpi@vger.kernel.org>; Mon,  8 Feb 2016 16:48:34 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Is there support for the platform_get_irq_byname() function on ACPI systems?

I'm working on adding ACPI support for a driver that currently only 
supports device tree.  This driver has code like this:

	ret = platform_get_irq_byname(pdev, "core0_irq");

This function works fine on device tree, but it fails on our ACPI system 
because our ACPI nodes don't appear to have any way to attach a name to 
an IRQ resource:

Method (_CRS, 0x0, Serialized) {
	Name (RBUF, ResourceTemplate() {
		[snip]
		Interrupt (ResourceConsumer, Level, ActiveHigh,
			Exclusive, , , )
			{0x120, 0x121, 0x122, 0x123}
	})
	Return (RBUF)
}

I would hate to have to do something like this:

ret = platform_get_irq_byname(pdev, "core0_irq");
if (ret)
	/* ACPI doesn't support named resources */
	ret = platform_get_irq(pdev, 0);

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, a Linux Foundation Collaborative Project.
