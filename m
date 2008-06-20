From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: [bug, acpi] BUG: spinlock bad magic on CPU#0, swapper/1, ACPI Exception (utmutex-0263): AE_BAD_PARAMETER
Date: Fri, 20 Jun 2008 15:11:04 +0200
Message-ID: <19f34abd0806200611m27746adao40454f420dfef31b@mail.gmail.com>
References: <20080620095247.GA24557@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:7611 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850AbYFTNLF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 09:11:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5662447rvb.1
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jun 2008 06:11:04 -0700 (PDT)
In-Reply-To: <20080620095247.GA24557@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>, Yinghai Lu <yhlu.kernel@gmail.com>

Hi,

On Fri, Jun 20, 2008 at 11:52 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> -tip auto-testing started triggering this spinlock corruption message
> yesterday:
>
> [    3.976213] calling  acpi_rtc_init+0x0/0xd3
> [    3.980213] ACPI Exception (utmutex-0263): AE_BAD_PARAMETER, Thread F7C50000 could not acquire Mutex [3] [20080321]

...

> i have found the AE_BAD_PARAMETER in older logs a well, but the spinlock
> corruption is new and nothing in that area is changed by -tip so i
> suspect it's a mainline problem as well.

It seems that some acpi calls are made before acpi is even
initialized, hence the AE_BAD_PARAMETER (ACPI is trying to use
uninitialized mutexes) -- I think that may be the source of the mutex
corruption as well.

This probably happens because acpi_early_init() (which happens before
all the initcalls; mutex initialization too) returns early:

void __init acpi_early_init(void)
{
        acpi_status status = AE_OK;

        if (acpi_disabled)
                return;
...

I notice that you're booting with acpi=off, so it might be the same
problem. You could try this patch to find other callers that don't
check whether ACPI is available before using ACPI-defined mutexes:

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 235a138..5b34328 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -818,8 +818,7 @@ acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 u
        long jiffies;
        int ret = 0;

-       if (!sem || (units < 1))
-               return AE_BAD_PARAMETER;
+       BUG_ON(!sem || (units < 1));

        if (units > 1)
                return AE_SUPPORT;

(This will dump the stack instead of printing AE_BAD_PARAMETER in your
dmesg, so this is guaranteed to halt your machine given that you have
at least three of these messages in your log already!)


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
