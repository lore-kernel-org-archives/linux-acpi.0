From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/10] ACPI enumeration rework (was: Re: [PATCH V7 00/11] ACPI: ACPI enumeration rework)
Date: Sun, 01 Jun 2014 00:29:25 +0200
Message-ID: <4327383.giQbFNxxAk@vostro.rjw.lan>
References: <1400781753-2682-1-git-send-email-rui.zhang@intel.com> <35042328.kk6ZUUdfyN@vostro.rjw.lan> <1401547596.2426.4.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401547596.2426.4.camel@rzhang1-toshiba>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, matthew.garrett@nebula.com, mika.westerberg@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

On Saturday, May 31, 2014 10:46:36 PM Zhang Rui wrote:
> On Fri, 2014-05-30 at 04:20 +0200, Rafael J. Wysocki wrote:
> > On Friday, May 23, 2014 02:02:22 AM Zhang Rui wrote:
> > > Hi, all,
> > > 
> > > Currently, PNP bus is used as the default bus for for enumerating ACPI
> > > devices with _HID/_CID.
> > > For a device that needs to be enumerated to platform bus, we need to add
> > > its id string to the platform scan handler white list explicitly.
> > > 
> > > This becomes a problem as more and more _HID devices need to be
> > > enumerated to platform bus nowadays, thus the list is continuously growing.
> > > 
> > > So, a solution that uses platform bus for _HID enumeration by default
> > > is preferred.
> > > 
> > 
> > OK, this has had several rounds of review already and we're really starting
> > to run out of time with it, so my version of this patchset follows.
> > 
> > It is mostly based on your patches, but reordered and with some major
> > changes.  Compiled only for now, so please let me know if there's any
> > breakage in it.  [The last patch will not apply without update of the
> > device list being removed, but generally this is on top of linux-next
> > material.]
> > 
> Applied the patch set on top of linux-pm tree linux-next branch, with
> some modifications of Patch 9/10 because of the updated lpss id list,
> it works as expected on an IVB Ultrabook.
> 
> Tested-by: Zhang Rui <rui.zhang@intel.com>

Thanks for doing that, much appreciated!

Rafael
