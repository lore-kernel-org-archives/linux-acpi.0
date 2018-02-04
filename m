From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 4/6] ACPI / bus: Rename acpi_get_match_data() to acpi_device_get_match_data()
Date: Sun, 4 Feb 2018 08:23:05 +0100
Message-ID: <CAJZ5v0hssSqBDE8emBqKFQn9gXK1dBJwB4L0y=M5===YUXjTbQ@mail.gmail.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com> <20180201202012.36524-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:41353 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbeBDHXG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Feb 2018 02:23:06 -0500
In-Reply-To: <20180201202012.36524-4-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thu, Feb 1, 2018 at 9:20 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Do the renaming to be consistent with its sibling, i.e.
> of_device_get_match_data().
>
> No functional change.
>
> Fixes: 80212a162329 ("ACPI / bus: Introduce acpi_get_match_data() function")
> Fixes: 146b4dbb0eef ("ACPI: properties: Implement get_match_data() callback")

Why are you adding the Fixes: tags to a patch that doesn't make any
functional changes?

What are they useful for?
