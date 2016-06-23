From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/5] ACPICA: Namespace: Fix a regression that MLC support triggers dead lock in dynamic table loading
Date: Thu, 23 Jun 2016 02:41:07 +0200
Message-ID: <3048231.eY7WrjAFBo@vostro.rjw.lan>
References: <1AE640813FDE7649BE1B193DEA596E883BBF6352@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49860 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750838AbcFWAgs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jun 2016 20:36:48 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBF6352@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday, June 21, 2016 09:55:53 AM Zheng, Lv wrote:
> Hi, Mika
> 
> > From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> > Subject: Re: [PATCH v4 1/5] ACPICA: Namespace: Fix a regression that MLC
> > support triggers dead lock in dynamic table loading
> > 
> > On Tue, Jun 21, 2016 at 12:34:15PM +0800, Lv Zheng wrote:
> > > The new MLC approach invokes MLC per-table basis. But the dynamic
> > loading
> > > support of this is incorrect because of the lock order:
> > >  acpi_ns_evaluate
> > >    acpi_ex_enter_intperter
> > >      acpi_ns_load_table (triggered by Load opcode)
> > >        acpi_ns_exec_module_code_list
> > >          acpi_ex_enter_intperter
> > > The regression is introduced by the following commit:
> > >   Commit: 2785ce8d0da1cac9d8f78615e116cf929e9a9123
> > >   ACPICA Commit: 071eff738c59eda1792ac24b3b688b61691d7e7c
> > >   Subject: ACPICA: Add per-table execution of module-level code
> > > This patch fixes this regression by unlocking the interpreter lock before
> > > invoking MLC. However the unlocking is done to the
> > acpi_ns_load_table(), in
> > > which, the interpreter lock should be locked by acpi_ns_parse_table()
> > but
> > > wasn't. Reported by Mika Westerberg. Fixed by Lv Zheng.
> > >
> > > Fixes: 2785ce8d0da1 ("ACPICA: Add per-table execution of module-level
> > code")
> > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > Now builds fine and fixes the hang, thanks :)
> > 
> > Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> [Lv Zheng] 
> Great! :)
> I'll leave the SOB correction for Rafael in order not to bother others by re-sending an update.

Applied (with tags), thanks!

