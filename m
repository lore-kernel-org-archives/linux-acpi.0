From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 2/5] ACPI / bus: Do not traverse through non-existed
 device table
Date: Thu, 08 Feb 2018 18:13:03 +0200
Message-ID: <1518106383.22495.206.camel@linux.intel.com>
References: <20180207145610.88434-1-andriy.shevchenko@linux.intel.com>
         <20180207145610.88434-2-andriy.shevchenko@linux.intel.com>
         <CAJZ5v0iEB74dPUN400pfB4+AV--NZj7hs6aZGiSoSiz5cTS37g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:64257 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeBHQNG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Feb 2018 11:13:06 -0500
In-Reply-To: <CAJZ5v0iEB74dPUN400pfB4+AV--NZj7hs6aZGiSoSiz5cTS37g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thu, 2018-02-08 at 16:59 +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 7, 2018 at 3:56 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > When __acpi_match_device() is called it would be possible to have
> > ACPI ID table a MULL pointer. To avoid potential dereference,
> > check for this before traverse.
> > 
> > While here, remove redundant 'else'.
> > 
> > 

> > +               if (ids) {
> > +                       for (id = ids; id->id[0] || id->cls; id++) {
> > +                               if (id->id[0] && !strcmp((char *)id-
> > >id, hwid->id))
> > +                                       return id;
> > +                               if (id->cls &&
> > __acpi_match_device_cls(id, hwid))
> > +                                       return id;
> > +                       }
> > 
> 

> The return value below should be updated in *this* patch, because this
> is what allows ids to be NULL in the first place.

OK, so I'll fold it into patch 1 then.

> And as far as I'm concerned you can do:
> 
> if (!strcmp(ACPI_DT_NAMESPACE_HID, hwid->id)
>         return (const struct acpi_device_id
> *)acpi_of_match_device(device, of_ids);
> 
> and update the comment accordingly.

But it's still a trick.

Okay, what comes to my mind (yes, not so simple, but cleaner I suppose)
is to define

struct acpi_of_device_id {
  struct acpi_device_id *acpi_id;
  struct of_device_id *of_id;
};

Add a new parameter to acpi_of_match_device(..., struct
acpi_of_device_id *id).


Update __acpi_match_device() in the similar way.

Update callers.

It looks to me much more cleaner.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
