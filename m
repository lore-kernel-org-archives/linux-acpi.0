From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v9] ACPI / init: Invoke early ACPI initialization earlier
Date: Wed, 27 Sep 2017 15:33:54 +0800
Message-ID: <88ed94a1-83bb-0338-caaa-e1773812ce4a@cn.fujitsu.com>
References: <1505293975-26005-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1505294274-441-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <e4eadcbc-fe58-2d2c-818d-34e2f545db16@cn.fujitsu.com>
 <alpine.DEB.2.20.1709270917590.1945@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:8836 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751396AbdI0HeC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Sep 2017 03:34:02 -0400
In-Reply-To: <alpine.DEB.2.20.1709270917590.1945@nanos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org, yinghai@kernel.org, bhe@redhat.com, bp@alien8.de, fengguang.wu@intel.com

Hi Thomas,

At 09/27/2017 03:19 PM, Thomas Gleixner wrote:
> On Wed, 27 Sep 2017, Dou Liyang wrote:
>
>> Hi Rafael, Zheng,
>>
>> Welcome any comments!
>>
>> Now, our patches are in tip tree, they are based on this
>> independent patch, we hope it can be merged earlier than our
>> patches to avoid ACPI Error. we need your advice and confirmation.
>
> You should have included that patch into your APIC series so I would have
> been aware that it's required for the APIC changes to work on all
> platforms.
>
> But not a big problem. I merge it through tip/x86/apic so the stuff works
> as expected.
>

Yeah, thank you so much.

Thanks,

	dou.


