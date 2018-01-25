From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: use bitmap helper for masked GPEs
Date: Thu, 25 Jan 2018 17:31:35 +0100
Message-ID: <CAJZ5v0gU=8a1_FkztbSrqc64u7i7W2PCSf-KDf=+79kr1e38HA@mail.gmail.com>
References: <1516860867-6391-1-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34925 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbeAYQbg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jan 2018 11:31:36 -0500
Received: by mail-oi0-f68.google.com with SMTP id b11so5617955oif.2
        for <linux-acpi@vger.kernel.org>; Thu, 25 Jan 2018 08:31:36 -0800 (PST)
In-Reply-To: <1516860867-6391-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pmenzel+bugzilla.kernel.org@molgen.mpg.de

On Thu, Jan 25, 2018 at 7:14 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> "acpi_mask_gpe=" kernel parameter is introduced to mask one or more GPEs
> at boot stage, to prevent GPE flooding.
>
> Currently, a maximum of 128 GPEs (from GPE 0x00 to GPE 0x7f) are allowed
> to be masked by this kernel parameter, but only one u64 variant is used
> as the bitmap for the masked GPEs in kernel.
>
> This is bogus and makes some GPEs masked unexpected when masking a GPE
> larger than 0x40.

Commit 0f27cff8597d (ACPI: sysfs: Make ACPI GPE mask kernel parameter
cover all GPEs) in linux-next should cover this AFAICS.

Thanks,
Rafael
