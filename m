Return-Path: <SRS0=fmxS=DW=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7A2C433DF
	for <linux-acpi@archiver.kernel.org>; Thu, 15 Oct 2020 12:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE75B22258
	for <linux-acpi@archiver.kernel.org>; Thu, 15 Oct 2020 12:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602764916;
	bh=Us2bSe6hJd3ivB3yJ+k22LKF4+AAZtSUjVeKO234Dtc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UVnudRaphpBLKGW7sbOBfxg82Ad6N+0LqoCFAPowcWdhuKDsMOWmKH55/XykZod9n
	 5n+Tp7mQ9dbQDu0pWPl3ngA5eBs3sOnH3KHMVZfyoUBl4Qw8TlMx8pihg8KtjPRW4u
	 XlxrKRJPRz/9yPTt5/W3BnTMvX4V6CaUZZW+xz90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJOM2g (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 15 Oct 2020 08:28:36 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44397 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgJOM2e (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2020 08:28:34 -0400
Received: by mail-ot1-f54.google.com with SMTP id e20so2671741otj.11;
        Thu, 15 Oct 2020 05:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrP8EDXj/tPbjTGXn3kj+pdKTbRL6d9Pe6W+rT9RKYE=;
        b=t4/6ZTn74v3uCUX3JYxWg7Ouc4A5vot5ehadzsw/qbnpuxK87DIUVYIX1yz6cPX6xP
         EPgTWSyDszvgyB5zT2WkT8OA07ty1YoxC2a5XeiNxrTjRfPhGJ2CwMbRPz6pqbN3UhOs
         o5LyGiKQ2IhkIAR6Dr0fstJICJAD/Ttv5rsg540Vw+N1Srmkal3fk/uGTPdxNKfMdurJ
         R4fFdPdR46Q+38ylmrcZ/oQXi/CDKStnYdAx3N251DFoCzSoXFbOkpPQXDhlOOazZmEb
         UKIZzd9P5E39dxjUTAjQ8YSLB88Zs887j1WKf0jszC6zvvTY8u7aoYYdA4DF6AWYZir8
         Kefg==
X-Gm-Message-State: AOAM531eezQtIGg2dHBMRnIH8bdRDBLqrpBUiVXXOatj64561njHQCPg
        JESm72qYx6AKsEv5013FHxQ/mAUw7gnHkyxXGpQ/R9+f
X-Google-Smtp-Source: ABdhPJx7Znl8vuMykbq/96/l6Tonm0K3cUNheFN4a9cmZ0g1qKps5fVO7SbgUW1F+wQ9SSK0iXcHHqHeT4mHxAUmyx0=
X-Received: by 2002:a9d:ac9:: with SMTP id 67mr2562183otq.321.1602764913634;
 Thu, 15 Oct 2020 05:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201015095311.GA11838@zn.tnic> <20201015095851.GB11838@zn.tnic>
 <d6cdf27b-04ef-7bc8-03ef-2115ca08bffe@intel.com> <20201015120639.GE11838@zn.tnic>
In-Reply-To: <20201015120639.GE11838@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Oct 2020 14:28:22 +0200
Message-ID: <CAJZ5v0g-8gcWNrnFDvcaVRb3qC1vbjsbp7o_6YUf-9uaADR94A@mail.gmail.com>
Subject: Re: DPTF_POWER and DPTF_PCH_FIVR
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 15, 2020 at 2:06 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Oct 15, 2020 at 01:31:55PM +0200, Rafael J. Wysocki wrote:
> > Well, they depend on ACPI too and it doesn't look like there is anything
> > more fine grained that could be used here.
> >
> > Also I'm not sure if adding ACPI_DPTF (bool, disabled by default and
> > depending on x86) would help a lot.
>
> So you're saying this is going to be present in current and future
> hardware so might as well enable it?

Yes.  [Only on clients AFAICS, but still.]

In the meantime I have concluded that having a submenu for it would
make sense, though.  At least from the clarity POV.
