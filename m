From: Al Stone <al.stone@linaro.org>
Subject: Re: [RFC part1 PATCH 5/7] ARM64 / ACPI: Introduce arm_core.c and
 its related head file
Date: Wed, 04 Dec 2013 12:47:54 -0700
Message-ID: <529F86EA.4010805@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org> <1386088611-2801-6-git-send-email-hanjun.guo@linaro.org> <1AE640813FDE7649BE1B193DEA596E88024941A4@SHSMSX101.ccr.corp.intel.com> <529F5013.4050502@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:53516 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933010Ab3LDTr6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 14:47:58 -0500
Received: by mail-pb0-f45.google.com with SMTP id rp16so24169265pbb.18
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 11:47:57 -0800 (PST)
In-Reply-To: <529F5013.4050502@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <rob.herring@calxeda.com>, Mark Rutland <mark.rutland@arm.com>, Jon Masters <jonathan@jonmasters.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@l>

On 12/04/2013 08:53 AM, Hanjun Guo wrote:
> On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 13:46, Zheng, Lv wrote:
>>> From: linux-acpi-owner@vger.kernel.org
>>> [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Hanjun Guo
>>> Sent: Wednesday, December 04, 2013 12:37 AM
>>>
>>> introduce arm_core.c and its related head file, after this patch,
>>> we can get ACPI tables from BIOS on ARM64 now.
>>>
>>> Signed-off-by: Al Stone <al.stone@linaro.org>
>>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> ---
>>>   arch/arm64/include/asm/acpi.h |   57 +++++++++++
>>>   arch/arm64/kernel/setup.c     |    8 ++
>>>   drivers/acpi/Makefile         |    2 +
>>>   drivers/acpi/plat/Makefile    |    1 +
>>>   drivers/acpi/plat/arm-core.c  |  219
>>> +++++++++++++++++++++++++++++++++++++++++
>>>   5 files changed, 287 insertions(+)
>>>   create mode 100644 drivers/acpi/plat/Makefile
>>>   create mode 100644 drivers/acpi/plat/arm-core.c
>>>

[...]

>>
>> I'm not sure if all global lock code blocks are not referenced by
>> ACPI_REDUCED_HARDWARE and I'm not sure what mechanism is implemented
>> on ARM ACPI platforms to offer the synchronization mechanism between
>> firmware and OSPM.  So you may need to implement the following
>> synchronization protocol in <asm/acpi.h>:
>> 58 #define ACPI_ACQUIRE_GLOBAL_LOCK(facs, Acq)
>> 61 #define ACPI_RELEASE_GLOBAL_LOCK(facs, Acq)
>
> In reduced hardware mode, No hardware resource sharing between
> OSPM and other asynchronous operating environments, such as
> UEFI Runtime Services or System Management Mode. (The Global Lock
> is not supported)
>
> please refer to chapter 3.11.1 of ACPI 5.0.

I agree with Hanjun; the spec clearly states that the ACPI global lock
is not supported in reduced HW mode.  The only similar lock I recall
from the spec is for ECs (Embedded Controllers, section 12) but is very
specific to controlling the interaction with the EC.

If the intent is to use SMI, again, in reduced HW mode, 3.11.1 does
not allow SMI_CMD, and 5.2.9 indicates SMI_CMD is to be ignored.


--=20
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
