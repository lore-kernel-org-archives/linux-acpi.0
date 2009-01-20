From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Suspned/resume can't work on the 2.6.29-rc1 but it can work
	well on the 2.6.28
Date: Tue, 20 Jan 2009 08:45:34 +0100
Message-ID: <20090120074534.GE16426@elte.hu>
References: <1232413680.3971.32.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:45579 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220AbZATHpz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jan 2009 02:45:55 -0500
Content-Disposition: inline
In-Reply-To: <1232413680.3971.32.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org


* Zhao Yakui <yakui.zhao@intel.com> wrote:

> Hi, All
>     I do some tests about suspend/resume on my two boxes. One is HP
> laptop and the other is Asus EEEPC901. The suspend/resume can't work
> well. Even after core is selected as the test mode, it still can't work
> well.(echo core > /sys/power/pm_test)
>     
>     Then I do the same test by using the 2.6.28 kernel. And
> suspend/resume can work well.
>     
>     Of course I will try to use the git-bisect to identify the first bad 
> commit ASAP.

make sure you try this patch from Rafael first (it's not on lkml it 
appears - Rafael, mind resending the patch to this thread?):

Subject: [PATCH] PCI PM: Restore standard config registers of all devices early
        (was: Re: EeePC resume failure - timers)

	Ingo
