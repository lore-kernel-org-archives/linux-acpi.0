Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82517C433EF
	for <linux-acpi@archiver.kernel.org>; Mon, 27 Jun 2022 13:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiF0Ndz (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 27 Jun 2022 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbiF0Ndx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jun 2022 09:33:53 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A9A6362;
        Mon, 27 Jun 2022 06:33:52 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id p136so10567648ybg.4;
        Mon, 27 Jun 2022 06:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztN9msliEJWcvQDVWkbiAiIE0Z0BrDUarJzwnIGzjC8=;
        b=YMw94vLB9C1PkhH+V5lHE0rNhfmHkWJaK7kt3QhDenuKQWmlOhucJzTRK/EJtRlOFz
         Z4g2MghMccb9BofygtQjvq9OZgzYxk5XUnE7BXcjXcLBe4fOgiG0T1uSsEyF7pZ/y5D7
         Y0K5AhY2xgiMGskIMtjl3Bpz1fq/5WMAm9q4KnXqQmTB2pC/oVHN+vCICvOAB0CUOOAZ
         X45fPwpS13QQljWbylupAd+bnSCQzSFaqS4Cb1g9VuESufeKYg+m6uj9B4mBZ0kKkpaD
         eflb54zIg/XuaGOsi2kHXC2eRHI1/6KM94dep+34aylNVoV+BKMGGFWugk3tp01FQTKE
         xCpw==
X-Gm-Message-State: AJIora/VDoTB+FIrujhlgzNanPht2ZH2YhFobQkIuZabib40fWX4f1x+
        0F3W2HZ7imnzrF99EXiVjNyEgw0YG0bu/Wmt0uTjOpZGsaQ=
X-Google-Smtp-Source: AGRyM1u6nXPXMKry/ijjdna0qNq6kJB5nE2ej9khpTTJLBr+PLqFMi0SnjuJi+npHJWR1euI7/M9kBb9E9n/NceMoqk=
X-Received: by 2002:a25:9004:0:b0:66c:97a4:3053 with SMTP id
 s4-20020a259004000000b0066c97a43053mr10112879ybl.137.1656336831002; Mon, 27
 Jun 2022 06:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc> <b8ec04dc-f803-ee2c-29b7-b0311eb8c5fb@linaro.org>
In-Reply-To: <b8ec04dc-f803-ee2c-29b7-b0311eb8c5fb@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jun 2022 15:33:37 +0200
Message-ID: <CAJZ5v0jz=ee5TrvYs0_ovWn9sT06bcKDucmmocD8L-d9ZZ5DzQ@mail.gmail.com>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 27, 2022 at 3:08 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/06/2022 14:49, Michael Walle wrote:
> > Hi,
> >
> > I tired to iterate over all child nodes, regardless if they are
> > available
> > or not. Now there is that handy fwnode_for_each_child_node() (and the
> > fwnode_for_each_available_child_node()). The only thing is the OF
> > backend
> > already skips disabled nodes [1], making fwnode_for_each_child_node()
> > and
> > fwnode_for_each_available_child_node() behave the same with the OF
> > backend.
> >
> > Doesn't seem to be noticed by anyone for now. I'm not sure how to fix
> > that
> > one. fwnode_for_each_child_node() and also fwnode_get_next_child_node()
> > are
> > used by a handful of drivers. I've looked at some, but couldn't decide
> > whether they really want to iterate over all child nodes or just the
> > enabled
> > ones.
>
> If I get it correctly, this was introduced  by 8a0662d9ed29 ("Driver
> core: Unified interface for firmware node properties")
> .

Originally it was, but then it has been reworked a few times.

The backend callbacks were introduced by Sakari, in particular.

> The question to Rafael - what was your intention when you added
> device_get_next_child_node() looking only for available nodes?

That depends on the backend.

fwnode_for_each_available_child_node() is more specific and IIRC it
was introduced for fw_devlink (CC Saravana).

> My understanding is that this implementation should be consistent with
> OF implementation, so fwnode_get_next_child_node=get any child.

IIUC, the OF implementation is not consistent with the
fwnode_get_next_child_node=get any child thing.

> However maybe ACPI treats it somehow differently?

acpi_get_next_subnode() simply returns the next subnode it can find.
