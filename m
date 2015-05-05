From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / scan: Add a scan handler for PRP0001
Date: Tue, 05 May 2015 14:14:57 +0200
Message-ID: <1654400.V6HOKtoCaE@vostro.rjw.lan>
References: <3444888.xxxTREorHY@vostro.rjw.lan> <12683914.6j7dxAgR6V@vostro.rjw.lan> <20150505112425.GB1541@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150505112425.GB1541@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, May 05, 2015 02:24:25 PM Mika Westerberg wrote:
> On Tue, May 05, 2015 at 02:49:55AM +0200, Rafael J. Wysocki wrote:
> > 
> > Thanks, I have an update, though.
> > 
> > In a recent discussion with Darren we've come to the conlusion that
> > having a parent with PRP0001 and "compatible" and a child with PRP0001 only
> > (without "compatible") is useful in cases when one complex device is
> > represented by a hierarchy of "device" objects (in analogy with device
> > nodes in a DT that have no struct device representations).  Thus it isn't
> > useful to complain that "compatible" is not present in such cases.
> 
> OK, I see.
> 
> > Updated patch:
> > 
> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: ACPI / property: Refine consistency check for PRP0001
> > 
> > Refine the check for the presence of the "compatible" property
> > if the PRP0001 device ID is present in the device's list of
> > ACPI/PNP IDs to also print the message if _DSD is missing
> > entirely or the format of it is incorrect.
> > 
> > One special case to take into accout is that the "compatible"
> > property need not be provided for devices having the PRP0001
> > device ID in their lists of ACPI/PNP IDs if they are ancestors
> > of PRP0001 devices with the "compatible" property present.
> > This is to cover heriarchies of device objects where the kernel
> > is only supposed to use a struct device representation for the
> > topmost one and the others represent, for example, functional
> > blocks of a composite device.
> > 
> > While at it, reduce the log level of the message to "info"
> > and reduce the log level of the "broken _DSD" message to
> > "debug" (noise reduction).
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Still looks fine to me,
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!
