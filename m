From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 3/4] device property: export code duplicating array
 of property entries
Date: Fri, 03 Feb 2017 13:45:30 +0200
Message-ID: <1486122330.2133.374.camel@linux.intel.com>
References: <20170203014128.317-1-dmitry.torokhov@gmail.com>
         <20170203014128.317-4-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:62991 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752372AbdBCLse (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Feb 2017 06:48:34 -0500
In-Reply-To: <20170203014128.317-4-dmitry.torokhov@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

On Thu, 2017-02-02 at 17:41 -0800, Dmitry Torokhov wrote:
> When augmenting ACPI-enumerated devices with additional property data
> based
> on DMI info, a module has often several potential property sets, with
> only
> one being active on a given box. In order to save memory it should be
> possible to mark everything and __initdata or __initconst, execute DMI
> match early, and duplicate relevant properties. Then kernel will
> discard
> the rest of them.
> 

Here you again rewrote the code you rewrote in previous patch.
Please, remove those hunks in previous patch and rebase this one on top
of the result.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
