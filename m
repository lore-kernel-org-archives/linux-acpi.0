Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485C8C433EF
	for <linux-acpi@archiver.kernel.org>; Tue, 21 Jun 2022 09:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348278AbiFUJP0 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 21 Jun 2022 05:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiFUJPY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jun 2022 05:15:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE5B17E11
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 02:15:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t24so9059155lfr.4
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 02:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iBZb8QF8anbqYzHGcPDDrRLJY5xZsGwi7V0oDGBrKac=;
        b=AQc7158zy5Ml9gDb+tE/k8bTnCfcB3WvyB862bgHd72Vg8hhgqJMbRrVW97nyoyZJB
         Irp9HZrE24jjCKypfsOdQToRJH27bRZ4lrX48bWo93HfxWJkE17DFNq9d4w7pm3geUVU
         44qYPnPz74iw0Fx/olfjhbE5pCrYf6tT311huGdtCX9KeZpQg7bQq45KLStWv6wCZJ7j
         hckpI/lRVWMJp0w9Eal6XZINA7zbSBfbde67P4xSiPf3G8ARhkITEn39KzCEhiJbOCBT
         b83krTDDF8YfTVAa4gNCCZ1PvPTzXqq67V5XdiSelWRK0MY03e1+hfo2EPNTw/Ci7qBR
         7jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iBZb8QF8anbqYzHGcPDDrRLJY5xZsGwi7V0oDGBrKac=;
        b=pJX9gC0ohh10Gw0CqlO1nyexxdES4C4wcEPSh9dUjwpAxYL4smfHIoJ8kPJc4s3r6T
         mZHnKK7EC3IL2lWUVvjNRNaGtS+GbaDu1AoL3tW6WFXJ3PAhmlSBCbZUFxuRsrGKwTp0
         z5RQ1Nj2quKB7H3vvf+tbgy0FTsv5seEx38iSFZr/Deb8Kv7dEYuw+zQoYJjWRToKJo5
         n9by/Nb3jwctZxGtyPVoaws7oY3qonBTt9wjL7phcW2qAqwvmv5EUBLHepMOgehZ/Ef/
         dy3meQlXhMf/zeYb1PtHSSIJQJ37+pAwsz/gOESvpkFkN2aw7IspEkaJXDjNJpU8cUgg
         iHVw==
X-Gm-Message-State: AJIora+6uaR17Au5kNMwBRkSXJhRVdB5TCmgLu2fXx5tknHZpRHzimyJ
        7bspBxGRDU7vS0HwVdDXpZPMPkK1waWBuJcpbRVthA==
X-Google-Smtp-Source: AGRyM1uW8d7u8cI7kXh+CMZlVyClyT59mSUoZvq0jSTf6qOyFJEip/9qYb6o+e+gCLI+yZIYr5R/SN3olWCh1e7tyUw=
X-Received: by 2002:a05:6512:22d3:b0:47d:a6e4:4232 with SMTP id
 g19-20020a05651222d300b0047da6e44232mr16064548lfu.671.1655802921771; Tue, 21
 Jun 2022 02:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <20220620150225.1307946-12-mw@semihalf.com>
 <YrC2oV1FiRKwir6u@smile.fi.intel.com>
In-Reply-To: <YrC2oV1FiRKwir6u@smile.fi.intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 21 Jun 2022 11:15:12 +0200
Message-ID: <CAPv3WKdYUZZAsF-7SzXfevexN8qzGJ0jqWRGM+522PHb0scQJg@mail.gmail.com>
Subject: Re: [net-next: PATCH 11/12] net: dsa: mv88e6xxx: switch to
 device_/fwnode_ APIs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        vivien.didelot@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

pon., 20 cze 2022 o 20:04 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Mon, Jun 20, 2022 at 05:02:24PM +0200, Marcin Wojtas wrote:
> > In order to support both ACPI and DT, modify the generic
> > DSA code to use device_/fwnode_ equivalent routines.
> > No functional change is introduced by this patch.
>
> ...
>
> > @@ -6962,16 +6963,16 @@ static int mv88e6xxx_probe(struct mdio_device *=
mdiodev)
> >       struct dsa_mv88e6xxx_pdata *pdata =3D mdiodev->dev.platform_data;
> >       const struct mv88e6xxx_info *compat_info =3D NULL;
> >       struct device *dev =3D &mdiodev->dev;
> > -     struct device_node *np =3D dev->of_node;
> > +     struct fwnode_handle *fwnode =3D dev->fwnode;
>
> Forgot to mention: dev_fwnode() or respective device_property_ API, pleas=
e.
>

I'll update changes to use the device_property_ API.

Thanks,
Marcin
