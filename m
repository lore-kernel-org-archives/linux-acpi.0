From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: next: sfi build fails when !CONFIG_ACPI
Date: Thu, 16 Jul 2009 12:48:01 +0400
Message-ID: <a4423d670907160148n66760052wbef60e4a2c3c7941@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:62719 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbZGPIsD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jul 2009 04:48:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-next <linux-next@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Hi

drivers/sfi/sfi_core.c: In function 'sfi_init':
drivers/sfi/sfi_core.c:346: error: 'acpi_disabled' undeclared (first
use in this function)
drivers/sfi/sfi_core.c:346: error: (Each undeclared identifier is
reported only once
drivers/sfi/sfi_core.c:346: error: for each function it appears in.)


$ grep ACPI .config
# Power management and ACPI options
