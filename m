From: Andrew Morton <akpm@osdl.org>
Subject: "Device is not power manageable"
Date: Tue, 21 Feb 2006 04:27:08 -0800
Message-ID: <20060221042708.653944c1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:48844 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751176AbWBUM2s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Feb 2006 07:28:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1LCSlDZ015346
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-acpi@vger.kernel.org>; Tue, 21 Feb 2006 04:28:47 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k1LCSkFm013693
	for <linux-acpi@vger.kernel.org>; Tue, 21 Feb 2006 04:28:46 -0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


What does this mean?

sony:/home/akpm> dmesg -s 1000000 | grep 199
Detected 1995.262 MHz processor.
Sangoma WANPIPE Router v1.1 (c) 1995-2000 Sangoma Technologies Inc.
ACPI (acpi_bus-0199): Device is not power manageable [20060210]
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI (acpi_bus-0199): Device is not power manageable [20060210]
ACPI (acpi_bus-0199): Device is not power manageable [20060210]
ACPI (acpi_bus-0199): Device is not power manageable [20060210]
ACPI (acpi_bus-0199): Device is not power manageable [20060210]
ACPI (acpi_bus-0199): Device is not power manageable [20060210]
ACPI (acpi_bus-0199): Device is not power manageable [20060210]
ACPI (acpi_bus-0199): Device is not power manageable [20060210]
ACPI (acpi_bus-0199): Device is not power manageable [20060210]
ACPI (acpi_bus-0199): Device is not power manageable [20060210]
ACPI (acpi_bus-0199): Device is not power manageable [20060210]
ACPI (acpi_bus-0199): Device is not power manageable [20060210]

<suspend-to-ram>
<resume>

ACPI Error (evevent-0314): No installed handler for fixed event [00000002] [20060210]


And how does one identify that device?

