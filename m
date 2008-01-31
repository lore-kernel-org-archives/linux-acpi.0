From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
Date: Thu, 31 Jan 2008 10:44:48 -0800
Message-ID: <924EFEDD5F540B4284297C4DC59F3DEE7202A0@orsmsx423.amr.corp.intel.com>
References: <200801301116.44902.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8166 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422AbYAaSoV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jan 2008 13:44:21 -0500
Content-class: urn:content-classes:message
In-Reply-To: <200801301116.44902.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kevin Hilman <khilman@mvista.com>

 

>-----Original Message-----
>From: Rafael J. Wysocki [mailto:rjw@sisk.pl] 
>Sent: Wednesday, January 30, 2008 2:17 AM
>To: Len Brown
>Cc: ACPI Devel Maling List; Pallipadi, Venkatesh; Kevin Hilman
>Subject: Fwd: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
>
>Hi,
>
>Please have a look at this.
>
>Rafael
>
> 
> Wrap cpu_idle_wait() in an x86 #ifdef since it's x86 only.
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index d2fabe7..4d0f9b0 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -82,7 +82,9 @@ void cpuidle_uninstall_idle_handler(void)
>  {
>  	if (enabled_devices && (pm_idle != pm_idle_old)) {
>  		pm_idle = pm_idle_old;
> +#ifdef CONFIG_X86
>  		cpu_idle_wait();
> +#endif
> 

The archs that do not have cpu_idle_wait() and has more than one CPU
will need something equivalent to cpu_idle_wait() to kick all other CPUs
out of idle loop.
The reason being we do not want another CPU to be in idle loop that is
being uninstalled here.

Do you have more than one logical CPU on your platform?

Thanks,
Venki
