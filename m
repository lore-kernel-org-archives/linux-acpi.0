From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: ec locking issue
Date: Thu, 15 Feb 2007 14:26:16 -0500
Message-ID: <20070215192616.GA31595@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:40956 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030776AbXBOTdA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Feb 2007 14:33:00 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Current kernels (e.g. 2.6.20-git-as-of-yesterday) don't boot for me, and
it seems like ACPI is the cause: the last thing I can see in the log is

swapper/1 is trying to acquire lock
	&ec->lock

but task is already holding lock
	&ec->lock

Snippets from the call trace:

acpi_ec_transaction
acpi_ec_read
acpi_ec_space_handler
acpi_ev_address_space_dispatch
acpi_ex_access_region
acpi_ex_field_datum_
acpi_ex_extract_from_field
...
acpi_ex_ns_evaluate
acpi_ev_execute_reg_method
acpi_ev_reg_run
acpi_ns_walk_namespace
acpi_ev_execute_reg_methods
acpi_install_address_space_handler
acpi_ec_start
acpi_start_single_object
acpi_device_probe
really_probe
...
bus_add_driver
...
acpi_ec_init



Ideas? Patches?

Thanks,
	Dominik
