From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH 2/4] acpi: cppc: optimized cpc_read and cpc_write
Date: Wed, 20 Jan 2016 17:17:35 -0500
Message-ID: <CAJ5Y-eaP46tk6dPH+7QKspstDthS8h4UL2PChC5r_r_qHT2o3w@mail.gmail.com>
References: <1452883415-24452-1-git-send-email-pprakash@codeaurora.org> <1452883415-24452-3-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34763 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934687AbcATWR4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2016 17:17:56 -0500
Received: by mail-lf0-f44.google.com with SMTP id 17so15259735lfz.1
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jan 2016 14:17:56 -0800 (PST)
In-Reply-To: <1452883415-24452-3-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>

On 15 January 2016 at 13:43, Prashanth Prakash <pprakash@codeaurora.org> wrote:
> cpc_read and cpc_write are used while holding the pcc_lock spin_lock,
> so they need to be as fast as possible. acpi_os_read/write_memory
> APIs linearly search through a list for cached mapping which is
> quite expensive. Since the PCC subspace is already mapped into
> virtual address space during initialization, we can just add the
> offset and access the necessary CPPC registers.
>
> This patch + similar changes to PCC driver reduce the time per freq.
> transition from around 200us to about 20us for cppc cpufreq driver
>
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> ---
>  drivers/acpi/cppc_acpi.c | 80 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 64 insertions(+), 16 deletions(-)

Acked-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
