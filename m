From: "Wu, Cody" <cody.wu@intel.com>
Subject: Quesiton on ACPI & APIC
Date: Thu, 3 Aug 2006 15:49:17 +0800
Message-ID: <CA502B3E9EE27B4490C87C12E3C7C8516D2580@pdsmsx412.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1670 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932364AbWHCHuD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2006 03:50:03 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, All

I am reading Linux Kernel's IOAPIC Init routine recently and I found that Linux 2.6.17 Kernel's APIC_init_uniprocessor() routine doesn't use ACPI table's MADT but instead will try to locate MP table. If the MP table is not there, the init routine will simply exit. This is something weird to me, as I take it fro granted that IOAPIC should be initialized using ACPI table now that ACPI is invented partly to take the place of MP table. Can anyone give me some explanations or I was just missing something? Thanks!

Best regards,
Cody
