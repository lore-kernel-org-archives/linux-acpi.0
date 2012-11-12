From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V5 2/2] Thermal: Add ST-Ericsson DB8500 thermal properties
 and platform data.
Date: Mon, 12 Nov 2012 21:46:03 +0100
Message-ID: <CACRpkdb-C-z1bWA2+xbuGt8TKSWRaD2xYUKS4M=KNMO0mOKF2g@mail.gmail.com>
References: <1352460548-3494-1-git-send-email-hongbo.zhang@linaro.com>
	<1352460548-3494-3-git-send-email-hongbo.zhang@linaro.com>
	<1352700425.1834.11.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:42495 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab2KLUqG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Nov 2012 15:46:06 -0500
Received: by mail-ea0-f174.google.com with SMTP id o11so413758eaa.19
        for <linux-acpi@vger.kernel.org>; Mon, 12 Nov 2012 12:46:03 -0800 (PST)
In-Reply-To: <1352700425.1834.11.camel@rzhang1-mobl4>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "hongbo.zhang" <hongbo.zhang@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, amit.kachhap@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, linaro-kernel@lists.linaro.org, STEricsson_nomadik_linux@list.st.com, kernel@igloocommunity.org, "hongbo.zhang" <hongbo.zhang@linaro.com>

On Mon, Nov 12, 2012 at 7:07 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Fri, 2012-11-09 at 19:29 +0800, hongbo.zhang wrote:
>> From: "hongbo.zhang" <hongbo.zhang@linaro.com>
>>
>> This patch adds device tree properties for ST-Ericsson DB8500 thermal driver,
>> also adds the platform data to support the old fashion.
>>
>> Signed-off-by: hongbo.zhang <hongbo.zhang@linaro.com>
>> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> hmmm,
>
> who should take this patch?
> I'd like to see ACK from the maintainer of these code before applying
> them to thermal tree.

I guess it needs to go through Thermal.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Let's hope it's not creating too much conflict...

Yours,
Linus Walleij
