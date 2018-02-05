From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/6] ACPI / bus: Do not traverse through non-existed
 device table
Date: Mon, 05 Feb 2018 17:56:47 +0200
Message-ID: <1517846207.22495.28.camel@linux.intel.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
         <20180201202012.36524-2-andriy.shevchenko@linux.intel.com>
         <68fea449-6478-3d6d-addf-79925ca62931@codeaurora.org>
         <1517517646.7000.1446.camel@linux.intel.com>
         <1517517921.7000.1447.camel@linux.intel.com>
         <CAJZ5v0gBzP+QGs5zj25N7DQpBnAyqzmDeeVL4mjK1cns4Jyh1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20944 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752767AbeBEP4v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Feb 2018 10:56:51 -0500
In-Reply-To: <CAJZ5v0gBzP+QGs5zj25N7DQpBnAyqzmDeeVL4mjK1cns4Jyh1g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Sun, 2018-02-04 at 08:18 +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 1, 2018 at 9:45 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, 2018-02-01 at 22:40 +0200, Andy Shevchenko wrote:
> > > On Thu, 2018-02-01 at 15:32 -0500, Sinan Kaya wrote:
> > > > On 2/1/2018 3:20 PM, Andy Shevchenko wrote:
> > > > > When __acpi_match_device() is called it would be possible to
> > > > > have
> > > > > ACPI ID table a MULL pointer. To avoid potential dereference,
> > > > 
> > > > NULL
> > > 
> > > Thanks, will fix later.
> > > 
> > > > Why not bail out here immediately if ids is null?
> > > 
> > > Because of the code which wasn't in context of this patch.
> > > 
> > > See also patch 1 in the series.
> > > 
> > > It's about how acpi_driver_match_device() uses it.
> > 
> > Btw, it makes device_get_match_data() to work properly on PRP0001
> > kind
> > of devices.
> 
> Maybe combine this one with the [1/6] then, it would make it somewhat
> easier to follow what's going on.

Sure, I will fold in.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
