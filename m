Return-Path: <SRS0=W9bZ=EI=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CA7C2D0A3
	for <linux-acpi@archiver.kernel.org>; Mon,  2 Nov 2020 19:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995C722275
	for <linux-acpi@archiver.kernel.org>; Mon,  2 Nov 2020 19:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604345394;
	bh=FM7stTuGVVKeUuDGmh6qdwr4WG9CA321ftR7U9OqMgw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zGexjnrl9meVeeZQYvf0T9t9HcajdwyJRfuxtt+HN3kDa+85oH1rEdGfeu+mwZuvC
	 U3f11RLZQIiQ4PE20jIWowcnzUrtjz5Lub5fuD4PiQBWVgUJo9vljjM1xKtKzo/CjN
	 svajsk4h7nMPfQXE1Ro+vVGJIuOUJ/Zbby1fDpjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgKBT3y (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:29:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35898 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgKBT3x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Nov 2020 14:29:53 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so13724475otm.3
        for <linux-acpi@vger.kernel.org>; Mon, 02 Nov 2020 11:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+ihutsSLwFYNhbWezxwQqg+Vgzz3Evo917UlgYvj7g=;
        b=EEpVyETjcac/dGh1MIUunkuVEajmmQyTk16VDWsIrTs5eK3Q2UA01270howhb32V7n
         jvy7Qb6bj+h4vpXydt/UTa4fErpKXY5+WOE1C+Ty2u0M+QiwHvuqyImjoQB9/H+vYRbj
         x8jiZRgJo3OrnUTgm9EQODnQLy6020Xi/7BIet9zXkayV9aZap4H9GElzQH3Q850uX4X
         y6wKJQSdEnU+n9HOOCoZn1+a3oF5lkg/BI3l/mx3TcP8cfI17IUyz7Hu39vqVGRaYXNp
         5OaXvm1JOV3JZdBRCu6M1i/dzhAObLINyF3G4dsRAPSWm79bx6gfMU3KsUWr+Bt8XZB0
         tIjA==
X-Gm-Message-State: AOAM5323qZZAbKIM13Em60wsetmp8N9f0SGhpiuSoULz+sfvQxq2awta
        rfN5ESsMnRl/hXmr010EfY6ery8X7X3q5r1ZZKI=
X-Google-Smtp-Source: ABdhPJzEEBLX5n6pPnHFer7yaAUWFN4OzslbFgUfWnZPUjoI9RZn62N/ydMI6M0T2gRNVKPFCMIDxtqA+uqAlqqUaqY=
X-Received: by 2002:a9d:222f:: with SMTP id o44mr6510975ota.321.1604345393316;
 Mon, 02 Nov 2020 11:29:53 -0800 (PST)
MIME-Version: 1.0
References: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Nov 2020 20:29:42 +0100
Message-ID: <CAJZ5v0icu5NPU2uaMUBsnpOvNtMDsFYD+eFgTMDG5GK1aON=aQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] resource: introduce union(), intersection() API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 30, 2020 at 6:26 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Some users may want to use resource library to manage their own resources,
> besides existing users that open code union() and intersection()
> implementations.
>
> Provide a generic API for wider use.
>
> Changelog v3:
> - rebased on top of v5.10-rc1
> - dropped upstreamed dependencies
> - added Rb tag to the last patch (Mika)
>
> Andy Shevchenko (6):
>   resource: Simplify region_intersects() by reducing conditionals
>   resource: Group resource_overlaps() with other inline helpers
>   resource: Introduce resource_union() for overlapping resources
>   resource: Introduce resource_intersection() for overlapping resources

Feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the four patches above (and I've already ACKed the remaining two).

If you want me to pick up the series, it would be good to resend it
with CCs to linux-kernel and Greg KH.

Thanks!

>   PCI/ACPI: Replace open coded variant of resource_union()
>   ACPI: watchdog: Replace open coded variant of resource_union()
>
>  drivers/acpi/acpi_watchdog.c |  6 +-----
>  drivers/acpi/pci_root.c      |  4 +---
>  include/linux/ioport.h       | 34 +++++++++++++++++++++++++++-------
>  kernel/resource.c            | 10 +++++-----
>  4 files changed, 34 insertions(+), 20 deletions(-)
>
> --
