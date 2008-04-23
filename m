From: Juha Heljoranta <juha.heljoranta@iki.fi>
Subject: DMI info for Zepto Znote
Date: Wed, 23 Apr 2008 22:54:11 +0300
Message-ID: <20080423225411.27f9bc8f@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:51838 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbYDWUDM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Apr 2008 16:03:12 -0400
Received: from localhost.localdomain (a88-112-7-19.elisa-laajakaista.fi [88.112.7.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 3A317151261
	for <linux-acpi@vger.kernel.org>; Wed, 23 Apr 2008 22:54:11 +0300 (EEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

>From the 2.6.25-1.fc9.x86_64 dmesg:

kernel: ACPI: BIOS _OSI(Linux) query ignored
kernel: ACPI: DMI System Vendor: Zepto
kernel: ACPI: DMI Product Name: Znote
kernel: ACPI: DMI Product Version: 6014W
kernel: ACPI: DMI Board Name: Znote
kernel: ACPI: DMI BIOS Vendor: Phoenix Technologies LTD
kernel: ACPI: DMI BIOS Date: 07/19/2007
kernel: ACPI: Please send DMI info above to linux-acpi@vger.kernel.org

Sticker on my laptop says 6024W and not 6014W... For dmidecode output please look at:
https://bugzilla.redhat.com/show_bug.cgi?id=443867

Bugzilla entry is about acpi generating lot of interrupts according to PowerTOP. Any insight on the issue is appreciated :)

Please cc me on replies.
