From: Len Brown <lenb@kernel.org>
Subject: 2.6.24.1 acpi oops in acpi_os_release_object
Date: Wed, 13 Feb 2008 00:36:00 -0500
Message-ID: <200802130036.00931.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52300 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbYBMFgO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Feb 2008 00:36:14 -0500
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id m1D5a63j005465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Wed, 13 Feb 2008 05:36:07 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Looks like 2.6.24.1.fc9 is taking an ACPI related oops:

http://www.kerneloops.org/search.php?search=acpi_os_release_object

*acpi_os_release_object
acpi_ut_update_ref_count
acpi_ut_update_object_reference
kmem_cache_free
acpi_ds_method_data_delete_all
acpi_ds_terminate_control_method
acpi_ps_parse_aml
acpi_ps_execute_method
acpi_ns_evaluate
acpi_evaluate_object
acpi_evaluate_integer
acpi_thermal_check
acpi_os_wait_semaphore
acpi_thermal_check
acpi_os_execute_deferred
acpi_os_execute_deferred
run_workqueue
worker_thread
autoremove_wake_function
worker_thread
kthread
trace_hardirqs_on_thunk
child_rip
restore_args
kthreadd
kthread
child_rip
