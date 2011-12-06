From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [BUG] i915/intel-acpi.c: failed to get supported _DSM
 functions (was: [Dual-LVDS Acer Iconia laptop] i915/DRM issue: one screen
 stays off)
Date: Tue, 6 Dec 2011 13:46:07 +0000
Message-ID: <20111206134607.GA11462@srcf.ucam.org>
References: <20111204160728.GA27292@archminux>
 <1323054041.6046.79.camel@linux-s257.site>
 <20111205205647.GA1757@archminux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111205205647.GA1757@archminux>
Sender: platform-driver-x86-owner@vger.kernel.org
To: intel-gfx@lists.freedesktop.org, joeyli <jlee@suse.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 05, 2011 at 09:56:47PM +0100, Baptiste Jonglez wrote:
> CC-ing intel-gfx@lists.freedesktop.org (see below)
> On Mon, Dec 05, 2011 at 11:00:41AM +0800, joeyli wrote:
> > >   [drm:intel_dsm_pci_probe] *ERROR* failed to get supported _DSM functions
> > > 
> > > (attached is the relevant part of dmesg [1])
> > > 
> > > 
> > 
> > Have no idea for this _DSM error, need help from drm and acpi experts.
> 
> It definitely looks like an ACPI issue.
> That function is defined in `drivers/gpu/drm/i915/intel_acpi.c'.
> The whole file was added more than a year ago by commit 723bfd707a97
> (see the relevant thread on intel-gfx@ [1]) to "add _DSM support".
> One of the first comment is about "Calpella", which is exactly the
> platform of my laptop (as shown by lshw)

Ignore that - it's entirely harmless.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
