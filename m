From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v7 1/2] Mailbox: Add support for Platform Communication Channel
Date: Tue, 16 Sep 2014 14:24:51 -0400
Message-ID: <CAJ5Y-eYBE9GjzzNETmAvLPsO8OjDw_7i3RX2K27GaKceBGQ1sQ@mail.gmail.com>
References: <1410369619-2570-1-git-send-email-ashwin.chaugule@linaro.org>
	<1410369619-2570-2-git-send-email-ashwin.chaugule@linaro.org>
	<CAJ5Y-eYNqV_J2q_HJkXvaw_9QfezZ1AZBB+rQkaLLwMnUH_WBA@mail.gmail.com>
	<20140913155734.GC7960@sirena.org.uk>
	<CAJ5Y-eYg5VUTKdgVHBQvdCUtQSqdxAszetxLc-KTf5MfLN=6eQ@mail.gmail.com>
	<1AE640813FDE7649BE1B193DEA596E8802671AF0@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:58890 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730AbaIPSYw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Sep 2014 14:24:52 -0400
Received: by mail-we0-f175.google.com with SMTP id w61so255809wes.34
        for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2014 11:24:51 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802671AF0@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>

Hi Lv,

On 16 September 2014 00:38, Zheng, Lv <lv.zheng@intel.com> wrote:

>
> It looks this line is still wrong:
> +       return ACPI_SUCCESS(status) ? -EINVAL : 0;
> You may need to run a test to validate the revised patch.

You're right, I should either use ACPI_FAILURE or swap -EINVAL and 0.

Cheers,
Ashwin
