From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 0/4] Unify CPU hotplug lock interface
Date: Fri, 30 Aug 2013 14:14:38 +0200
Message-ID: <4448049.EdPFQ3JMc0@vostro.rjw.lan>
References: <1377822129-4143-1-git-send-email-toshi.kani@hp.com> <522006F6.2060206@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:44683 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537Ab3H3MDz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Aug 2013 08:03:55 -0400
In-Reply-To: <522006F6.2060206@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: Toshi Kani <toshi.kani@hp.com>, mingo@redhat.com, hpa@linux.intel.com, tglx@linutronix.de, gregkh@linuxfoundation.org, benh@kernel.crashing.org, linux-acpi@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, nfont@linux.vnet.ibm.com, fenghua.yu@intel.com, bp@suse.de, srivatsa.bhat@linux.vnet.ibm.com

On Friday, August 30, 2013 11:44:06 AM Yasuaki Ishimatsu wrote:
> (2013/08/30 9:22), Toshi Kani wrote:
> > lock_device_hotplug() was recently introduced to serialize CPU & Memory
> > online/offline and hotplug operations, along with sysfs online interface
> > restructure (commit 4f3549d7).  With this new locking scheme,
> > cpu_hotplug_driver_lock() is redundant and is no longer necessary.
> > 
> > This patchset makes sure that lock_device_hotplug() covers all CPU online/
> > offline interfaces, and then removes cpu_hotplug_driver_lock().
> > 
> > v2:
> >   - Rebased to the pm tree, bleeding-edge.
> >   - Changed patch 2/4 to use lock_device_hotplug_sysfs().
> > 
> > ---
> > Toshi Kani (4):
> >    hotplug, x86: Fix online state in cpu0 debug interface
> >    hotplug, x86: Add hotplug lock to missing places
> >    hotplug, x86: Disable ARCH_CPU_PROBE_RELEASE on x86
> >    hotplug, powerpc, x86: Remove cpu_hotplug_driver_lock()
> > 
> > ---
> The patch-set looks good to me.
> 
> Acked-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks!  I'll tentatively queue up this series for 3.12 (for the second
half of the merge window).

Thanks,
Rafael

