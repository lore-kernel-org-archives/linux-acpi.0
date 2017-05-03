From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/1] of: Move OF property and graph API from base.c to property.c
Date: Wed, 3 May 2017 15:19:13 -0500
Message-ID: <CAL_JsqKOnhaHW=GihiuaM6m8TjmREKNJsJaAaW96bKYmy=2MeQ@mail.gmail.com>
References: <1493806898-5409-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752771AbdECUTi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 May 2017 16:19:38 -0400
In-Reply-To: <1493806898-5409-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>

On Wed, May 3, 2017 at 5:21 AM, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> base.c contains both core OF functions and increasingly other
> functionality such as accessing properties and graphs, including
> convenience functions. In the near future this would also include OF
> specific implementation of the fwnode property and graph APIs.
>
> Create driver/of/property.c to contain procedures for accessing and
> interpreting device tree properties. The procedures are moved from
> drivers/of/base.c, with no changes other than copying only the includes
> required by the moved procedures.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Hi Rob and Frank,
>
> This is a pre-dependency for further fwnode property cleanup. The patch
> appears to be slightly more conflict-prone than the rest of the patchset:
>
> <URL:http://www.spinics.net/lists/linux-acpi/msg72647.html>
>
> Would it be possible to merge it separately from the rest?

Yes, but not now in the middle of the merge window. Maybe towards the
end of the merge window for 4.12. Or it's not going to be until 4.13.

Rob
