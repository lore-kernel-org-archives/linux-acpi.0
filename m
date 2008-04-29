From: Taku Izumi <izumi.taku@jp.fujitsu.com>
Subject: BIOS _OSI(Linux) query ignored on PRIMEQUEST
Date: Tue, 29 Apr 2008 19:34:33 +0900
Message-ID: <4816F9B9.3090609@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:49071 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759894AbYD2Kes (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 06:34:48 -0400
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id m3TAYk8i016548
	for <linux-acpi@vger.kernel.org> (envelope-from izumi.taku@jp.fujitsu.com);
	Tue, 29 Apr 2008 19:34:46 +0900
Received: from smail (m5 [127.0.0.1])
	by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 96E7F2AC027
	for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2008 19:34:46 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 6DA1C12C045
	for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2008 19:34:46 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3 [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 55CBA161C007
	for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2008 19:34:46 +0900 (JST)
Received: from fjm502.ms.jp.fujitsu.com (fjm502.ms.jp.fujitsu.com [10.56.99.74])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id F15B1161C009
	for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2008 19:34:45 +0900 (JST)
Received: from fjmscan503.ms.jp.fujitsu.com (fjmscan503.ms.jp.fujitsu.com [10.56.99.143])by fjm502.ms.jp.fujitsu.com with ESMTP id m3TAYZ5k020978
	for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2008 19:34:35 +0900
Received: from [127.0.0.1] ([10.124.100.133])
	by fjmscan503.ms.jp.fujitsu.com (8.13.1/8.12.11) with ESMTP id m3TAYYHQ015894
	for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2008 19:34:35 +0900
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

The following message is displayed on our server(PRIMEQUEST):

  ACPI: bus type pci registered
  ACPI: EC: Look up EC in DSDT
  ACPI: BIOS _OSI(Linux) query ignored
  ACPI: DMI System Vendor: <NULL>
  ACPI: DMI Product Name: <NULL>
  ACPI: DMI Product Version: <NULL>
  ACPI: DMI Board Name: <NULL>
  ACPI: DMI BIOS Vendor: FUJITSU LIMITED
  ACPI: DMI BIOS Date: 1/17/2008
  ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
  ACPI: If "acpi_osi=Linux" works better, please notify
linux-acpi@vger.kernel.org

Because "acpi_osi=Linux" boot option works well, so we want to
use _OSI(Linux) query on PRIMEQUEST without this boot option and
inihibit above message.

I thought the way to achive our goal was to add
the following entry to acpi_osi_dmi_table
(at drivers/acpi/blacklist.c),

   {
     .callback = dmi_enable_osi_linux,
     .ident = "Fujitsu PRIMEQUEST",
     .matches = {
             DMI_MATCH(DMI_BIOS_VENDOR, "FUJITSU LIMITED"),
	    },
   }

but unfortunately this table seems to be valid only for x86 machines.
Our server is ia64, but what is the best solution?

-- 
Regards,

Taku Izumi <izumi.taku@jp.fujitsu.com>

