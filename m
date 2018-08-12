From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RESEND v3] arm64: clean the additional checks before
 calling ghes_notify_sea()
Date: Sun, 12 Aug 2018 11:43:17 +0200
Message-ID: <CAJZ5v0j=2-h8YggK8w6qjn9qKrDX8jAJ87Axox8LBdnn95Xkvg@mail.gmail.com>
References: <20180811043547.560-1-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180811043547.560-1-gengdongjiu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@suse.de>, Borislav Petkov <bp@alien8.de>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, baicar.tyler@gmail.com, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Tyler Baicar <tbaicar@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Aug 11, 2018 at 6:36 AM Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
> In order to remove the additional check before calling the
> ghes_notify_sea(), make stub definition when !CONFIG_ACPI_APEI_SEA.
>
> After this cleanup, we can simply call the ghes_notify_sea() to let
> APEI driver handle the SEA notification.
>
> CC: Tyler Baicar <tbaicar@codeaurora.org>
> CC: James Morse <james.morse@arm.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
> ---
> This cleanup is ever mentioned by Mark Rutland in [1]
>
> [1]:
> https://lkml.org/lkml/2018/5/31/289
>
> change since v2:
> 1. Add 'Reviewed-by' of Tyler

I have applied the v2 already.

Thanks!
