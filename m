From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2]cpuidle: makes AMD C1E works in acpi_idle
Date: Tue, 19 May 2009 14:55:10 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0905191447490.5983@localhost.localdomain>
References: <20090519080942.GA12117@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753133AbZESM4o@vger.kernel.org>
In-Reply-To: <20090519080942.GA12117@sli10-desk.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, thisistempbox@yahoo.com, mingo@redhat.com
List-Id: linux-acpi@vger.kernel.org

On Tue, 19 May 2009, Shaohua Li wrote:

> When AMD C1E is enabled, local APIC timer will stop even in C1. This patch uses
> broadcast ipi to replace local APIC timer in C1.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=13233

Hmm. This was addressed before in 

commit a8d6829044901a67732904be5f1eacdf8539604f (x86: prevent C-states
hang on AMD C1E enabled machines)

We limit C-States to 1 via acpi_processor_cstate_check().

And we have the broadcast logic in c1e_idle() already. We also select
c1e_idle as the idle routine, so why is the ACPI code not using this. ?

Thanks,

	tglx
