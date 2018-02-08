From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/5] ACPI / bus: Return error code from
 __acpi_match_device() in one case
Date: Thu, 08 Feb 2018 17:59:08 +0200
Message-ID: <1518105548.22495.201.camel@linux.intel.com>
References: <20180207145610.88434-1-andriy.shevchenko@linux.intel.com>
         <CAJZ5v0gkn4keNLA4jyCDOjSB4EGhya0d7ecwo-4zDQ=+E9PnJA@mail.gmail.com>
         <1518104647.22495.195.camel@linux.intel.com>
         <CAJZ5v0gFM+g0TbwjQ4KzVFop60JgSDA9UuM-zuy=+HdDcG8sQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20944 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752422AbeBHP7M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Feb 2018 10:59:12 -0500
In-Reply-To: <CAJZ5v0gFM+g0TbwjQ4KzVFop60JgSDA9UuM-zuy=+HdDcG8sQQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thu, 2018-02-08 at 16:48 +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 8, 2018 at 4:44 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, 2018-02-08 at 16:14 +0100, Rafael J. Wysocki wrote:
> > > 

> > 
> > > Also the return value here means "success", so why is an error the
> > > right choice?
> > 
> > Because we need to return something which is not NULL. Naturally
> > feels
> > the error code, esp. ENODATA, is quite suitable. We indeed have no
> > data
> > in this case, and it's not a NULL case (not found / not match) — we
> > have
> > a match.
> 
> But this is an error code that means "success".  May I call it rather
> confusing?

This function AFAICS does two things at once:
- matches device against ID
- returns matched ID entry in the table

Return value combines those two into actually ternary option:
- no match
- match with ID
- match without ID

> > > Overall, this really looks like a preparation for a future patch,
> > > so
> > > why not just say that straight away in the changelog?
> > 
> > It's not _just_ a preparation, it mitigates the trick used in
> > mentioned
> > by Fixes tag commit.
> > 
> > I would rather update comment here, and add explanation to the
> > commit
> > message to be sure it covers tricks mitigation and preparation
> > purposes.
> 
> This is not mitigation, sorry.  It just replaces one possibly
> confusing thing with another.

I would agree here...

> The code as is works as I said and this patch doesn't make it any
> better as far as I'm concerned.

...but not here. Instead of returning pointer to *something* (from
caller point of view), we explicitly tell caller what of the above
happened. We don't rely on the organization  of ID table or its life
time (though it's forever).

I can say that is *slightly* better. But agree that is not cleanest
solution I can come up with.

I'm all ears on other possibilities how to get rid of that trick.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
