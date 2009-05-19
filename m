From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 1/2]cpuidle: makes AMD C1E works in acpi_idle
Date: Tue, 19 May 2009 23:09:08 +0800
Message-ID: <20090519150908.GA27513@sli10-desk.sh.intel.com>
References: <20090519080942.GA12117@sli10-desk.sh.intel.com> <alpine.LFD.2.00.0905191447490.5983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12045 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbZESPJK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 May 2009 11:09:10 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905191447490.5983@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "thisistempbox@yahoo.com" <thisistempbox@yahoo.com>, "mingo@redhat.com" <mingo@redhat.com>

On Tue, May 19, 2009 at 08:55:10PM +0800, Thomas Gleixner wrote:
> On Tue, 19 May 2009, Shaohua Li wrote:
> 
> > When AMD C1E is enabled, local APIC timer will stop even in C1. This patch uses
> > broadcast ipi to replace local APIC timer in C1.
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=13233
> 
> Hmm. This was addressed before in 
> 
> commit a8d6829044901a67732904be5f1eacdf8539604f (x86: prevent C-states
> hang on AMD C1E enabled machines)
> 
> We limit C-States to 1 via acpi_processor_cstate_check().
> 
> And we have the broadcast logic in c1e_idle() already. We also select
> c1e_idle as the idle routine, so why is the ACPI code not using this. ?
We used to call pm_idle_save() for C1, which will call c1e_idle. But this is
removed, guess the reason is we want to do C1 enter per the information gotten
from BIOS. So this bug is a regression actually. The patch follows the logic
of c1e_idle().

Thanks,
Shaohua
