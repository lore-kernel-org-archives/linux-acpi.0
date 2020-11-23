Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219B7C56202
	for <linux-acpi@archiver.kernel.org>; Mon, 23 Nov 2020 13:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1DD820729
	for <linux-acpi@archiver.kernel.org>; Mon, 23 Nov 2020 13:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbgKWNrz (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 23 Nov 2020 08:47:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37586 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731059AbgKWNry (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 08:47:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id l36so15931587ota.4;
        Mon, 23 Nov 2020 05:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3tej0BVbGNgXXqLBi6eFeSbTYvypc++icM+5A67rGo=;
        b=Jhf7ak+hUqXL3MF2CrNDEgZseffaNGQ+n8Qcq8Fw0N5oE2sxA6ShOAJOJ/bstxaKTV
         L9UjC18p5si+r8IlZBLRIwt8UwqEdYrm2jkelXHCvjNJs+iS8fi3Y1k39Bovkx9j73mt
         feVtvasVL3I0IuPXTUtqH7zXClXuIaCJ6x8sNjlSbshHmhcc160Us4Fv+uk7JH7uvys/
         +jMM+Ad5DW/AKTf+671xK4QIVnAzY8w5ur1GtpUH1h+Ypgyl6bjA/D9qo+3hQPsn2Rgc
         t/AIK2DJST9NQOTCd9yYCtgz++VDHEnDsFfxwTvmceJZlNjSPCNonWZN7sqcGxA+9s1J
         Xk+A==
X-Gm-Message-State: AOAM530vAZgbiZPW84tgx+4WJrWHjHtBx6HPFnzwsqek3U324t/+40Pu
        /s+At/VFTMwy0SNXt/CiKfJuQOcCxs+IoiTrP+8=
X-Google-Smtp-Source: ABdhPJxqOt/7RzS22eDDvfkP2eCsJ8SidvkoFZGMYV1RecK4l2KEGlZ5wh7P5SQnbX8IWsosUQdFL4JVWq3K2XnmnFQ=
X-Received: by 2002:a05:6830:2385:: with SMTP id l5mr12771542ots.321.1606139274000;
 Mon, 23 Nov 2020 05:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20201119125801.719775-1-f.suligoi@asem.it> <20201119133939.GW3940@paasikivi.fi.intel.com>
In-Reply-To: <20201119133939.GW3940@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 14:47:43 +0100
Message-ID: <CAJZ5v0jDQyW9NEK2QeymY7TmL9_qPnyeBrMpSt7oH1oyaRwRjg@mail.gmail.com>
Subject: Re: [PATCH v1] docs: ACPI: dsd: enable hyperlink in final references
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Alexander A . Klimov" <grandmaster@al2klimov.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 19, 2020 at 2:40 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Thu, Nov 19, 2020 at 01:58:01PM +0100, Flavio Suligoi wrote:
> > For inline web links, no special markup are needed.
> >
> > Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
>
> Thanks!
>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Applied as 5.11 material, thanks!
