Return-Path: <SRS0=21jG=BG=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D5CC433E1
	for <linux-acpi@archiver.kernel.org>; Mon, 27 Jul 2020 12:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545B1206E7
	for <linux-acpi@archiver.kernel.org>; Mon, 27 Jul 2020 12:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595854624;
	bh=KSJJx5Mr3TOamI5Mt+wJ42iYo++f+1dEJDs40l3fZpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O4Hsh4tQMZEXCv8OD16SyiRSbS1TsIJdlnuUJo5oN3b4AirfO/yLfBwlHkhFFCixv
	 DzTNmXji8r1mOoXIt8Rmo6+L0bUGQqNwTi5dhQIGHJQx3eaD6+eYBu/glNwXZJrSkJ
	 xNMEsqRnhz5JpoD8LQjN+u58Wnz4AAow82/bbBlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgG0M5D (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:57:03 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33069 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgG0M5D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jul 2020 08:57:03 -0400
Received: by mail-oi1-f194.google.com with SMTP id k22so14248140oib.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2020 05:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/uAt4HVD1TQLpx3z28VL2xEnYilQN3ch/DWNQ4uJSk=;
        b=BQQxOEMm7TcL8jW2IRbEtdFlJnnjhWLUH+JmQJlfV6gC8CLchgjHWMqosDhN6GpeGW
         Z4tKdSWScFYmtT/m0TOGDnbpBvwRHy6Z2FysWqTVer0w/C7TZg7icpE3t+OeBvTyUsO5
         RQb7cKr2p/SVFMVkLqXy40FFm0Ze/VCq22ZWN8f35OjLVuM7P1vJHYL6Ty6cjaCwaR0T
         Njr5edQCoO/17H6mFjw+vE4M+fu/dUxlDxmBd74jhQAQ0brRFgyxbnZW24feVkpLZWG5
         FaSIzYsaBx8C54btX5cVpdaEpCw1PC+pIlzfUa5pTsV2pOxjGpVYPydHEWAvCAIPV9Ii
         TMRQ==
X-Gm-Message-State: AOAM53160aIHc4NSwQAp2G11lQNZUjDfr+yy2JA45vx6rHCJD8EeWoJx
        BVdgugXsLvmkml2wBOfSE6axQe03pVs35n6qLw8=
X-Google-Smtp-Source: ABdhPJw9hiBVTn/Gla3skWJbPALNkgozLUpcWA5jpkQemdcIw+0Edp0y0xdC2CLjl7x1gpxQu0Nh1TCBFJisJs62DZw=
X-Received: by 2002:a05:6808:34e:: with SMTP id j14mr18651041oie.110.1595854623148;
 Mon, 27 Jul 2020 05:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200720173121.2580755-1-erik.kaneda@intel.com>
In-Reply-To: <20200720173121.2580755-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 14:56:52 +0200
Message-ID: <CAJZ5v0h2h6r5GW-+uT+HP6LZQpFtxjwhnSLAc=utQwF_FpU4AQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPICA release 20200717
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 20, 2020 at 7:55 PM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> This series contains patches relevant to linux kernel from ACPICA's
> 20200717 release. This ACPICA release contains a change in the ACPI
> object reference counting mechanism to allow firmware to declare a
> large amount of OperationRegion field units without overflowing the
> reference count.
>
> Bob Moore (1):
>   ACPICA: Update version to 20200717 Version 20200717.
>
> Erik Kaneda (1):
>   ACPICA: Do not increment operation_region reference counts for field
>     units
>
> Gustavo A. R. Silva (1):
>   ACPICA: Replace one-element array with flexible-array
>
>  drivers/acpi/acpica/exprep.c   | 4 ----
>  drivers/acpi/acpica/utdelete.c | 6 +-----
>  drivers/acpi/acpica/utids.c    | 3 +--
>  include/acpi/acpixf.h          | 2 +-
>  include/acpi/actypes.h         | 2 +-
>  5 files changed, 4 insertions(+), 13 deletions(-)
>
> --

All three patches applied as 5.9 material, thanks!
