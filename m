From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 08/20] x86, ACPI: Find acpi tables in initrd early from head_32.S/head64.c
Date: Sun, 10 Mar 2013 09:47:18 -0700
Message-ID: <CAE9FiQWQm0K2yywRisTRmFJmnpMpVsg6Ewh=swaZC2aM9ZKQQw@mail.gmail.com>
References: <1362897887-30808-1-git-send-email-yinghai@kernel.org>
	<1362897887-30808-9-git-send-email-yinghai@kernel.org>
	<CAOJsxLG2Qg7vmLWirWK-GOBp65NxogGcAU5guoVphDu2G=BsjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:57080 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab3CJQrS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Mar 2013 12:47:18 -0400
In-Reply-To: <CAOJsxLG2Qg7vmLWirWK-GOBp65NxogGcAU5guoVphDu2G=BsjA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Thomas Renninger <trenn@suse.de>, Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org, Jacob Shin <jacob.shin@amd.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

On Sun, Mar 10, 2013 at 3:25 AM, Pekka Enberg <penberg@kernel.org> wrote:
>
> What is preventing us from making the 64-bit variant also work in flat
> mode to make the code consistent and not hiding the differences under
> the rug? What am I missing here?

Boot loader could start kernel from 64bit directly from
from arch/x86/boot/compressed/head_64.s::startup_64.

initrd can be loaded by 64bit bootloader above 4G.

So we even switch back to 32bit flat mode, we still can not access those initrd
directly.

Thanks

Yinghai
