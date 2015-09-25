From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
Date: Fri, 25 Sep 2015 14:44:38 -0700
Message-ID: <20150925214438.GH5951@linux>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <4357538.Wlf88yQie6@vostro.rjw.lan>
 <CAKohpok2Z2m7GZt1GzZzofeHEioF=XJEq8YVgtY=VtS9tmpb_Q@mail.gmail.com>
 <2524822.pQu4UKMrlb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34179 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbbIYVol (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2015 17:44:41 -0400
Received: by padhy16 with SMTP id hy16so116521328pad.1
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2015 14:44:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2524822.pQu4UKMrlb@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Johannes Berg <johannes@sipsolutions.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, QCA ath9k Development <ath9k-devel@qca.qualcomm.com>, Intel Linux Wireless <ilw@linux.intel.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>, "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>, "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb@vger.kernel.org>

On 25-09-15, 22:58, Rafael J. Wysocki wrote:
> Say you have three adjacent fields in a structure, x, y, z, each one byte long.
> Initially, all of them are equal to 0.
> 
> CPU A writes 1 to x and CPU B writes 2 to y at the same time.
> 
> What's the result?

But then two CPUs can update the same variable as well, and we must
have proper locking in place to fix that.

Anyway, that problem isn't here for sure as its between two
unsigned-longs. So, should I just move it to bool and resend ?

-- 
viresh
