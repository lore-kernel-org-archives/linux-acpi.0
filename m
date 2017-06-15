From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/2] acpi/nfit: Add support of NVDIMM memory error
 notification in ACPI 6.2
Date: Thu, 15 Jun 2017 14:44:42 -0700
Message-ID: <CAPcyv4guO6dJO5xsQ=OMOY-s2j0X+xuN+zDwexsfc2wT7okniw@mail.gmail.com>
References: <20170608183658.24731-1-toshi.kani@hpe.com> <20170608183658.24731-2-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35121 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdFOVoo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jun 2017 17:44:44 -0400
Received: by mail-oi0-f42.google.com with SMTP id e11so15001653oia.2
        for <linux-acpi@vger.kernel.org>; Thu, 15 Jun 2017 14:44:43 -0700 (PDT)
In-Reply-To: <20170608183658.24731-2-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vishal L Verma <vishal.l.verma@intel.com>, Linda Knippers <linda.knippers@hpe.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jun 8, 2017 at 11:36 AM, Toshi Kani <toshi.kani@hpe.com> wrote:
> ACPI 6.2 defines a new ACPI notification value to NVDIMM Root Device
> in Table 5-169.
>
>  0x81 Unconsumed Uncorrectable Memory Error Detected
>       Used to pro-actively notify OSPM of uncorrectable memory errors
>       detected (for example a memory scrubbing engine that continuously
>       scans the NVDIMMs memory). This is an optional notification. Only
>       locations that were mapped in to SPA by the platform will generate
>       a notification.
>
> Add support of this notification value by initiating an ARS scan. This
> will find new error locations and add their badblocks information.
>

Looks good to me, applied.
