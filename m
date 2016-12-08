From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/2] ACPI / osl: Propagate actual error code for kstrtoul()
Date: Thu, 8 Dec 2016 01:12:18 +0100
Message-ID: <CAJZ5v0gF7aM6NRXUhpbssBweCCs_LNwzVm4eVQvj5KKnbdKEuQ@mail.gmail.com>
References: <20161202174247.141284-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wj0-f179.google.com ([209.85.210.179]:35692 "EHLO
        mail-wj0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbcLHAMU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2016 19:12:20 -0500
Received: by mail-wj0-f179.google.com with SMTP id v7so375387267wjy.2
        for <linux-acpi@vger.kernel.org>; Wed, 07 Dec 2016 16:12:19 -0800 (PST)
In-Reply-To: <20161202174247.141284-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Fri, Dec 2, 2016 at 6:42 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> There is no need to override the error code returned by kstrtoul().
> Propagate it directly to the caller.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Both this and the [2/2] applied.

Thanks,
Rafael
