Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA7CC43334
	for <linux-acpi@archiver.kernel.org>; Tue,  5 Jul 2022 18:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiGESY1 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 5 Jul 2022 14:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiGESY0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jul 2022 14:24:26 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595DC15FE6;
        Tue,  5 Jul 2022 11:24:25 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31c89111f23so67332417b3.0;
        Tue, 05 Jul 2022 11:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5DQkzNjQz/4vp49g3ADoI4xuDSB+9/8InZKErLv94+w=;
        b=O7WkMavd7fF5Pv606dCSyNP6CoHYNZKuX+w/PHgGG2wJrKnJExOHHMyBuoyiH38OMd
         reSfSMdkR5smH2kq48bF/+4+nR5cU/wIzJMRedJ76Hf1nbbPJatxxDI9YB3a/efvblrk
         0OasRrnioNmrvQ7W605qQ7hqwyLgN35dkNIMNGPRj1PuOtxzHKYu2HLXunwAZDNaXGIg
         qiCYFj1fA4z1GAsV3BErLKUjVBpVEb1gcYq4iOD2xdJ1m1n99KLUvbL7fhS/SGwXcBfD
         KpT7ps9HPOWK0tAeWwCx/qMY9gaMDTqa1YTPMlEP4/gHbiBsfuPqNsIwym/MhYiRXHap
         mwwg==
X-Gm-Message-State: AJIora/+77X+ZhCn3bm9fX+J09WQtlycJJWCUf3vmXyGL9JC24AIkYlq
        qVoftxtFDBMMQ9vjPnCdoITPXi/Mxs6aADJiNBy347EQ
X-Google-Smtp-Source: AGRyM1s3MQGk1vxHUO+TD8bguf5JMzaxg/BOkmuaYjhh5D61R/nmIjIU2pqJVOu5QP6y0MBByRRXJlJyG9OA+KSnpvU=
X-Received: by 2002:a81:a184:0:b0:31c:b00e:b5c4 with SMTP id
 y126-20020a81a184000000b0031cb00eb5c4mr10080903ywg.149.1657045464483; Tue, 05
 Jul 2022 11:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220630022317.15734-1-gch981213@gmail.com> <b84edc24-0a3a-a4d2-6481-fb3d4cee6dda@amd.com>
 <CAJsYDVL=fgExYdw3JB-59rCwOqTbSt2N0Xw2WCmoTSzOQEMRRg@mail.gmail.com>
In-Reply-To: <CAJsYDVL=fgExYdw3JB-59rCwOqTbSt2N0Xw2WCmoTSzOQEMRRg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 20:24:13 +0200
Message-ID: <CAJZ5v0g7JOcYTwwLxPws38abn_EVGjG0+QY9E+qpM=guhF11tA@mail.gmail.com>
Subject: Re: [PATCH v5] ACPI: skip IRQ1 override on 3 Ryzen 6000 laptops
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Kent Hou Man <knthmn0@gmail.com>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 1, 2022 at 2:45 PM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> On Fri, Jul 1, 2022 at 4:12 AM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
> > However I do want to point out that Windows doesn't care about legacy
> > format or not.  This bug where keyboard doesn't work only popped up on
> > Linux.
> >
> > Given the number of systems with the bug is appearing to grow I wonder
> > if the right answer is actually a new heuristic that doesn't apply the
> > kernel override for polarity inversion anymore.  Maybe if the system is
> > 2022 or newer?  Or on the ACPI version?
>
> The previous attempt to limit the scope of IRQ override ends up
> breaking some other buggy devices:
> https://patchwork.kernel.org/project/linux-acpi/patch/20210728151958.15205-1-hui.wang@canonical.com/
>
> It's unfortunate that the original author of this IRQ override doesn't
> limit the scope to their exact devices.
>
> Hi, Rafael! What do you think? should we skip this IRQ override
> one-by-one or add a different matching logic to check the bios date
> instead?

It would be better to find something precise enough to identify the
machines in question without pulling in the others and use that for
skipping the override instead of listing them all one by one in the
blocklist.
