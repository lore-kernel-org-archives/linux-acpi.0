From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [PATCH 0/7] APEI: Make APEI architecture independent.
Date: Mon, 05 May 2014 11:25:57 +0200
Message-ID: <53675925.4030203@linaro.org>
References: <1397056476-9183-1-git-send-email-tomasz.nowicki@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:57046 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723AbaEEJZn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 May 2014 05:25:43 -0400
Received: by mail-ee0-f54.google.com with SMTP id b57so3270944eek.13
        for <linux-acpi@vger.kernel.org>; Mon, 05 May 2014 02:25:42 -0700 (PDT)
In-Reply-To: <1397056476-9183-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de, bp@suse.de, m.chehab@samsung.com
Cc: linux-edac@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

Hi,

I would like to kindly remind and request for some comments on this patches.

Regards,
Tomasz

On 09.04.2014 17:14, Tomasz Nowicki wrote:
> APEI is currently implemented so that it depends on x86 hardware.
> The primary dependency is that GHES uses the x86 NMI for hardware
> error notification. These patches remove that dependency.
>
> Other APEI features such as error reporting via external IRQ, error
> serialization, or error injection, do not require changes to use them
> on non-x86 architectures.
>
> The following patch set eliminates the APEI Kconfig x86 dependency
> by making these changes:
> - replace arch specific calls with more generic one
> - treat NMI notification as GHES feature - CONFIG_ACPI_APEI_NMI
> - isolate NMI related code
> - reorganize function logic
>
> NMI code is kept in ghes.c file since NMI and IRQ context are tightly coupled.
>
> Note, these patches introduce no functional changes for x86. The NMI notification
> feature is selected for x86 by default. Architectures that want to use this
> feature should also provide NMI code infrastructure.
>
> Tomasz Nowicki (7):
>    apei, mce: Call MCE-specific code only for X86 architecture.
>    acpi, apei, ghes: Introduce more generic mechanism to init/deinit
>      GHES error notifications.
>    ACPI, APEI, GHES: Introduce ACPI_NMI to make NMI error notification a
>      GHES feature.
>    acpi, apei, ghes: Factor out NMI error notification context.
>    acpi, apei, ghes: Attach NMI init/deinit functions while
>      CONFIG_ACPI_NMI is enabled.
>    acpi, apei, ghes: Make unmapping functionality independent from
>      architecture.
>    acpi, apei, ghes: Factor out ioremap virtual memory for IRQ and NMI
>      context.
>
>   drivers/acpi/apei/Kconfig |   10 +-
>   drivers/acpi/apei/ghes.c  |  329 ++++++++++++++++++++++++++++-----------------
>   drivers/acpi/apei/hest.c  |    8 +-
>   3 files changed, 218 insertions(+), 129 deletions(-)
>
