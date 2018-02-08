From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/5] ACPI / bus: Return error code from
 __acpi_match_device() in one case
Date: Thu, 08 Feb 2018 17:44:07 +0200
Message-ID: <1518104647.22495.195.camel@linux.intel.com>
References: <20180207145610.88434-1-andriy.shevchenko@linux.intel.com>
         <CAJZ5v0gkn4keNLA4jyCDOjSB4EGhya0d7ecwo-4zDQ=+E9PnJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:54801 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeBHPoK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Feb 2018 10:44:10 -0500
In-Reply-To: <CAJZ5v0gkn4keNLA4jyCDOjSB4EGhya0d7ecwo-4zDQ=+E9PnJA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thu, 2018-02-08 at 16:14 +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 7, 2018 at 3:56 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Instead of playing tricks with last invalid entry,
> > return simple -ENODATA error code cast to pointer.
> > 
> > It would be good for future in case caller passes NULL pointer for
> > ID table. Moreover, caller can check the code to be sure what
> > happened
> > inside callee.
> > 
> > Fixes: 2b9c698efa58 ("ACPI / scan: Take the PRP0001 position in the
> > list of IDs into account")
> 
> I still don't think the Fixes: tag here is valid (the code works as is
> AFAICS), but I could drop it when applying the patch just fine. :-)

OK.

> >                 if (!strcmp(ACPI_DT_NAMESPACE_HID, hwid->id)
> >                     && acpi_of_match_device(device, of_ids))
> > -                       return id;
> > +                       return ERR_PTR(-ENODATA);
> 
> Doesn't the comment above need to be updated?

Will do.

> Also the return value here means "success", so why is an error the
> right choice?

Because we need to return something which is not NULL. Naturally feels
the error code, esp. ENODATA, is quite suitable. We indeed have no data
in this case, and it's not a NULL case (not found / not match) — we have
a match.


> Overall, this really looks like a preparation for a future patch, so
> why not just say that straight away in the changelog?

It's not _just_ a preparation, it mitigates the trick used in mentioned
by Fixes tag commit.

I would rather update comment here, and add explanation to the commit
message to be sure it covers tricks mitigation and preparation purposes.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
