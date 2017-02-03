From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 3/4] device property: export code duplicating array of
 property entries
Date: Fri, 3 Feb 2017 07:15:52 -0800
Message-ID: <20170203151552.GC3868@dtor-ws>
References: <20170203014128.317-1-dmitry.torokhov@gmail.com>
 <20170203014128.317-4-dmitry.torokhov@gmail.com>
 <1486122330.2133.374.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33899 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdBCPQB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2017 10:16:01 -0500
Content-Disposition: inline
In-Reply-To: <1486122330.2133.374.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

On Fri, Feb 03, 2017 at 01:45:30PM +0200, Andy Shevchenko wrote:
> On Thu, 2017-02-02 at 17:41 -0800, Dmitry Torokhov wrote:
> > When augmenting ACPI-enumerated devices with additional property data
> > based
> > on DMI info, a module has often several potential property sets, with
> > only
> > one being active on a given box. In order to save memory it should be
> > possible to mark everything and __initdata or __initconst, execute DMI
> > match early, and duplicate relevant properties. Then kernel will
> > discard
> > the rest of them.
> > 
> 
> Here you again rewrote the code you rewrote in previous patch.
> Please, remove those hunks in previous patch and rebase this one on top
> of the result.

I do no see the point really. If I am not exposing the new APIs then
there is no point in touching the code. If I am creating new API then I
do not want to go through contortion of producing something similar to
the old code flow just to "fix" it in the subsequent patch.

Thanks.

-- 
Dmitry
