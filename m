From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/5] ACPI / debugger: Fix regressions that AML debugger
 stops working
Date: Wed, 6 Jul 2016 01:41:50 +0200
Message-ID: <CAJZ5v0gjN_bKyf+mph3qzRXMm0K+YOFDuucYa3rxoup99mYAQg@mail.gmail.com>
References: <cover.1467717304.git.lv.zheng@intel.com> <c42921c3de9a94fcff97a2de7ac5599cc38ec41f.1467717305.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33984 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbcGEXlx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jul 2016 19:41:53 -0400
In-Reply-To: <c42921c3de9a94fcff97a2de7ac5599cc38ec41f.1467717305.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Tue, Jul 5, 2016 at 1:18 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> The FIFO unlocking mechanism in acpi_dbg has been messed up by the
> following commit:
>   Commit: 287980e49ffc0f6d911601e7e352a812ed27768e
>   Subject: remove lots of IS_ERR_VALUE abuses
> It converts !IS_ERR_VALUE(ret) into !ret. This patch fixes the
> regression.
>
> Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

OK, but ->

> ---
>  drivers/acpi/acpi_dbg.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
> index 1f41284..ebc8d18 100644
> --- a/drivers/acpi/acpi_dbg.c
> +++ b/drivers/acpi/acpi_dbg.c
> @@ -602,7 +602,8 @@ static int acpi_aml_read_user(char __user *buf, int len)
>         crc->tail = (crc->tail + n) & (ACPI_AML_BUF_SIZE - 1);
>         ret = n;
>  out:
> -       acpi_aml_unlock_fifo(ACPI_AML_OUT_USER, !ret);
> +       acpi_aml_unlock_fifo(ACPI_AML_OUT_USER,
> +                            ret < 0 ? false : true);

-> The ternary operation is not necessary here, because the result of
(ret < 0) is already boolean.  So this can be written as

acpi_aml_unlock_fifo(ACPI_AML_OUT_USER, ret >= 0);

and analogously below.

I've made that change, please check the result in bleeding-edge.

Thanks,
Rafael
