From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Add debugfs support for ACPICA boot time measurement.
Date: Thu, 08 Nov 2012 01:08:54 -0500
Message-ID: <509B4C76.7000105@kernel.org>
References: <a4f15c34285624904d483e22b9b7a10c7d97fc3d.1352339077.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57527 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab2KHGI5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Nov 2012 01:08:57 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so2359120vbb.19
        for <linux-acpi@vger.kernel.org>; Wed, 07 Nov 2012 22:08:56 -0800 (PST)
In-Reply-To: <a4f15c34285624904d483e22b9b7a10c7d97fc3d.1352339077.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

On 11/07/2012 08:49 PM, Lv Zheng wrote:
> ACPICA defines the following initialization steps that must be called to
> make ACPICA functional:
>   1. acpi_initialize_tables
>   2. acpi_initialize_subsystem
>   3. acpi_load_tables
>   4. acpi_enable_subsystem
>   5. acpi_initialize_objects
>   6. OSPM specific bus scanning
>   7. acpi_update_all_gpes
> This patch allows developers to check the execution time of such bootup
> steps through /sys/kernel/debug/acpi/acpica_init_time.
> 
> The ACPICA 20121018 release measurement result is as follows:
> ========================================
>     0.000000 acpi_initialize_tables
>     0.000034 acpi_initialize_subsystem
>     0.004822 acpi_load_tables
>     0.003351 acpi_enable_subsystem
>     0.003204 acpi_initialize_objects
>     0.045082 acpi_bus_scan
>     0.000023 acpi_bus_scan_fixed
>     0.000017 acpi_update_all_gpes
> ========================================
> The left column is the execution time in timeval (sec.usec) format.
> The right column indicates the name of the initialization step.

As you've identified that 80% of the ACPI startup time goes to acpi_bus_scan(),
have you identified any ways to make acpi_bus_scan() faster?

Do these numbers vary greatly when run on different machines?

thanks,
-Len Brown, Intel Open Source Technology Center


