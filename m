Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05B5C433B4
	for <linux-acpi@archiver.kernel.org>; Fri, 23 Apr 2021 12:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5BD61459
	for <linux-acpi@archiver.kernel.org>; Fri, 23 Apr 2021 12:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242301AbhDWMem (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 23 Apr 2021 08:34:42 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:45571 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhDWMel (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 08:34:41 -0400
Received: by mail-wr1-f41.google.com with SMTP id h4so39202711wrt.12;
        Fri, 23 Apr 2021 05:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CnDAq/wf30SK+v97SSEfI5TLrb0FjfVhYtu1LvUj2FE=;
        b=X7bfQCEqzkwawL/12PZGy254e06IWzH40f9gk4X7gq4PWp9ceSqwp/5Wf0aN9ONEC1
         gB22zmYWFEmGoNm2KCr0dmD77Zc0yK8giFkMcDBrbUUzsXawookM2qQYbOtqMyqfhnkE
         IGeFLS1yE2QB07EyvZn5AjiP042Xh/yMT64/qfNmsDVQf/JbhOEXNpY4qcfiIAQnsApZ
         46rdDhaMU3kTFpEvDYbYCVDakl1mHM/XMdS/+eqUWNFkprrytTogHM3oCx26zButF02i
         M5VE4/FedTf9zFY8kyJ6vwqbHfxBZBQtmVH/pMgrn7sVwJGuNe/0GgCwGLAM0/2LF+tc
         K8TA==
X-Gm-Message-State: AOAM530yiqD0RjwJ/EEV5vW8eg5Jj9NRenBE3BjuX/eMv6TxVKd8zZPP
        LtdR/IY2MW6X6pzMEG7HCjXY0+Gt2SVhFzB5JTM=
X-Google-Smtp-Source: ABdhPJwUJTJmvjUsLOs2czySsDSbXe3xbOjXToTSowi772RhmQrLzizFciArf9giECNlBWi3zp1t0vSsxQZjJSzMDJ4=
X-Received: by 2002:adf:9d81:: with SMTP id p1mr4606469wre.247.1619181244219;
 Fri, 23 Apr 2021 05:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210422214708.716164-2-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210422214708.716164-2-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Apr 2021 14:33:53 +0200
Message-ID: <CAJZ5v0itaKL58ieMB6ER47GVns7Ukvd_7VNBAxkktWB5cDv-SQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup
 Mailbox Structure
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 22, 2021 at 11:47 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> ACPICA commit f1ee04207a212f6c519441e7e25397649ebc4cea
>
> Add Multiprocessor Wakeup Mailbox Structure definition. It is useful
> in parsing MADT Wake table.
>
> Link: https://github.com/acpica/acpica/commit/f1ee0420
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

I'm expecting to receive this patch from Erik at one point, so I'm
guessing that it's been added to this series for reference.

> ---
>  include/acpi/actbl2.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index b2362600b9ff..7dce422f6119 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -733,6 +733,20 @@ struct acpi_madt_multiproc_wakeup {
>         u64 base_address;
>  };
>
> +#define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE       2032
> +#define ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE 2048
> +
> +struct acpi_madt_multiproc_wakeup_mailbox {
> +       u16 command;
> +       u16 reserved;           /* reserved - must be zero */
> +       u32 apic_id;
> +       u64 wakeup_vector;
> +       u8 reserved_os[ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE];       /* reserved for OS use */
> +       u8 reserved_firmware[ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE];   /* reserved for firmware use */
> +};
> +
> +#define ACPI_MP_WAKE_COMMAND_WAKEUP    1
> +
>  /*
>   * Common flags fields for MADT subtables
>   */
> --
> 2.25.1
>
