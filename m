From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: use bitmap helper for masked GPEs
Date: Fri, 26 Jan 2018 23:02:05 +0800
Message-ID: <1516978925.2752.0.camel@intel.com>
References: <1516860867-6391-1-git-send-email-rui.zhang@intel.com>
         <CAJZ5v0gU=8a1_FkztbSrqc64u7i7W2PCSf-KDf=+79kr1e38HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:15585 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753371AbeAZPCL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Jan 2018 10:02:11 -0500
In-Reply-To: <CAJZ5v0gU=8a1_FkztbSrqc64u7i7W2PCSf-KDf=+79kr1e38HA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pmenzel+bugzilla.kernel.org@molgen.mpg.de

On Thu, 2018-01-25 at 17:31 +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 25, 2018 at 7:14 AM, Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > "acpi_mask_gpe=" kernel parameter is introduced to mask one or more
> > GPEs
> > at boot stage, to prevent GPE flooding.
> > 
> > Currently, a maximum of 128 GPEs (from GPE 0x00 to GPE 0x7f) are
> > allowed
> > to be masked by this kernel parameter, but only one u64 variant is
> > used
> > as the bitmap for the masked GPEs in kernel.
> > 
> > This is bogus and makes some GPEs masked unexpected when masking a
> > GPE
> > larger than 0x40.
> Commit 0f27cff8597d (ACPI: sysfs: Make ACPI GPE mask kernel parameter
> cover all GPEs) in linux-next should cover this AFAICS.
> 
yes. please drop this one. Thanks.

-rui

> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
