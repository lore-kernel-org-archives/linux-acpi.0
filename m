From: Baptiste Jonglez <baptiste@jonglez.org>
Subject: Re: [Dual-LVDS Acer Iconia laptop] i915/DRM issue: one screen stays
 off [3.2-rc4+]
Date: Sun, 11 Dec 2011 17:30:37 +0100
Message-ID: <20111211163037.GA11920@archminux>
References: <20111204160728.GA27292@archminux>
 <1323054041.6046.79.camel@linux-s257.site>
 <20111206215137.GA20907@archminux>
 <CAN+gG=EaG1h=seuKQa_SF2O033WWn52USh=tjO9F9O55DgH17Q@mail.gmail.com>
 <20111206223109.GA1867@archminux>
 <CAN+gG=FoxDg3O5VSVkZEPGn4cVE=SJ4MUfvCgnYiB8vJGTLKmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAN+gG=FoxDg3O5VSVkZEPGn4cVE=SJ4MUfvCgnYiB8vJGTLKmQ@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: joeyli <jlee@suse.com>, Baptiste Jonglez <baptiste@jonglez.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>, intel-gfx@lists.freedesktop.org, Mathieu Magnaudet <mathieu.magnaudet@enac.fr>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 08, 2011 at 11:11:22AM +0100, Benjamin Tissoires wrote:
> Hi,
> 
> On Tue, Dec 6, 2011 at 23:31, Baptiste Jonglez <baptiste@jonglez.org> wrote:
> > On Tue, Dec 06, 2011 at 11:12:26PM +0100, Benjamin Tissoires wrote:
> >> Hi Baptiste,
> >
> > Hi,
> >
> >> On Tue, Dec 6, 2011 at 22:51, Baptiste Jonglez <baptiste@jonglez.org> wrote:
> >> > The second screen works fine with the attached patch. It actually is
> >> > 6 months old but seems to have been lost in the wild...
> >>
> >> You don't have the problem of the second backlight still off?
> >> On our Iconia, we need to trigger a special DMI command to set it up
> >> (SDSS, IIRC).
> >
> > No, with the patch, it worked out-of-the-box.
> 
> mmm, this is weird. We must not have the same bios or device version.
> We need to explicitly set the LCD2 up.

The version of our BIOS is 1.01, dated from 12/23/2010.


Do you think there's any chance these patches will make it to the 3.2
kernel? I guess you want to make sure your second patch works fine
before...

Baptiste
