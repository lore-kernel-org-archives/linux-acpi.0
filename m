Return-Path: <SRS0=V7J1=7S=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33601C433DF
	for <linux-acpi@archiver.kernel.org>; Fri,  5 Jun 2020 11:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0206A206E6
	for <linux-acpi@archiver.kernel.org>; Fri,  5 Jun 2020 11:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591357017;
	bh=x+TVEqhuPg3Bfh4WC6K1/B0ECc+YqdKHKCymOIaqqvA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KrKQCHiMZoeME/w+qjTtwDLFDpbJnEl9h5ahl5yfXlkDnWsWx9UjeB4LFqUZ/KRoI
	 QE762kdTSBDV3bSx3dd4WJNQWRbF3Hw4n+AL3ony6eB07CUaUGwwTQ1O+SmU9oGUDV
	 8SmQnTuhmUX8/51Aslbdw/2PGlvOOoHho/+Hc29E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgFELg4 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:36:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45460 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgFELg4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jun 2020 07:36:56 -0400
Received: by mail-ot1-f67.google.com with SMTP id m2so7313659otr.12
        for <linux-acpi@vger.kernel.org>; Fri, 05 Jun 2020 04:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vG8pNa89xuCOZ6MT717vJeajkmE4ai5PMsihgWqe3hc=;
        b=Wk6EMWOnDhgv0FvCfxLJQS0Kuzs4lwXMctJc9SpkHkGGBRnyv96jw9XzWElIEwMtc+
         Fai4l/gEjODPHfXqfFumNpfeMBzZDAvgG3bj2pwHL/Ir2p9dZP1cRCy6e//hncx2qbtL
         xf0biIuKIDsiRLWkeIptEXk+dEyGJCsj+2i3y4WgbLCMaCUBvDRsX9GNY1+4hnTVOvI1
         RwTlaXdao2U8/iDzlvv1xm105d/p8OThYK8UpObL+8GE59aSD6ADv4A82qC2Y2akhzZx
         6nPRsnddc1aTqU+7CeUglSiFwN33ANQgJiA/yj15mowOYmNNg73BDoTDQvucMpTNdnYK
         lNAA==
X-Gm-Message-State: AOAM533xWkvHsFQty+sNtA3TutRtdrX6UWcIlzwJED/2nuk1E5a/ravH
        RuR8HNxdYXn9vHqG23VtxBjaNaLRJHPBu1iYiao=
X-Google-Smtp-Source: ABdhPJw7B2jc3QGjK0WbKPFM53f5UuonGcGn0xYyCki5vLgDnYW0/05lSojhpKd5CvEkt6bMW9sBsoDImALegwWk2VI=
X-Received: by 2002:a9d:5185:: with SMTP id y5mr6861933otg.118.1591357015611;
 Fri, 05 Jun 2020 04:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200604204421.592003-1-erik.kaneda@intel.com>
In-Reply-To: <20200604204421.592003-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Jun 2020 13:36:42 +0200
Message-ID: <CAJZ5v0gJzqyfvG1j6dTTpT_9K9Kp6DX8keiMZBAHAyfAQOS8fw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPICA release 20200528
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 4, 2020 at 11:08 PM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> This patch set contains the linux-ized patches of the ACPICA 20200528
> release. This is a small release containing changes to iASL and
> acpidump.
>
> Bob Moore (2):
>   ACPICA: acpidump: Removed dead code from oslinuxtbl.c ACPICA BZ 1119.
>   ACPICA: Update version to 20200528 Version 20200528.
>
> Erik Kaneda (1):
>   ACPICA: iASL: add new OperationRegion subtype keyword
>     PlatformRtMechanism
>
>  drivers/acpi/acpica/dbdisply.c                        |  2 ++
>  drivers/acpi/acpica/utdecode.c                        |  3 ++-
>  include/acpi/acpixf.h                                 |  2 +-
>  include/acpi/actypes.h                                |  3 ++-
>  .../acpi/os_specific/service_layers/oslinuxtbl.c      | 11 ++++++-----
>  5 files changed, 13 insertions(+), 8 deletions(-)

All three patches applied as 5.8-rc material, thanks!
