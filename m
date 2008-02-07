From: Jiri Kosina <jikos@jikos.cz>
Subject: DMI update
Date: Thu, 7 Feb 2008 11:47:22 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802071146100.30873@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:42561 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755371AbYBGKr0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 05:47:26 -0500
Received: from twin.jikos.cz (jikos@twin [127.0.0.1])
	by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id m17AlNkG023713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 7 Feb 2008 11:47:24 +0100
Received: from localhost (jikos@localhost)
	by twin.jikos.cz (8.13.6/8.13.6/Submit) with ESMTP id m17AlM97023708
	for <linux-acpi@vger.kernel.org>; Thu, 7 Feb 2008 11:47:23 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

sending DMI info as suggested by dmesg output.

BTW does anyone have any idea about the parse errors?

ACPI: EC: EC description table is found, configuring boot EC
ACPI Error (evregion-0316): No handler for Region [ECOR] 
(ffff81007d36f620) [EmbeddedControl] [20070126]
ACPI Error (exfldio-0289): Region EmbeddedControl(3) has no handler 
[20070126]
ACPI Error (psparse-0537): Method parse/execution failed 
[\_SB_.PCI0.LPC_.EC__.AC__._PSR] (Node ffff81007d374630), AE_NOT_EXIST
ACPI Error (psparse-0537): Method parse/execution failed 
[\_SB_.PCI0.LPC_.EC__.HKEY.CKC4] (Node ffff81007d374270), AE_NOT_EXIST
ACPI Error (psparse-0537): Method parse/execution failed [\_GPE._L02] 
(Node ffff81007d3807d0), AE_NOT_EXIST
ACPI Exception (evgpe-0576): AE_NOT_EXIST, while evaluating GPE method 
[_L02] [20070126]
Completing Region/Field/Buffer/Package 
initialization:.............................................................................................................................
.........................................................................................................................................
Initialized 31/34 Regions 122/122 Fields 52/52 Buffers 57/73 Packages 
(1845 nodes)
Initializing Device/Processor/Thermal objects by executing _INI 
methods:.<5>ACPI: BIOS _OSI(Linux) query honored via cmdline
ACPI: DMI System Vendor: LENOVO
ACPI: DMI Product Name: 76693KG
ACPI: DMI Product Version: ThinkPad X61s
ACPI: DMI Board Name: 76693KG
ACPI: DMI BIOS Vendor: LENOVO
ACPI: DMI BIOS Date: 12/28/2007
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
ACPI: EC: non-query interrupt received, switching to interrupt mode
........

