Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8C5C433F5
	for <linux-acpi@archiver.kernel.org>; Fri, 11 Feb 2022 16:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349703AbiBKQCJ (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:02:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbiBKQCJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Feb 2022 11:02:09 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB581A8;
        Fri, 11 Feb 2022 08:02:08 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id y8so9404165qtn.8;
        Fri, 11 Feb 2022 08:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Egm8X1HdRTMn1h+Ap+igxS6Vm6Emk3NxefEyMNjMarc=;
        b=RawDmHwAg4j8bBuFA2HpUDCDpbAOdP8mlsJ3NmckTp3/sCEkN/OWwwEqGtXYuRc7Ze
         PrMkrgJHutB4iNENxyo8aWlFg6rdptXwcK/mmSOQYwBLVjagNUCES9Ww1gB9Fnt9V4vy
         uZ1q/gl+9inc/09UAN9vdqA3wDOjMt5Y7E0+P910yAhUjsXIe2IFOa0gA69xnUEo+2PB
         QkaVT8WZRGAZsS/mwTDX7j25yd+vG7cmchvwDWE+hzmltIWvvllBQkRosmqoawCpgDTf
         7wt8HYauA6j3NpObCVLvLgatZ9+qxYsyD/BvS3sx3Wj4iyyxBukukCwNfRJMIP/Q+YK4
         esXQ==
X-Gm-Message-State: AOAM531pMYmjqmjZEreOlvKMq3bNlaG+fYyn/H9BAyFMdg4vKZQTY9A8
        wVx2RAHRdaHKkPXqtoeGLA==
X-Google-Smtp-Source: ABdhPJxpOibKHi/n4SQFxR19SVCTbOOIggP0E4/25rS7+vscA8bDmDouoof2mhTey6gOWvWNuhcNYQ==
X-Received: by 2002:ac8:5c45:: with SMTP id j5mr1544624qtj.255.1644595327516;
        Fri, 11 Feb 2022 08:02:07 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id f2sm12710811qti.61.2022.02.11.08.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:02:06 -0800 (PST)
Received: (nullmailer pid 433013 invoked by uid 1000);
        Fri, 11 Feb 2022 16:02:04 -0000
Date:   Fri, 11 Feb 2022 10:02:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 4/4] device property: Add irq_get to fwnode operation
Message-ID: <YgaIfMcPQrXmJx0V@robh.at.kernel.org>
References: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
 <20220206091643.276833-5-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206091643.276833-5-sakari.ailus@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, 06 Feb 2022 11:16:43 +0200, Sakari Ailus wrote:
> Add irq_get() fwnode operation to implement fwnode_irq_get() through
> fwnode operations, moving the code in fwnode_irq_get() to OF and ACPI
> frameworks.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 14 ++++++++++++++
>  drivers/base/property.c | 12 +-----------
>  drivers/of/property.c   |  7 +++++++
>  include/linux/fwnode.h  |  1 +
>  4 files changed, 23 insertions(+), 11 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
