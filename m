Return-Path: <SRS0=vzJg=65=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFF1C433E0
	for <linux-acpi@archiver.kernel.org>; Fri, 15 May 2020 16:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEFB206D8
	for <linux-acpi@archiver.kernel.org>; Fri, 15 May 2020 16:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589560116;
	bh=KLYqBIEyATsUReVc/rPucOuYrH8DQmA10bxBlkuh+NE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZbKXtAwikHzKG+rK0lSdlqOwBfRKZrXi+RkrjdN4gy4XBq6ikm5cd/9gr8KS5hFGN
	 /bIluJC0aKEI60J6krK9TTc16xUZwWFxy0e/51UkBC/oedGnEpKCK1jl9tA1A+ko/9
	 UAxBO3wUGMWgol0CDKWgCBP09cD3pljSNgvxtGnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgEOQ2g (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 15 May 2020 12:28:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33026 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEOQ2g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2020 12:28:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id o24so2754183oic.0
        for <linux-acpi@vger.kernel.org>; Fri, 15 May 2020 09:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JO6K8ZkDYog0FAZlSVdOKYU4OY/IKhh0/sWYIZeNXA=;
        b=JHwohrLWVdHyrSy1WDuBrhQqk3mQsDFtRnWSIyIsnCfBCdG76Xl6LxtFAGWtbb59gC
         9ILzQ5MDpay3nxCZMF0Grysm0yl9hA7RFC0qst4FAKldroa5V5LuY3O+i9byoyrJUbAZ
         l3KQnZflnFg5bqgiJPVmtJyqo0TQ1Sm+BQoFWNXO3OdMcfps8D34VKo6XX6KmwOc/xdJ
         AZUtXHSpn7t9akWkd6dSK+rhJlwung/1Me5MNCBwMEyjymgP4d/gDW1C9JSQVh4UefrZ
         5XWe9ZdYYtd6pfjS8SWRfkdkkeanD0CeQwvEcMbwFUBWwmJ1ualD3PSLkLJ2lPw6MVcw
         31dg==
X-Gm-Message-State: AOAM532+hKrRqCQuryIucHYw5MYZk9XsiXoTHeIOFN+Qn9tOs93UiuZx
        2/h/eNVCRCiV1fpvxoP4r3OOS3awtL/fuXuiQ/Y=
X-Google-Smtp-Source: ABdhPJwS16qIjoA04pwHF9Vzpw4bmn7Kv9HF4FTo9GOmdcROcCX5shCnSim1WuvKhxUr6ISGC1PDpohoAFm64PzTPnw=
X-Received: by 2002:aca:4254:: with SMTP id p81mr2606497oia.68.1589560114092;
 Fri, 15 May 2020 09:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589262490.git.mchehab+huawei@kernel.org> <4ea6a89bcde8c72427e69a87551bdfca8bf1af11.1589262490.git.mchehab+huawei@kernel.org>
In-Reply-To: <4ea6a89bcde8c72427e69a87551bdfca8bf1af11.1589262490.git.mchehab+huawei@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 May 2020 18:28:22 +0200
Message-ID: <CAJZ5v0gRScLoBGr6546=zJBtZj2D0-Yv48RZobN-0eih01L29A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI / PMIC: Add i2c address for thermal control
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 12, 2020 at 7:52 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> On Asus T101HA, we keep receiving those error messages:
>
>         i915 0000:00:02.0: [drm] *ERROR* mipi_exec_pmic failed, error: -95
>         intel_soc_pmic_exec_mipi_pmic_seq_element: Not implemented
>         intel_soc_pmic_exec_mipi_pmic_seq_element: i2c-addr: 0x5e reg-addr 0x4b value 0x59 mask 0xff
>
> Because the opregion is missing the I2C address.
>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> index 7ccd7d9660bc..a5101b07611a 100644
> --- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> +++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> @@ -102,6 +102,7 @@ static struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
>         .power_table_count = ARRAY_SIZE(chtdc_ti_power_table),
>         .thermal_table = chtdc_ti_thermal_table,
>         .thermal_table_count = ARRAY_SIZE(chtdc_ti_thermal_table),
> +       .pmic_i2c_address = 0x5e,
>  };
>
>  static int chtdc_ti_pmic_opregion_probe(struct platform_device *pdev)
> --

This appears to be part of a series, but the second patch has not been
CCed to linux-acpi.

Can I assume that this one will be applied along with the [2/2] by
another maintainer?

Thanks!
