From: Tomi Sarvela <tomi.p.sarvela@intel.com>
Subject: Re: ILK ACPI boot-up problem on HP 8100 SFF, bisected
Date: Tue, 10 Jan 2017 10:46:50 +0200
Message-ID: <2128778.0qv3ye0GE3@fractal.fi.intel.com>
References: <2435796.hnfxsDQFWV@fractal.fi.intel.com> <CAJZ5v0hgZ575POz0hSmOJ+-0UKzk5j-zrhmaV9EF_QehFmFysw@mail.gmail.com> <CAJZ5v0gep_8_-Zdir93tav_gXjvhP0Of_EVaKBUrpu1+xRNqzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:9854 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751215AbdAJIra (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Jan 2017 03:47:30 -0500
In-Reply-To: <CAJZ5v0gep_8_-Zdir93tav_gXjvhP0Of_EVaKBUrpu1+xRNqzg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lv <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Monday, 9 January 2017 23:28:32 EET Rafael J. Wysocki wrote:
> On Mon, Jan 9, 2017 at 11:07 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Mon, Jan 9, 2017 at 5:01 PM, Tomi Sarvela <tomi.p.sarvela@intel.com> wrote:
> >> We have couple of Iron Lake machines here, and one started
> >> hanging around Christmas in early boot on ACPI initialization.
> >> Dmesg below, full dmesgs available on request.
> >> 
> >> Exact model of the machine is HP Compaq 8100 Elite Small Form
> >> Factor PC. BIOS update from 2010 to 2011 (newest) didn't change
> >> anything. HP Elite laptop (ILK m540) or Dell SFF PC (ILK 650)
> >> don't have this particular problem.
> >> 
> >> I've bisected the problem to the following commit:
> >> 
> >> ----
> >> commit 174cc7187e6f088942c8e74daa7baff7b44b33c9
> >> Author: Lv Zheng <lv.zheng@intel.com>
> >> Date:   Wed Dec 14 15:04:25 2016 +0800
> >> 
> >>     ACPICA: Tables: Back port acpi_get_table_with_size() and
> >>     early_acpi_os_unmap_memory() from Linux kernel
> >>     
> >>     ACPICA commit cac6790954d4d752a083e6122220b8a22febcd07
> >> 
> >> ----
> > Thanks for the report!
> > 
> > Does this patch make any difference:
> > https://patchwork.kernel.org/patch/9504277/ ?
> 
> Please also check this alternative patch from Paul:
> 
> https://patchwork.kernel.org/patch/9506033/

I've tested both patches on top of latest kernel head (separate tries, to make it clear).

Neither patch does any difference. In both cases kernel still hangs to the same spot in boot, and 5sec powerbutton or AC reboot is needed.

Best regards,

Tomi Sarvela





