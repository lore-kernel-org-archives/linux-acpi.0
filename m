Return-Path: <SRS0=VdvG=YR=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B00CA9EBC
	for <linux-acpi@archiver.kernel.org>; Thu, 24 Oct 2019 21:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558CB21D71
	for <linux-acpi@archiver.kernel.org>; Thu, 24 Oct 2019 21:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571952909;
	bh=BM0nXEnKNroKrUxltiFR+J3AYqgBmfrH1nGm8Vo+ljw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z/vEXwEl15iFppTcQdAW9M2pKYQcOgpjgmSrDqjL8erJS1r3bGh7SutNRP+usImHq
	 QGnM65cCMATgY52RuBHwBkzkd2l8q85XdHqBNlTvyU/VdPOdLn5xzUxDv12avwyMWx
	 yeTDNfsgwL4yRsBA1lOkeNdcfAcs25waWCSBPN/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfJXVfI (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:35:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40531 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfJXVfI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Oct 2019 17:35:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id d8so320581otc.7;
        Thu, 24 Oct 2019 14:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZ88OqumTpVoT5vcOIm3DEFWFHAJdjnuEjiMlm9Z8tc=;
        b=CjP+enKCikgrn0lAPyCah67mVPfjplxAJpyYAbOL0T0pMyOjfKaj/IMmHWu3Z52W8y
         2/WQgMFQUO+Z03unT5hEWyXHuG4/qp8c7PrmkNc14+V7f6TUAgb8EbXq2e5PEeFDxGN4
         4G5+WjjCAKwNVJRChqBiJnthXQxyireZk2Z46Gnc1g3QiUUsugE1R3i/uShNyuDW+P/q
         fp+4RIGr5mPRUNMbGrjDmMY9xFX0ZKvEtT2pji5A6VOJjPWefp+cN9qOXlcXFG6u+C2f
         HC+yMttQJnfIQbhPGWfPMpsasD0LK8phqEDcn4jysgKFzIMVFG7wKchDnwBHcjakgXXT
         bM6A==
X-Gm-Message-State: APjAAAW9u2kkA4VrFbzCxirNp+8CcukBw2fy/RNdI+XM4WXa1Rfi1TQN
        rSkBzD6bmAe5wPjAdOFLkKY5fWTnGR/GypcgmuM=
X-Google-Smtp-Source: APXvYqyFYarGLA6VaOAy0t8L1VQO19bs/+SV4y5yOSpLpiVCRya1y7oWCGhI0sBJEHqkp8cpVFo+p0lhhbfXHqJhbOM=
X-Received: by 2002:a05:6830:1e69:: with SMTP id m9mr33763otr.262.1571952907553;
 Thu, 24 Oct 2019 14:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191024212936.144648-1-hdegoede@redhat.com>
In-Reply-To: <20191024212936.144648-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Oct 2019 23:34:57 +0200
Message-ID: <CAJZ5v0jDuvEBob93wgYFuz0q1QyraOtxnbs-xqBOM_87jBnKqw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI / LPSS: Add LNXVIDEO -> BYT I2C7 to lpss_device_links
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 24, 2019 at 11:29 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> So far on Bay Trail (BYT) we only have been adding a device_link adding
> the iGPU (LNXVIDEO) device as consumer for the I2C controller for the
> PMIC for I2C5, but the PMIC only uses I2C5 on BYT CR (cost reduced) on
> regular BYT platforms I2C7 is used and we were not adding the device_link
> sometimes causing resume ordering issues.
>
> This commit adds LNXVIDEO -> BYT I2C7 to the lpss_device_links table,
> fixing this.
>
> Cc: stable@vger.kernel.org

Thanks for these fixes, but it would be kind of nice to have Fixes:
tags for them too.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpi_lpss.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 60bbc5090abe..e7a4504f0fbf 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -473,9 +473,14 @@ struct lpss_device_links {
>   * the supplier is not enumerated until after the consumer is probed.
>   */
>  static const struct lpss_device_links lpss_device_links[] = {
> +       /* CHT External sdcard slot controller depends on PMIC I2C ctrl */
>         {"808622C1", "7", "80860F14", "3", DL_FLAG_PM_RUNTIME},
> +       /* CHT iGPU depends on PMIC I2C controller */
>         {"808622C1", "7", "LNXVIDEO", NULL, DL_FLAG_PM_RUNTIME},
> +       /* BYT CR iGPU depends on PMIC I2C controller (UID 5 on CR) */
>         {"80860F41", "5", "LNXVIDEO", NULL, DL_FLAG_PM_RUNTIME},
> +       /* BYT iGPU depends on PMIC I2C controller (UID 7 on non CR) */
> +       {"80860F41", "7", "LNXVIDEO", NULL, DL_FLAG_PM_RUNTIME},
>  };
>
>  static bool hid_uid_match(struct acpi_device *adev,
> --
> 2.23.0
>
