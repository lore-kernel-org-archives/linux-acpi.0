From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/5] ACPI / EC: Move the event handling out of the noirq stage
Date: Mon, 12 Sep 2016 23:59:57 +0200
Message-ID: <1572371.0aYBz9LIr7@vostro.rjw.lan>
References: <bd9df7ba491b33cfbaa46f4cc6a6325f74153e36.1469093001.git.lv.zheng@intel.com> <cover.1470205312.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1470205312.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, August 03, 2016 04:01:09 PM Lv Zheng wrote:
> There is a known issue in the EC driver.
> 
> 1. During the suspend/resume process, the EC driver is required to work
>    even in the noirq stage. And currently the event handling is
>    disabled/enabled in the noirq stage.
> 2. Unfortunately, the EC driver only implements the polling mode for
>    handling the transactions, and is not prepared to handle events in the
>    polling mode.
> The result of the above conflict is: if an SCI_EVT is indicated during the
> noirq stage (especially after resuming), the EC driver is not able to
> detect the SCI_EVT unless:
> 1. GPE STS not cleared: When the GPE is enabled, advance_transaction() will
>                         be invoked to poll SCI_EVT.
> 2. EC transaction occurred: When an EC transaction ocurred,
>                             advance_transaction() will be invoked in the
>                             polling mode.
> If an SCI_EVT ocurred during noirq stage and the above 2 triggering sources
> cannot handle it, then a problem could be seen by the users:
>  If SCI_EVT is left set after resuming and there is still no EC
>  transactions, this event cannot be handled.
> 
> This patchset tries to disable/enable the event handling out of the noirq
> stage to fix this issue.
> 
> Though it is always correct to enable the event handling in a later stage
> during resuming as long as the event won't be lost, it may not be correct
> to disable the event handling in an earlier stage during suspending. This
> patchset thus put a boot parameter for the suspending part tuning in order
> to be able to respond to the possible regressions.
> 
> Since the event handling is disabled for a longer period during
> suspend/resume, this patchset can also tune the suspend/resume speed
> faster.
> 
> Lv Zheng (5):
>   ACPI / EC: Add EC_FLAGS_QUERY_ENABLED to reveal a hidden logic
>   ACPI / EC: Fix an issue that SCI_EVT cannot be detected after event
>     is enabled
>   ACPI / EC: Add PM operations to improve event handling for resume
>     process
>   ACPI / EC: Add PM operations to improve event handling for suspend
>     process
>   ACPI / EC: Enable event freeze mode to improve event handling
>     efficiency for suspend process

Wholes series applied.

Thanks,
Rafael
