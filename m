From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [PATCH] acpi cpuidle driver should handle max_cstate
Date: Mon, 2 Apr 2007 09:44:23 -0700
Message-ID: <653FFBB4508B9042B5D43DC9E18836F52DFD10@scsmsx415.amr.corp.intel.com>
References: <1175503064.22290.5.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11137 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933215AbXDBQo0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Apr 2007 12:44:26 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1175503064.22290.5.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Shaohua" <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, Adam Belay <abelay@novell.com>

 

>-----Original Message-----
>From: Li, Shaohua 
>Sent: Monday, April 02, 2007 1:38 AM
>To: linux acpi
>Cc: Brown, Len; Adam Belay; Pallipadi, Venkatesh
>Subject: [PATCH] acpi cpuidle driver should handle max_cstate
>
>After switching to cpuidle framework, acpi driver ingorned max_cstate,
>which will break ipw driver. Below patch fixed the issue. It's a little
>complicated, but this really should be handled in the driver instead of
>cpuidle core. If you have better fix, please speak.
>
>Signed-off-by: Shaohua Li <shaohua.li@intel.com>
>
> 
>-module_param(max_cstate, uint, 0644);
>+void acpi_max_cstate_changed(void)
>+{
>+	/* Driver will reset devices' max cstate limit */
>+	cpuidle_unregister_driver(&acpi_idle_driver);
>+	cpuidle_register_driver(&acpi_idle_driver);
>+}

Will a redetect work instead of unregister/register.

Thanks,
Venki
