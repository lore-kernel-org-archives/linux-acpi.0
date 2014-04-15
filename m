From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 5/5] acpi_processor: do not mark present at boot but not onlined CPU as onlined
Date: Tue, 15 Apr 2014 07:36:59 +0200
Message-ID: <2222668.lTbDVCqpmz@vostro.rjw.lan>
References: <1397150061-29735-1-git-send-email-imammedo@redhat.com> <1397150061-29735-6-git-send-email-imammedo@redhat.com> <20140414092147.GD19771@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51532 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751157AbaDOFUw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Apr 2014 01:20:52 -0400
In-Reply-To: <20140414092147.GD19771@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, bp@suse.de, paul.gortmaker@windriver.com, JBeulich@suse.com, prarit@redhat.com, drjones@redhat.com, toshi.kani@hp.com, riel@redhat.com, gong.chen@linux.intel.com, andi@firstfloor.org, lenb@kernel.org, linux-acpi@vger.kernel.org

On Monday, April 14, 2014 11:21:47 AM Ingo Molnar wrote:
> 
> * Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > acpi_processor_add() assumes that present at boot CPUs
> > are always onlined, it is not so if a CPU failed to become
> > onlined. As result acpi_processor_add() will mark such CPU
> > device as onlined in sysfs and following attempts to
> > online/offline it using /sys/device/system/cpu/cpuX/online
> > attribute will fail.
> > 
> > Do not poke into device internals in acpi_processor_add()
> > and touch "struct device { .offline }" attribute, since
> > for CPUs onlined at boot it's set by:
> >   topology_init() -> arch_register_cpu() -> register_cpu()
> > before ACPI device tree is parsed, and for hotplugged
> > CPUs it's set when userspace onlines CPU via sysfs.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  drivers/acpi/acpi_processor.c |    3 ---
> >  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> Can this fix be moved first too, or does it have undesirable side 
> effects on unmodified kernels?

This patch is not correct.

Rafael

