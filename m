From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v8 1/2] Mailbox: Add support for Platform Communication Channel
Date: Thu, 2 Oct 2014 13:59:26 -0400
Message-ID: <CAJ5Y-eZYK7+wKfmAJJmAqVZAFMoxDaH0DLR0p5_wPG+ft5x3yA@mail.gmail.com>
References: <1412196373-7794-1-git-send-email-ashwin.chaugule@linaro.org>
	<1412196373-7794-2-git-send-email-ashwin.chaugule@linaro.org>
	<20141002172530.GW4273@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:57694 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbaJBR71 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Oct 2014 13:59:27 -0400
Received: by mail-wi0-f171.google.com with SMTP id em10so2264648wid.10
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2014 10:59:26 -0700 (PDT)
In-Reply-To: <20141002172530.GW4273@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>

On 2 October 2014 13:25, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Oct 01, 2014 at 04:46:12PM -0400, Ashwin Chaugule wrote:
>> ACPI 5.0+ spec defines a generic mode of communication
>> between the OS and a platform such as the BMC. This medium
>> (PCC) is typically used by CPPC (ACPI CPU Performance management),
>> RAS (ACPI reliability protocol) and MPST (ACPI Memory power
>> states).
>
> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks for the quick turn Mark!

Arnd, Lv, since you both helped a lot as well, let me know if I can
add your Reviewed-by tags to this patch set.

Thanks,
Ashwin
