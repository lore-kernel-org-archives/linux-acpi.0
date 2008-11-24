From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Regression: ACPI AC driver doesn't work on Toshiba Portege
	R500 (bisected)
Date: Mon, 24 Nov 2008 09:15:40 +0800
Message-ID: <1227489340.3991.54.camel@yakui_zhao.sh.intel.com>
References: <200811230053.14211.rjw@sisk.pl>
	 <200811240037.15835.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12466 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbYKXBI0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Nov 2008 20:08:26 -0500
In-Reply-To: <200811240037.15835.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, walken <walken@zoy.org>

On Mon, 2008-11-24 at 07:37 +0800, Rafael J. Wysocki wrote:
> On Sunday, 23 of November 2008, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > With current mainline (2.6.28-rc6-git1 as of today) on Toshiba Portege R500 the
> > status of the AC adapter is not updated when the adapter is unplugged and
> > plugged in.  Evidently, /sys/class/power_supply/ADP1/online always contains the
> > same value.  Interestingly enough, though, if the box is suspended to RAM and
> > resumed, the status of the AC adapter is correctly updated, but the value read
> > at that time remains in /sys/class/power_supply/ADP1/online until the next
> > suspend/resume cycle regardless of what's going on with the AC adapter.
> > 
> > 2.6.27.7 works correctly on this box so the recent EC patches don't seem to
> > cause this regression to happen.
> > 
> > Any other ideas?
Hi, Rafael
    Will you please open a new bug at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI and attach the
output of acpidump, dmesg, lspci -vxxx?
    If no ACPI event is reported when AC adapter is unplugged and
plugged, the /sys/class interface can't display the correct AC status.
Now Rui is working on this issue and the patch is already finished. But
it is not sent to Lenb.

    From the problem description it seems that the problem is related
with the AC driver. But from the git-bisect it seems that the problem is
related with the button driver(Fix power button device). 

    Any-way, please attach the output of dmesg, acpidump, lspci -vxxx.

Thanks.
> 
> The problem was introduced by the following commit:
> 
> commit faee816b1502385dc9bc5abf2960d1cc645844d1
> Author: Zhang Rui <rui.zhang@intel.com>
> Date:   Fri Sep 12 11:12:25 2008 +0800
> 
>     ACPI: don't enable control method power button as wakeup device when Fixed Power button is used
> 
>     don't enable control method power button as wakeup device
>     when Fixed Power button is used.
> 
>     http://bugzilla.kernel.org/show_bug.cgi?id=10503
> 
>     Tested-by: walken@zoy.org <walken@zoy.org>
>     Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> Reverting this commit on top of the current mainline makes the kernel behave
> correctly again.
> 
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

