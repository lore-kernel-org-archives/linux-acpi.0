From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] acpi, apei: Add Boot Error Record Table (BERT) support
Date: Wed, 29 Jun 2016 23:13:32 +0200
Message-ID: <CAJZ5v0gcptmCgpmsCN3-pSo97JcRFvAWX4X01jZuF4uX=tByyQ@mail.gmail.com>
References: <13e567e22ba4776893cf074117d32e3c3276acb5.1467225769.git.tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32857 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbcF2VQG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jun 2016 17:16:06 -0400
In-Reply-To: <13e567e22ba4776893cf074117d32e3c3276acb5.1467225769.git.tony.luck@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Huang Ying <ying.huang@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, Fu Wei <fu.wei@linaro.org>, Tyler Baicar <tbaicar@codeaurora.org>, Borislav Petkov <bp@suse.de>

On Wed, Jun 29, 2016 at 10:04 PM, Luck, Tony <tony.luck@intel.com> wrote:
> From: Huang Ying <ying.huang@intel.com>
>
> ACPI/APEI is designed to verifiy/report H/W errors, like Corrected
> Error(CE) and Uncorrected Error(UC). It contains four tables: HEST,
> ERST, EINJ and BERT. The first three tables have been merged for
> a long time, but because of lacking BIOS support for BERT, the
> support for BERT is pending until now. Recently on ARM 64 platform
> it is has been supported. So here we come.
>
> Under normal circumstances, when a hardware error occurs, kernel will
> be notified via NMI, MCE or some other method, then kernel will
> process the error condition, report it, and recover it if possible.
> But sometime, the situation is so bad, so that firmware may choose to
> reset directly without notifying Linux kernel.
>
> Linux kernel can use the Boot Error Record Table (BERT) to get the
> un-notified hardware errors that occurred in a previous boot. In this
> patch, the error information is reported via printk.
>
> For more information about BERT, please refer to ACPI Specification
> version 6.0, section 18.3.1:
>   http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf
>
> The following log is a BERT record after system reboot because of hitting
> a fatal memory error:
> BERT: Error records from previous boot:
> [Hardware Error]: It has been corrected by h/w and requires no further action
> [Hardware Error]: event severity: corrected
> [Hardware Error]:  Error 0, type: recoverable
> [Hardware Error]:   section_type: memory error
> [Hardware Error]:   error_status: 0x0000000000000400
> [Hardware Error]:   physical_address: 0xffffffffffffffff
> [Hardware Error]:   card: 1 module: 2 bank: 3 row: 1 column: 2 bit_position: 5
> [Hardware Error]:   error_type: 2, single-bit ECC
>
> [Tomasz Nowicki: Clear error status at the end of error handling]
> [Tony: Applied some cleanups suggested by Fu Wei]
> [Fu Wei: delete EXPORT_SYMBOL_GPL(bert_disable), improve the code]
>
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> Reviewed-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>
> This seems to be the patch that is doomed to be forgotten. The
> original by Huang Ying was written so long ago that I don't want
> to search that deep into the archives in case I disturb a balrog.
> Fu Wei posted it back in January this year and got the Tested-by
> and Reviewed-by sign-offs:
>
>  https://lkml.kernel.org/r/1453196042-12273-1-git-send-email-fu.wei@linaro.org
>
> but then it looks like it was forgotten again :-(

Do you want me to take it?

Thanks,
Rafael
