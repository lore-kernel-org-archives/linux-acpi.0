From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 08/20] x86, ACPI: Find acpi tables in initrd early from head_32.S/head64.c
Date: Sun, 10 Mar 2013 10:42:36 -0700
Message-ID: <a2b9bc9e-ccff-483a-a73c-2b4993a413d2@email.android.com>
References: <1362897887-30808-1-git-send-email-yinghai@kernel.org> <1362897887-30808-9-git-send-email-yinghai@kernel.org> <CAOJsxLG2Qg7vmLWirWK-GOBp65NxogGcAU5guoVphDu2G=BsjA@mail.gmail.com> <CAE9FiQWQm0K2yywRisTRmFJmnpMpVsg6Ewh=swaZC2aM9ZKQQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60543 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619Ab3CJRqK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Mar 2013 13:46:10 -0400
In-Reply-To: <CAE9FiQWQm0K2yywRisTRmFJmnpMpVsg6Ewh=swaZC2aM9ZKQQw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>, Pekka Enberg <penberg@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Thomas Renninger <trenn@suse.de>, Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org, Jacob Shin <jacob.shin@amd.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

There is no 64-bit flat mode.  We use a #PF handler to emulate one by creating page tables on the fly.

Yinghai Lu <yinghai@kernel.org> wrote:

>On Sun, Mar 10, 2013 at 3:25 AM, Pekka Enberg <penberg@kernel.org>
>wrote:
>>
>> What is preventing us from making the 64-bit variant also work in
>flat
>> mode to make the code consistent and not hiding the differences under
>> the rug? What am I missing here?
>
>Boot loader could start kernel from 64bit directly from
>from arch/x86/boot/compressed/head_64.s::startup_64.
>
>initrd can be loaded by 64bit bootloader above 4G.
>
>So we even switch back to 32bit flat mode, we still can not access
>those initrd
>directly.
>
>Thanks
>
>Yinghai

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.
