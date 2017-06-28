From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] ACPI: EC: Fix an EC event IRQ storming issue
Date: Wed, 28 Jun 2017 23:23:05 +0200
Message-ID: <2567863.EKXPT4SnGi@aspire.rjw.lan>
References: <d8ac96c8fd988daec20f7a22a2acb3119ccd149b.1497418749.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58095 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751580AbdF1Vac (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Jun 2017 17:30:32 -0400
In-Reply-To: <d8ac96c8fd988daec20f7a22a2acb3119ccd149b.1497418749.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday, June 14, 2017 01:59:09 PM Lv Zheng wrote:
> The EC event IRQ (SCI_EVT) can only be handled by submitting QR_EC. As the
> EC driver handles SCI_EVT in a workqueue, after SCI_EVT is flagged and
> before QR_EC is submitted, there is a period risking IRQ storming. EC IRQ
> must be masked for this period but linux EC driver never does so.
> 
> No end user notices the IRQ storming and no developer fixes this known
> issue because:
> 1. the EC IRQ is always edge triggered GPE, and
> 2. the kernel can execute no-op EC IRQ handler very fast.
> For edge triggered EC GPE platforms, it is only reported of post-resume EC
> event lost issues, there won't be an IRQ storming. For level triggered EC
> GPE platforms, fortunately the kernel is always fast enough to execute such
> a no-op EC IRQ handler so that the IRQ handler won't be accumulated to
> starve the task contexts, causing a real IRQ storming.
> 
> But the IRQ storming actually can still happen when:
> 1. the EC IRQ performs like level triggered GPE, and
> 2. the kernel EC debugging log is turned on but the console is slow enough.
> There are more and more platforms using EC GPE as wake GPE where the EC GPE
> is likely designed as level triggered. Then when EC debugging log is
> enabled, the EC IRQ handler is no longer a no-op but dumps IRQ status to
> the consoles. If the consoles are slow enough, the EC IRQs can arrive much
> faster than executing the handler. Finally the accumulated EC event IRQ
> handlers starve the task contexts, causing the IRQ storming to occur, and
> the kernel hangs can be observed during boot/resume.
> 
> See link #1 for reference, however the bug link can only be accessed by
> priviledged Intel users.
> 
> This patch fixes this issue by masking EC IRQ for this period:
> 1. begins when there is an SCI_EVT IRQ pending, and
> 2. ends when there is a QR_EC completed (SCI_EVT acknowledged).
> 
> Link: https://jira01.devtools.intel.com/browse/LCK-4004 [#1]
> Tested-by: Wang Wendy <wendy.wang@intel.com>
> Tested-by: Feng Chenzhou <chenzhoux.feng@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

I've applied this and the [2/3], but I'm not sure about the [3/3].

I'll reply to that patch.

Thanks,
Rafael

