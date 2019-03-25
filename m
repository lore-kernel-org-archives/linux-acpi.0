From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] Documentation: acpi: Add an example for PRP0001
Date: Mon, 25 Mar 2019 12:05:02 +0200
Message-ID: <20190325100502.GG3622@lahna.fi.intel.com>
References: <20190322134705.27994-1-thomas.preston@codethink.co.uk>
 <CAJZ5v0isa7x+XPAregcKtMxtgsNw43JuBhGB_1x3eHkvaV8HRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0isa7x+XPAregcKtMxtgsNw43JuBhGB_1x3eHkvaV8HRg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Preston <thomas.preston@codethink.co.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 25, 2019 at 10:31:13AM +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 22, 2019 at 2:47 PM Thomas Preston
> <thomas.preston@codethink.co.uk> wrote:
> >
> > Add an example for the magic PRP0001 device ID which allows matching
> > ACPI devices against drivers using OF Device Tree compatible property.
> > It wasn't clear to me that PRP0001 could be used in _CID.
> 
> Mika, Andy, can you have a look at this, please?

Looks good to me.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
