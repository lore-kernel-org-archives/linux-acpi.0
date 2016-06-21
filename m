From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v4 1/5] ACPICA: Namespace: Fix a regression that MLC
 support triggers dead lock in dynamic table loading
Date: Tue, 21 Jun 2016 09:55:53 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BBF6352@SHSMSX101.ccr.corp.intel.com>
References: <0e65135af51d94db0410c7059f3bc3a2300fc3b5>
 <cover.1466479787.git.lv.zheng@intel.com>
 <6cce63a111c40ca70552b003ef5a70eb239afd6f.1466479787.git.lv.zheng@intel.com>
 <20160621075833.GU1739@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160621075833.GU1739@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi, Mika

> From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> Subject: Re: [PATCH v4 1/5] ACPICA: Namespace: Fix a regression that MLC
> support triggers dead lock in dynamic table loading
> 
> On Tue, Jun 21, 2016 at 12:34:15PM +0800, Lv Zheng wrote:
> > The new MLC approach invokes MLC per-table basis. But the dynamic
> loading
> > support of this is incorrect because of the lock order:
> >  acpi_ns_evaluate
> >    acpi_ex_enter_intperter
> >      acpi_ns_load_table (triggered by Load opcode)
> >        acpi_ns_exec_module_code_list
> >          acpi_ex_enter_intperter
> > The regression is introduced by the following commit:
> >   Commit: 2785ce8d0da1cac9d8f78615e116cf929e9a9123
> >   ACPICA Commit: 071eff738c59eda1792ac24b3b688b61691d7e7c
> >   Subject: ACPICA: Add per-table execution of module-level code
> > This patch fixes this regression by unlocking the interpreter lock before
> > invoking MLC. However the unlocking is done to the
> acpi_ns_load_table(), in
> > which, the interpreter lock should be locked by acpi_ns_parse_table()
> but
> > wasn't. Reported by Mika Westerberg. Fixed by Lv Zheng.
> >
> > Fixes: 2785ce8d0da1 ("ACPICA: Add per-table execution of module-level
> code")
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Now builds fine and fixes the hang, thanks :)
> 
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
[Lv Zheng] 
Great! :)
I'll leave the SOB correction for Rafael in order not to bother others by re-sending an update.

Thanks and best regards
-Lv
