From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / property: Fix subnode lookup scope for data-only subnodes
Date: Thu, 22 Oct 2015 01:44:58 +0200
Message-ID: <3357380.Nnsq3b9RG3@vostro.rjw.lan>
References: <3607867.RKSpENdj9h@vostro.rjw.lan> <20151021132036.GC1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151021132036.GC1526@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <darren.hart@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, October 21, 2015 04:20:36 PM Mika Westerberg wrote:
> On Wed, Oct 21, 2015 at 01:51:24AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The correct scope for looking up the objects to generate data packages for
> > data-only subnodes pointed to by another data-only subnode is the scope
> > of the parent of that subnode and not the scope containing the _DSD object
> > at the top of the hierarchy (the latter works only if all of the objects
> > returning data-only subnode packages in a given hierarchy are in the same
> > scope).
> > 
> > Fix the code to work as expected.
> > 
> > Fixes: 445b0eb058f5 (ACPI / property: Add support for data-only subnodes)
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> All my tests still pass so you can also add
> 
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!
