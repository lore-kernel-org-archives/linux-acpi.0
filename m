From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Wed, 11 Jan 2017 01:51:56 -0800
Message-ID: <20170111095156.GR3800@linux.vnet.ibm.com>
References: <20170109221831.GC3800@linux.vnet.ibm.com>
 <20170109231501.xrhwsv46mznw3kqt@pd.tnic>
 <20170109233204.GG3800@linux.vnet.ibm.com>
 <20170109234039.mfefmv5dv4shxnfn@pd.tnic>
 <20170109235211.yetponvbexvalkir@pd.tnic>
 <CAJZ5v0gRYcC5fJZF207iyehvPR9_2zqprSvWHA_Qt93W9njqAw@mail.gmail.com>
 <20170110022338.GJ3800@linux.vnet.ibm.com>
 <1AE640813FDE7649BE1B193DEA596E886CE286C3@SHSMSX101.ccr.corp.intel.com>
 <20170110055129.GK3800@linux.vnet.ibm.com>
 <20170111092105.3y57tyeskpyjtmxi@pd.tnic>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756418AbdAKJwE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Jan 2017 04:52:04 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id v0B9muOD140680
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2017 04:52:03 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
        by mx0b-001b2d01.pphosted.com with ESMTP id 27wh7nb2jt-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2017 04:52:03 -0500
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-acpi@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jan 2017 02:52:02 -0700
Content-Disposition: inline
In-Reply-To: <20170111092105.3y57tyeskpyjtmxi@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, J?rg R?del <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Wed, Jan 11, 2017 at 10:21:06AM +0100, Borislav Petkov wrote:
> On Mon, Jan 09, 2017 at 09:51:29PM -0800, Paul E. McKenney wrote:
> > Definitely.
> 
> Btw, we have more breakage from RCU expedited using workqueues:
> https://bugzilla.kernel.org/show_bug.cgi?id=192111
> 
> I've added you to CC but let me have other bug reporters confirm reverting
> 
>   8b355e3bc140 ("rcu: Drive expedited grace periods from workqueue")
> 
> does fix the issue for them too.

Yes, you could make RCU expedited grace periods go back to using the
requesting task, and that would allow expedited grace periods to run early
in the boot process.  But that causes problems with signals and the like
unless you revert a few other patches.  The bugzilla is interesting --
it looks like ACPI was in some cases doing early-boot grace-period waits
some time back?

I have a limping prototype RCU patch that should avoid this problem.

If all goes well, I will send it out late tomorrow evening, Pacific Time.

							Thanx, Paul

