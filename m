From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: 2.6.27-rc8: throttling broken
Date: Fri, 10 Oct 2008 09:12:05 +0800
Message-ID: <1223601125.3990.4.camel@yakui_zhao.sh.intel.com>
References: <20081009171238.GB1370@ucw.cz>  <200810092327.26301.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35467 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753623AbYJJBGX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2008 21:06:23 -0400
In-Reply-To: <200810092327.26301.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, jikos@suse.cz, kernel list <linux-kernel@vger.kernel.org>, linux-acpi@ucw.cz, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, 2008-10-09 at 23:27 +0200, Rafael J. Wysocki wrote:
> On Thursday, 9 of October 2008, Pavel Machek wrote:
> > Hi!
> > 
> > On 2.6.27-rc8 on via/fic subnotebook, throttling seems to be broken. I
> > can do echo 15 > /proc/acpi/processor/*/throttling, and proc file
> > reflects new value, but cpu still runs at same speed.
> > 
> > It worked on opensuse11/sled10 kernels at least...
After echo 15 > /proc/acpi/processor/*/throttling, what T-state is
displayed by cat /proc/acpi/processor/*/throttling?

If you do the above test on the 2.6.26.x kernel, what T-state is
displayed ?
Thanks.
> 
> Any chance to check 2.6.26.x on that?
> 
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

