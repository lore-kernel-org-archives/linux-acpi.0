From: Borislav Petkov <bp@alien8.de>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Wed, 11 Jan 2017 10:21:06 +0100
Message-ID: <20170111092105.3y57tyeskpyjtmxi@pd.tnic>
References: <20170109093329.jd7uwlcpci4icpd3@pd.tnic>
 <20170109221831.GC3800@linux.vnet.ibm.com>
 <20170109231501.xrhwsv46mznw3kqt@pd.tnic>
 <20170109233204.GG3800@linux.vnet.ibm.com>
 <20170109234039.mfefmv5dv4shxnfn@pd.tnic>
 <20170109235211.yetponvbexvalkir@pd.tnic>
 <CAJZ5v0gRYcC5fJZF207iyehvPR9_2zqprSvWHA_Qt93W9njqAw@mail.gmail.com>
 <20170110022338.GJ3800@linux.vnet.ibm.com>
 <1AE640813FDE7649BE1B193DEA596E886CE286C3@SHSMSX101.ccr.corp.intel.com>
 <20170110055129.GK3800@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170110055129.GK3800@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, J?rg R?del <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 09, 2017 at 09:51:29PM -0800, Paul E. McKenney wrote:
> Definitely.

Btw, we have more breakage from RCU expedited using workqueues:
https://bugzilla.kernel.org/show_bug.cgi?id=192111

I've added you to CC but let me have other bug reporters confirm reverting

  8b355e3bc140 ("rcu: Drive expedited grace periods from workqueue")

does fix the issue for them too.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
