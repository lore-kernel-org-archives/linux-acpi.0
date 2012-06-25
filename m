From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Fix not loading acpi-cpufreq driver regression
Date: Mon, 25 Jun 2012 13:20:47 +0200
Message-ID: <201206251320.47590.trenn@suse.de>
References: <201206251300.10957.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56819 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755873Ab2FYLUy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Jun 2012 07:20:54 -0400
In-Reply-To: <201206251300.10957.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, stable@vger.kernel.org, wallak@free.fr, len.brown@intel.com, Jiri Slaby <jslaby@suse.cz>

On Monday, June 25, 2012 01:00:10 PM Thomas Renninger wrote:
> ACPI processor: Only blindly return apic id 0 for real UP systems
> 
> This fixes a "not loading acpi-cpufreq driver" regression introduced
> by git commit d640113fe80e45ebd4a5b4 on SMP systems where the processor
> core with ACPI id zero is disabled
> (typically should be the case because of hyperthreading).
> The regression got spread through stable kernels.
> On 3.0.X it got introduced via 3.0.18.
> 
> Such platforms may be rare, but do exist. This problem has been
> observed on a:
> HP Proliant BL280c G6 blade
> This patch restricts the introduced workaround to platforms
> with nr_cpu_ids <= 1.

Wallak:
Can you give this patch a try and double check whether things still
work for you.
If I understand it correctly you tried a UP compiled kernel?
On this one I expect nr_cpu_ids to be statically set to 1 and the
patch should be fine for you.

The only other candidate I can think of which needs this,
are platforms with only 1 core available and no SMP APIC/ACPI mapping 
table, but a
Processor (...)
ACPI object.
Those should also still be covered with my patch.

Thanks,

   Thomas
