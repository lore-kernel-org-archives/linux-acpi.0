From: Jike Song <albcamus@gmail.com>
Subject: Re: [PATCH 3/5] ACPI: update feature-removal.txt to reflect deleted
 acpi=ht option
Date: Fri, 2 Jun 2017 17:30:19 +0800
Message-ID: <CANE52KixWBLc6UEjbBQ3AdBoA+OkDFjPi_c=Deb2rS15fnyXgQ@mail.gmail.com>
References: <d5a64513c6a171262082c250592c062e97a2c693.1275680785.git.len.brown@intel.com>
 <1275680845-8352-1-git-send-email-lenb@kernel.org> <0a76a34ff0804f1f413807b2e2d12117c2b602ca.1275680785.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34868 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdFBJaU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2017 05:30:20 -0400
Received: by mail-qt0-f194.google.com with SMTP id r58so8781518qtb.2
        for <linux-acpi@vger.kernel.org>; Fri, 02 Jun 2017 02:30:20 -0700 (PDT)
In-Reply-To: <0a76a34ff0804f1f413807b2e2d12117c2b602ca.1275680785.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>

Hi Len,

Sorry for replying such a old mail written ~7 years ago, but I
actually found there is still "acpi=ht" documented in current kernel:

Documentation/x86/x86_64/boot-options.txt

  acpi=ht Use ACPI boot table parsing, but don't enable ACPI interpreter



On Sat, Jun 5, 2010 at 3:47 AM, Len Brown <lenb@kernel.org> wrote:
> From: Len Brown <len.brown@intel.com>
>
> Per plan, acpi=ht was removed in 2.6.35-rc1.
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  Documentation/feature-removal-schedule.txt |    9 ---------
>  1 files changed, 0 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index 672be01..c268783 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -578,15 +578,6 @@ Who:       Avi Kivity <avi@redhat.com>
>
>  ----------------------------
>
> -What:  "acpi=ht" boot option
> -When:  2.6.35
> -Why:   Useful in 2003, implementation is a hack.
> -       Generally invoked by accident today.
> -       Seen as doing more harm than good.
> -Who:   Len Brown <len.brown@intel.com>
> -
> -----------------------------
> -
>  What:  iwlwifi 50XX module parameters
>  When:  2.6.40
>  Why:   The "..50" modules parameters were used to configure 5000 series and
> --
> 1.6.0.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks,
Jike
