Return-Path: <SRS0=Z37m=SU=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA05C10F0E
	for <linux-acpi@archiver.kernel.org>; Thu, 18 Apr 2019 14:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E80206B6
	for <linux-acpi@archiver.kernel.org>; Thu, 18 Apr 2019 14:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555598962;
	bh=B7HTXH2MS0ycclyt2mejnrgJuhsMVFgrm1YNhEY/tSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q/jkP2e5b0iDDjtMOohegKzqMoZATVM80TaxYxeJyFx3NePN+UZViRidoPZPz280M
	 Iq1Mb2W1cylyGbU8SFdDgvx2xqK7FsVbjgZmPxyLWz9xmDIcWLnzv0S0a+3jHZWv6l
	 nJ8uRtqg7pm38cb8CCdF/UR86ZgcxfS4B+vN+RzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbfDROtV (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:49:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46671 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDROtV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Apr 2019 10:49:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id x188so1778854oia.13
        for <linux-acpi@vger.kernel.org>; Thu, 18 Apr 2019 07:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7HTXH2MS0ycclyt2mejnrgJuhsMVFgrm1YNhEY/tSI=;
        b=YuL2i3r6Q+CLuDm375cSoCF+jd6Ta5cSBhYS6wSxQedkhS/bCcE+NQYIesa1BHPoiJ
         UwqiCB2Ir130AuQaP/wk6vpcoAVlegqcJMGn4GKdbCeDppMxggrEwj5PFg0sGgNzV6+8
         M3lTCH4T8H5H5o/4/d/uXUK8ihna1NtsuCMrSkdj0h9tSHa3JVMuwjlw6Du/BxKdOdEt
         jeNSDOa5Vs12CjAxjXAvlDTrgqDEOGunFJnWmiEfmypunvn0vkLRYDeg4Eo+ZmhukGCT
         8KhS96vQMaaAbRxxbw3//7WvOMSWH9ezjpYs0vQXmhBJ/kddKF3vkDUmfFs4pGlLw5t2
         bfyA==
X-Gm-Message-State: APjAAAWom0HkcWlw4HTtrEk/aDjMVDTtNoyuORNZL0eSsr5KJw7rDSNK
        fN8HOQp+k3U3mLkIFauCk3OU4X78b4GRyruUTTk=
X-Google-Smtp-Source: APXvYqwQR6FvDmbmhGrUcSVwVmb7V3ufY1PC8GRPxDG4CHuSe86+ufp0mVoOj2M/bn6HDQz3BfMglp+DJfCmFBRuj/E=
X-Received: by 2002:aca:ab06:: with SMTP id u6mr2075791oie.68.1555598959618;
 Thu, 18 Apr 2019 07:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190418113933.11158-1-hdegoede@redhat.com>
In-Reply-To: <20190418113933.11158-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Apr 2019 16:49:08 +0200
Message-ID: <CAJZ5v0g614gPUL9p-Tn4bRRwDcqd+F+-RSr50xXrMTpDzSnd+A@mail.gmail.com>
Subject: Re: [PATCH] ACPI / LPSS: Use acpi_lpss_* instead of acpi_subsys_*
 functions for hibernate
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Robert R . Howell" <RHowell@uwyo.edu>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 18, 2019 at 1:39 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from
> resume_noirq") makes acpi_lpss_{suspend_late,resume_early}() bail early
> on BYT/CHT as resume_from_noirq is set.
>
> This means that on resume from hibernate dw_i2c_plat_resume() doesn't get
> called by the restore_early callback, acpi_lpss_resume_early(). Instead it
> should be called by the restore_noirq callback matching how things are done
> when resume_from_noirq is set and we are doing a regular resume.
>
> Change the restore_noirq callback to acpi_lpss_resume_noirq so that
> dw_i2c_plat_resume() gets properly called when resume_from_noirq is set
> and we are resuming from hibernate.
>
> Likewise also change the poweroff_noirq callback so that
> dw_i2c_plat_suspend gets called properly.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202139
> Fixes: 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from resume_noirq")
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued up, thanks!

I've tentatively tagged it for 4.20+ "stable" inclusion, please let me
know if you think that's not appropriate.
