From: Peter Klotz <peter.klotz@aon.at>
Subject: ACPI related kernel panic when booting 2.6.29-rc2
Date: Sat, 17 Jan 2009 21:47:17 +0100
Message-ID: <497243D5.8000708@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat-warsl417-02.aon.at ([195.3.96.120]:40380 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751389AbZAQUyF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Jan 2009 15:54:05 -0500
Received: from smarthub95.highway.telekom.at (HELO email.aon.at) ([172.18.5.234])
          (envelope-sender <peter.klotz@aon.at>)
          by fallback44.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-acpi@vger.kernel.org>; 17 Jan 2009 20:47:20 -0000
Received: from 212-183-101-99.adsl.highway.telekom.at (HELO [192.168.0.100]) ([212.183.101.99])
          (envelope-sender <peter.klotz@aon.at>)
          by smarthub95.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-acpi@vger.kernel.org>; 17 Jan 2009 20:47:18 -0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On bootup of 2.6.29-rc2 a kernel panic in acpi_ns_get_parent_node occurs.

This is the backtrace (written down from the screen, maybe incomplete):

acpi_ev_execute_reg_methods
acpi_install_address_space_handler
acpi_ec_space_handler
acpi_init
ec_install_handlers
acpi_ec_ecdt_probe
acpi_init
fbmem_init
_stext
register_irq_proc
proc_pident_readdir
kernel_init
child_rip
kernel_init
child_rip

RIP [...] acpi_ns_get_parent_node

I can provide a screenshot (270kB) if this information is insufficient.

The system booted with 2.6.29-rc1 so a recent change must be the cause 
of this panic.

The system is an Asus B50A laptop running an x86_64 kernel.

Maybe this problem is related to these messages I was seeing in bootups 
of previous kernels:

[    0.176398] ACPI Error (nsaccess-0434): ACPI path has too many parent 
prefixes (^) - reached beyond root node [20080926]

Regards, Peter.
