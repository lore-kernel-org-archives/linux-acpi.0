From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v6 1/2] ACPI: Add early console framework for DBGP/DBG2.
Date: Wed, 10 Oct 2012 23:39:19 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88B9CCEC@SHSMSX101.ccr.corp.intel.com>
References: <cover.1348652044.git.lv.zheng@intel.com>
 <09ee0e9c79c57da2fc9d0af1c2daeaacdc0bb234.1349838218.git.lv.zheng@intel.com>
 <20121010141057.GF4005@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29733 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756850Ab2JJXjX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2012 19:39:23 -0400
In-Reply-To: <20121010141057.GF4005@phenom.dumpdata.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad@kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jason Wessel <jason.wessel@windriver.com>, "Tang, Feng" <feng.tang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>

> > +static __initdata DECLARE_BITMAP(acpi_early_flags,
> > +MAX_ACPI_DBG_PORTS*2);

It's OK since the keep bit will be derived by the real earlycon drivers in the __acpi_early_console_start() which is an arch specific interface.
You can find this usage in the [PATCH v6 2/2].

> > +	set_bit(port, acpi_early_flags);
> > +	if (keep)
> > +		set_bit(port+MAX_ACPI_DBG_PORTS, acpi_early_flags);
> Put a comment explaining why you use half of the bitmap to mark them as
> 'keep'. Thought wouldn't be just easier if you had another bitmap:
> acpi_keep_ports?
> To set those instead of using this bitmap?

I prefer to put comment here.
I've been a deep embedded engineer for the last 5 years, implementing software containing 4 bus protocol stacks within 128bytes ram and 16kbytes rom, where we used high modularity design patterns.
Thus made my habit being critical to ram/rom consumption...

I'm OOO now, the updated version will be sent next week.

Thanks for your comments and best regards/Lv Zheng
