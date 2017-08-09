From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 0/3] Refactor GHES to better support non-APEI systems
Date: Wed, 09 Aug 2017 10:24:36 +0100
Message-ID: <87d185qejv.fsf@e105922-lin.cambridge.arm.com>
References: <20170801133608.21017-1-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44730 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752548AbdHIJYi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Aug 2017 05:24:38 -0400
In-Reply-To: <20170801133608.21017-1-punit.agrawal@arm.com> (Punit Agrawal's
        message of "Tue, 1 Aug 2017 14:36:05 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

Punit Agrawal <punit.agrawal@arm.com> writes:

> Hi,
>
> The small series re-factors the GHES driver initialisation to move
> memory allocation and checks from driver init to device probe. The net
> effect is to improve the situation for systems that do not support
> APEI.
>
> The patches are organised as -
>
> * Unify estatus pool creation and expansion into ghes_estatus_pool_init()
> * Move memory initialisation and firmware first support checks from
>   driver init to device probe
> * Do not set hest_disable if HEST not found
>
> The set of patches initially started out as a single patch[0]. The
> current series is the re-worked approach based on ensuing
> discussion. They patches are based on v4.13-rc3 and have been tested
> on a system that does not support APEI. Further testing on systems
> that support APEI to ensure that the changes do not break expected
> behaviour will be greatly appreciated.

Ping!

Boris, have you had a chance to look at the re-factoring of the GHES init?

>
> Thanks,
> Punit
>
> [0] https://lkml.org/lkml/2017/7/20/430
>
> Punit Agrawal (3):
>   GHES: Expand the estatus pool in ghes_estatus_pool_init()
>   GHES: Move memory initialisation to ghes_probe()
>   ACPI / APEI: HEST: Don't set hest_disable if table not found
>
>  drivers/acpi/apei/ghes.c | 132 ++++++++++++++++++++++++++---------------------
>  drivers/acpi/apei/hest.c |   2 +-
>  2 files changed, 73 insertions(+), 61 deletions(-)
