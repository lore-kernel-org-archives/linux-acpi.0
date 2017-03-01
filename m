From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 4/4] acpi: Move the verification of duplicate proc_id
 from booting time to hot-plug time
Date: Wed, 1 Mar 2017 12:26:36 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703011212450.4005@nanos>
References: <1487580471-17665-1-git-send-email-douly.fnst@cn.fujitsu.com> <1487580471-17665-5-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:39136 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbdCAL1S (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2017 06:27:18 -0500
In-Reply-To: <1487580471-17665-5-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: mingo@kernel.org, peterz@infradead.org, rjw@rjwysocki.net, hpa@zytor.com, rafael@kernel.org, cl@linux.com, tj@kernel.org, akpm@linux-foundation.org, rafael.j.wysocki@intel.com, len.brown@intel.com, izumi.taku@jp.fujitsu.com, xiaolong.ye@intel.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 20 Feb 2017, Dou Liyang wrote:

Please make your subject line short and a precise summary phrase, not an
overlong sentence.

> After we revert the the mapping of "cpuid <-> nodeid" fixed at the
> booting time. and do it at the hot-plug time. we should also do the
> verification of duplicate proc_id at the time.

The revert is completely irrelevant to this change, really. The reference
is just confusing.

> The patch rename the verfication function and move it to
> drivers/acpi::acpi_processor_get_info.

See previous mails ....

Let me give you another changelog example:

Subject: acpi/processor: Check for duplicate processor ids at hotplug time

  The check for duplicate processor ids happens at boot time based on the
  ACPI table contents, but the final sanity checks for a processor happen
  at hotplug time.

  At hotplug time, where the physical information is available, which might
  differ from the ACPI table information, a check for duplicate processor
  ids is missing.

  Add it to the hotplug checks and rename the function so it better
  reflects its purpose.

Hmm?

>  
> -bool __init acpi_processor_validate_proc_id(int proc_id)
> +bool duplicate_processor_id(int proc_id)

Please keep the acpi_ prefix. acpi_duplicate_processor_id().

Thanks,

	tglx
