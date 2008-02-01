From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
Date: Fri, 1 Feb 2008 02:17:18 +0100
Message-ID: <200802010217.18639.rjw@sisk.pl>
References: <200801301116.44902.rjw@sisk.pl> <87myql7k8p.fsf@paris.hilman.org> <924EFEDD5F540B4284297C4DC59F3DEE720540@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56274 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434AbYBABTh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jan 2008 20:19:37 -0500
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEE720540@orsmsx423.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Kevin Hilman <khilman@mvista.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Friday, 1 of February 2008, Pallipadi, Venkatesh wrote:
> 
> >-----Original Message-----
> >From: Kevin Hilman [mailto:khilman@mvista.com] 
> >Sent: Thursday, January 31, 2008 1:34 PM
> >To: Rafael J. Wysocki
> >Cc: Pallipadi, Venkatesh; Len Brown; ACPI Devel Maling List
> >Subject: Re: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
> >
> >[ Another update based on Rafael's suggestions. ]
> >
> >Convert cpu_idle_wait() to cpuidle_kick_cpus() macro which is
> >SMP-only, and gives error on non supported CPU.
> >
> >Signed-off-by: Kevin Hilman <khilman@mvista.com>
> >
> >diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >index 80b7ba4..a3e8ef4 100644
> >--- a/arch/x86/Kconfig
> >+++ b/arch/x86/Kconfig
> >@@ -105,6 +105,9 @@ config ARCH_HAS_ILOG2_U32
> > config ARCH_HAS_ILOG2_U64
> > 	def_bool n
> > 
> >+config ARCH_HAS_CPU_IDLE_WAIT
> >+	def_bool y
> >+
> > config GENERIC_CALIBRATE_DELAY
> > 	def_bool y
> > 
> >diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> >index d2fabe7..794962d 100644
> >--- a/drivers/cpuidle/cpuidle.c
> >+++ b/drivers/cpuidle/cpuidle.c
> >@@ -82,7 +82,7 @@ void cpuidle_uninstall_idle_handler(void)
> > {
> > 	if (enabled_devices && (pm_idle != pm_idle_old)) {
> > 		pm_idle = pm_idle_old;
> >-		cpu_idle_wait();
> >+		cpuidle_kick_cpus();
> > 	}
> > }
> > 
> >diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> >index c4e0016..23f063a 100644
> >--- a/include/linux/cpuidle.h
> >+++ b/include/linux/cpuidle.h
> >@@ -72,6 +72,19 @@ cpuidle_set_statedata(struct cpuidle_state 
> >*state, void *data)
> > 	state->driver_data = data;
> > }
> > 
> >+#ifdef CONFIG_SMP
> >+#ifdef ARCH_HAS_CPU_IDLE_WAIT
> 
> You will have to do this one more time :-(.
> This has to be CONFIG_ARCH_HAS_CPU_IDLE_WAIT instead of
> ARCH_HAS_CPU_IDLE_WAIT here.

That's correct.  My fault actually, sorry.

Thanks,
Rafael
