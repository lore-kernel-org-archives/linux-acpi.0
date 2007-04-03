From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [PATCH] acpi cpuidle driver should handle max_cstate
Date: Mon, 2 Apr 2007 18:49:39 -0700
Message-ID: <653FFBB4508B9042B5D43DC9E18836F532B6E1@scsmsx415.amr.corp.intel.com>
References: <1175564025.29499.1.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33198 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966145AbXDCBtl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Apr 2007 21:49:41 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1175564025.29499.1.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Adam Belay <abelay@novell.com>

 

>-----Original Message-----
>From: Li, Shaohua 
>Sent: Monday, April 02, 2007 6:34 PM
>To: Pallipadi, Venkatesh
>Cc: linux acpi; Brown, Len; Adam Belay
>Subject: RE: [PATCH] acpi cpuidle driver should handle max_cstate
>
>On Tue, 2007-04-03 at 00:44 +0800, Pallipadi, Venkatesh wrote:
>>  
>Ok, updated it.
>
>Signed-off-by: Shaohua Li <shaohua.li@intel.com>
>
>Index: linux/drivers/acpi/processor_idle.c
>===================================================================
>--- linux.orig/drivers/acpi/processor_idle.c	2007-04-03 
>08:47:05.000000000 +0800
>+++ linux/drivers/acpi/processor_idle.c	2007-04-03 
>08:50:50.000000000 +0800
>@@ -75,7 +75,30 @@ ACPI_MODULE_NAME("processor_idle");
> #define C2_OVERHEAD			1	/* 1us */
> #define C3_OVERHEAD			1	/* 1us */
> 
>-module_param(max_cstate, uint, 0644);
>+void acpi_max_cstate_changed(void)
>+{
>+	int cpu;
>+	/* Driver will reset devices' max cstate limit */
>+	lock_cpu_hotplug();
>+	for_each_online_cpu(cpu)
>+		cpuidle_force_redetect(&per_cpu(cpuidle_devices, cpu));
>+	unlock_cpu_hotplug();
>+}

No hotplug lock in cpuidle please. Either we have to add a
force_allcpu_redetect function or we can use the previous patch.

Thanks,
Venki
