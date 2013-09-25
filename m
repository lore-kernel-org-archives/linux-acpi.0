From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v2 4/4] hotplug, powerpc, x86: Remove
 cpu_hotplug_driver_lock()
Date: Wed, 25 Sep 2013 14:44:59 -0600
Message-ID: <1380141899.14046.18.camel@misato.fc.hp.com>
References: <1377822129-4143-1-git-send-email-toshi.kani@hp.com>
	 <1377822129-4143-5-git-send-email-toshi.kani@hp.com>
	 <7232059.d6LGFPRAoP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:28201 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362Ab3IYUrA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Sep 2013 16:47:00 -0400
In-Reply-To: <7232059.d6LGFPRAoP@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "hpa@linux.intel.com" <hpa@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nfont@linux.vnet.ibm.com" <nfont@linux.vnet.ibm.com>, "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "bp@suse.de" <bp@suse.de>, "srivatsa.bhat@linux.vnet.ibm.com" <srivatsa.bhat@linux.vnet.ibm.com>, "isimatu.yasuaki@jp.fujitsu.com" <isimatu.yasuaki@jp.fujitsu.com>

On Wed, 2013-09-25 at 08:27 +0000, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thursday, August 29, 2013 06:22:09 PM Toshi Kani wrote:
> > cpu_hotplug_driver_lock() serializes CPU online/offline operations
> > when ARCH_CPU_PROBE_RELEASE is set.  This lock interface is no longer
> > necessary with the following reason:
> > 
> >  - lock_device_hotplug() now protects CPU online/offline operations,
> >    including the probe & release interfaces enabled by
> >    ARCH_CPU_PROBE_RELEASE.  The use of cpu_hotplug_driver_lock() is
> >    redundant.
> >  - cpu_hotplug_driver_lock() is only valid when ARCH_CPU_PROBE_RELEASE
> >    is defined, which is misleading and is only enabled on powerpc.
> > 
> > This patch removes the cpu_hotplug_driver_lock() interface.  As
> > a result, ARCH_CPU_PROBE_RELEASE only enables / disables the cpu
> > probe & release interface as intended.  There is no functional change
> > in this patch.
> > 
> > Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> 
> Can you please rebase this patch on top of 3.12-rc2?  It doesn't apply for
> me any more.

Yes, I will send this patch on top of 3.12-rc2.

Thanks,
-Toshi

