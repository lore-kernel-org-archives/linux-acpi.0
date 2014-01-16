From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY to
 enforce this ACPI mode
Date: Wed, 15 Jan 2014 19:17:48 -0700
Message-ID: <52D7414C.7080206@linaro.org>
References: <1389731822-21336-1-git-send-email-al.stone@linaro.org> <15081767.3kxW799CSQ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:48935 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbaAPCRv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2014 21:17:51 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so1954615pde.0
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jan 2014 18:17:51 -0800 (PST)
In-Reply-To: <15081767.3kxW799CSQ@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linaro-kernel@lists.linaro.org
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hanjun Guo <hanjun.guo@linaro.org>, patches@linaro.org, linaro-acpi@lists.linaro.org

On 01/14/2014 02:26 PM, Arnd Bergmann wrote:
> On Tuesday 14 January 2014 13:37:02 al.stone@linaro.org wrote:
>> +config ACPI_REDUCED_HARDWARE_ONLY
>> +       bool "Hardware-reduced ACPI support only"
>> +       def_bool n
>> +       depends on ACPI && EXPERT
>
> I think this will cause a Kconfig warning if you try to select this
> on ARM64 without turning on EXPERT as well.
>
> It should be ok if you express it as
>
> config ACPI_REDUCED_HARDWARE_ONLY
>         bool "Hardware-reduced ACPI support only" if EXPERT
>         def_bool n
>         depends on ACPI
>
>
> 	Arnd
>

I am very puzzled.  I went back and re-did my configs from
before, tried a few new ones, and tried with both expressions
above, but I could not get a Kconfig warning.  Do you have an
example .config that shows the warning?

Thanks.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
