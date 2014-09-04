From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v5 1/2] Mailbox: Add support for Platform Communication Channel
Date: Thu, 4 Sep 2014 10:31:05 -0400
Message-ID: <CAJ5Y-ebzZhxkkH5_eUAfe80dXae0eDRLzfcvpFxv_T_3wy=t7Q@mail.gmail.com>
References: <1409782760-3958-1-git-send-email-ashwin.chaugule@linaro.org>
	<1409782760-3958-2-git-send-email-ashwin.chaugule@linaro.org>
	<1AE640813FDE7649BE1B193DEA596E8802661ED0@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:61344 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbaIDObJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2014 10:31:09 -0400
Received: by mail-wg0-f46.google.com with SMTP id x13so10161967wgg.17
        for <linux-acpi@vger.kernel.org>; Thu, 04 Sep 2014 07:31:06 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802661ED0@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "broonie@kernel.org" <broonie@kernel.org>

Hi Lv,

On 4 September 2014 00:35, Zheng, Lv <lv.zheng@intel.com> wrote:
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Ashwin Chaugule
>> Sent: Thursday, September 04, 2014 6:19 AM
>>
>> +
>> +#include <acpi/actbl.h>
>
> Please do not include this directly, it is already included by <linux/acpi.h> even when CONFIG is N.
> See <linux/acpi.h> -> <acpi/acpi.h> -> <acpi/actbl.h>
>

I'll update this accordingly.

Thanks,
Ashwin
