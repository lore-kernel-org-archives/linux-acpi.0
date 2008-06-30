From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: RTC or button wakeup
Date: Mon, 30 Jun 2008 09:06:59 +0800
Message-ID: <1214788019.26947.2.camel@yakui_zhao.sh.intel.com>
References: <4867B402.2070104@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25349 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbYF3Azk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Jun 2008 20:55:40 -0400
In-Reply-To: <4867B402.2070104@tiscali.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Enno Fennema <e.fennema@tiscali.nl>
Cc: linux-acpi@vger.kernel.org

On Sun, 2008-06-29 at 18:10 +0200, Enno Fennema wrote:
> Could anyone suggest a way to determine in a (shell) program whether my 
> computer was switched on by RTC alarm or by me pressing the power button.
> 
> Normally RTC wakes my computer every evening to do daily routine work 
> and switches back to soft-off thereafter. If I switched on my computer 
> manually and am working on it it should not switch off. My best, but 
> clumsy, effort is at the end of the daily work comparing boot time and 
> login times.
Will you please try the following commit and see whether the problem
still exists?

commit e1094bfa26e5e94af2fea79e004614dbce42b008
Author: Zhao Yakui <yakui.zhao@intel.com>
Date:   Wed May 14 11:32:59 2008 +0800

    ACPI: Disable Fixed_RTC event when installing RTC handler

In fact the commit is already merged into upstream kernel. Will you
please try the latest kernel(2.6.26-rc7)?
Thanks.

> 
> Thanks in advance,
> Enno
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

