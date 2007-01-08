From: "dhanya" <dhanya.justin@wipro.com>
Subject: How to get PCI slot information from ACPI
Date: Mon, 8 Jan 2007 19:44:03 +0530
Message-ID: <200701081357.TAA11137@wipro.tcpn.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wip-ec-mm01.wipro.com ([203.91.193.25]:47537 "EHLO
	wip-ec-mm01.wipro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbXAHOhD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jan 2007 09:37:03 -0500
Received: from wip-ec-mm01.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 32EDF1F6087
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jan 2007 19:35:12 +0530 (IST)
Received: from wipro.tcpn.com (adm.wipro.tcpn.com [172.31.41.11])
	by wip-ec-mm01.wipro.com (Postfix) with ESMTP id 16F111F6082
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jan 2007 19:35:12 +0530 (IST)
Received: from EC4HP134180 ([172.31.42.81])
	by wipro.tcpn.com (8.9.3/8.9.3) with ESMTP id TAA11137
	for <linux-acpi@vger.kernel.org>; Mon, 8 Jan 2007 19:27:34 +0530 (IST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Hi, 

I need to get PCI slot info through ACPI using _SUN object. So I want to
know how to retrieve the slot info from _SUN object. Can you tell me how to
access the _SUN object? 

I have couple of questions related to that: 

1) Is there any signature in ROM for that object, so that we can map that
and read that structure? 

2) What is the structure of _SUN object and how to get the handle to that
structure? 

Thanks in advance


