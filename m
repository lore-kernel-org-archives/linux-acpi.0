From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/6] ACPI / bus: Do not traverse through non-existed
 device table
Date: Mon, 05 Feb 2018 17:59:29 +0200
Message-ID: <1517846369.22495.30.camel@linux.intel.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
         <20180201202012.36524-2-andriy.shevchenko@linux.intel.com>
         <68fea449-6478-3d6d-addf-79925ca62931@codeaurora.org>
         <1517517646.7000.1446.camel@linux.intel.com>
         <1517517921.7000.1447.camel@linux.intel.com>
         <CAJZ5v0gBzP+QGs5zj25N7DQpBnAyqzmDeeVL4mjK1cns4Jyh1g@mail.gmail.com>
         <1517846207.22495.28.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21084 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753017AbeBEP7c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Feb 2018 10:59:32 -0500
In-Reply-To: <1517846207.22495.28.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Mon, 2018-02-05 at 17:56 +0200, Andy Shevchenko wrote:
> On Sun, 2018-02-04 at 08:18 +0100, Rafael J. Wysocki wrote:
> > On Thu, Feb 1, 2018 at 9:45 PM, Andy Shevchenko
> > 

> > Maybe combine this one with the [1/6] then, it would make it
> > somewhat
> > easier to follow what's going on.
> 
> Sure, I will fold in.

Ah, wait, they have different Fixes tag. One goes deeply down in the
history.

So, I can instead put more explanations in patch 1.
Would it work?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
