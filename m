From: Rob Herring <robherring2@gmail.com>
Subject: Re: [Linaro-acpi] [PATCH v3 1/5] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE
 to enable this ACPI mode
Date: Tue, 10 Dec 2013 20:06:08 -0600
Message-ID: <CAL_JsqK1EJbNud2Pxojso=Vjo9ePEuwi3OUcwoCiwCpKH24LgA@mail.gmail.com>
References: <1386192127-28564-1-git-send-email-al.stone@linaro.org>
	<52A72D9F.1070004@linaro.org>
	<20131210224912.996FCC40CE1@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:49307 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab3LKCGJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2013 21:06:09 -0500
Received: by mail-ve0-f178.google.com with SMTP id c14so5489535vea.37
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2013 18:06:09 -0800 (PST)
In-Reply-To: <20131210224912.996FCC40CE1@trevor.secretlab.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Al Stone <al.stone@linaro.org>, linaro-acpi@lists.linaro.org, Linaro Patches <patches@linaro.org>, linux-acpi@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Dec 10, 2013 at 4:49 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> Hi Hanjun,
>
> Okay, so after talking with Al and Graeme on IRC, I think I understand
> what is going on. The fact that ACPICA doesn't allow for both normal and
> hardware reduced support in the same build is a very big problem.
> However, it isn't a problem for ARM since we'll never support
> non-hardware reduced mode. The x86 folks need to work that out when/if
> they ever add support for hardware reduced mode.

I believe SMBIOS/DMI tables are only part of full ACPI, so there is a
need on ARM for more than hardware reduced mode.

Rob
