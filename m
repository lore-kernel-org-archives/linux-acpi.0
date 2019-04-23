Return-Path: <SRS0=tfVV=SZ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE8EC10F14
	for <linux-acpi@archiver.kernel.org>; Tue, 23 Apr 2019 08:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE09521738
	for <linux-acpi@archiver.kernel.org>; Tue, 23 Apr 2019 08:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556006882;
	bh=McUNjshzy37vbxJiA9SbmoYWmiG/6VcekJEDStYjTb8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LJxVADnvfWalx/g20Eo7SYYTrfFkxDWoRLrD6/dOoxrvpx1Az2KEJzEI5RxRWl4is
	 yGFZJfiiyK0uOFYR0BwoUuMiaDho+tE8/Ax3sr0+RVQkP0n4E1VdCZSyszrMTqVctP
	 PX1QzQIynggsBZDplbCbkq0mvAuE8vRkRfVkqt/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfDWIH4 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:07:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33826 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfDWIH4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Apr 2019 04:07:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id v10so10579732oib.1;
        Tue, 23 Apr 2019 01:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACYuZFm53+zM/QdTlUn6BcSxreTpWAn7/bi9ZqwcX0c=;
        b=B1RVCC4YtLEEn/atVdjrs6BYNR1nshXs8ABLwWXXoyk/e8pymxGbp/wQfRwSAP8xQR
         1zFaKsSVkxb/0YHcWspmYWnOcBguxppOWloROnf5dt2gDEHLEAD3xsRLoaOIeyA17JEa
         WYOoKx151Lzc8IdALrECgzoatVh2Hz8krKyL0N+BenECSY9a3Ka6ggD7WYnOQCO4wLps
         76OrMCwXEJl75ion2JGW3RihT0sDtU5AGtawbueAt6KumgCZS5PxNmGRaGjve/D8g5nw
         u3PVCB8x3ejrwWrsWH9roY32FQssay6pmepGZ2D/+4ySjwTOgoAxMH/N5csdIB6cGf2N
         76Lg==
X-Gm-Message-State: APjAAAWy/qhx7agsr6QpnLHqE+vuBg3KEWs/Shj2cqQU8Z9kq/TouK/6
        vCgbK/oCdQ2bi8AGbwHaxktVD99VH/nBJlP4U6I=
X-Google-Smtp-Source: APXvYqzbICNOPmSMWhZ8xkfw6tIMbENNQ72Ga4mNWl6VJrWA1w0WYONLtlWNMmewKC8MHhl9HwxX766yUeBMSc9UhwY=
X-Received: by 2002:aca:b841:: with SMTP id i62mr961321oif.103.1556006875241;
 Tue, 23 Apr 2019 01:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com> <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
 <feb1808d-542c-83c2-5c70-9228473bb8d0@redhat.com> <0a770539-dfe9-2eb6-a90a-82f065a23a3f@uwyo.edu>
 <f6db39bc-b8d1-fda8-ad37-a8b050ef0027@redhat.com> <37aee883-1253-adad-82b4-4a578cc72825@uwyo.edu>
In-Reply-To: <37aee883-1253-adad-82b4-4a578cc72825@uwyo.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Apr 2019 10:07:40 +0200
Message-ID:
 <CAJZ5v0j9U20cFbRx6QKeQv6wyDg6nL71L0U_Rec5+W1JoD8-=w@mail.gmail.com>
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
To:     "Robert R. Howell" <RHowell@uwyo.edu>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190423080740.ug4pyMbTLwm5VFTQq46hD627ZjkQg024RDL14eb7VM8@z>

On Sat, Apr 20, 2019 at 12:44 AM Robert R. Howell <RHowell@uwyo.edu> wrote:
>
> On 4/18/19 5:42 AM, Hans de Goede wrote:
>
> >> On 4/8/19 2:16 AM, Hans de Goede wrote:>
> >>>
> >>> Hmm, interesting so you have hibernation working on a T100TA
> >>> (with 5.0 + 02e45646d53b reverted), right ?
> >>>
>
> > Still since my patch is regressing things for you I will try to
> > take a look at this and see if I can reproduce and come up with
> > a fix. But this is not going to be a high priority thing for me to
> > work on.
> >
> > In the mean time I've gone ahead and submitted my version of the
> > fix for the problem Kai-Heng was seeing, since that does not seem
> > to make your problem worse; and it will be good to get that problem
> > fixed.
> >
> > Regards,
> >
> > Hans
> >
>
> I've managed to find a way around the i2c_designware timeout issues
> on the T100TA's.  The key is to NOT set DPM_FLAG_SMART_SUSPEND,
> which was added in the 02e45646d53b commit.
>
> To test that I've started with a 5.1-rc5 kernel, applied your recent patch
> to acpi_lpss.c, then apply the following patch of mine, removing
> DPM_FLAG_SMART_SUSPEND.  (For the T100 hardware I need to apply some
> other patches as well but those are not related to the i2c-designware or
> acpi issues addressed here.)
>
> On a resume from hibernation I still see one error:
>   "i2c_designware 80860F41:00: Error i2c_dw_xfer called while suspended"
> but I no longer get the i2c_designware timeouts, and audio does now work
> after the resume.
>
> Removing DPM_FLAG_SMART_SUSPEND may not be what you want for other
> hardware, but perhaps this will give you a clue as to what is going
> wrong with hibernate/resume on the T100TA's.

What if you drop DPM_FLAG_LEAVE_SUSPENDED alone instead?
