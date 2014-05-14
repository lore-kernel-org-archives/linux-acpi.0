From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi-video: Add use native backlight quirk for the ThinkPad W530
Date: Wed, 14 May 2014 14:07:19 +0200
Message-ID: <10229147.lKkebpiMVB@vostro.rjw.lan>
References: <1399881432-26124-1-git-send-email-hdegoede@redhat.com> <5370AA2C.1080506@redhat.com> <53734EED.5070807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <53734EED.5070807@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, May 14, 2014 01:09:33 PM Hans de Goede wrote:
> Hi,
> 
> On 05/12/2014 01:02 PM, Hans de Goede wrote:
> > Hi,
> > 
> > On 05/12/2014 10:16 AM, Aaron Lu wrote:
> >> On 05/12/2014 03:57 PM, Hans de Goede wrote:
> >>> Like all of the other *30 ThinkPad models, the W530 has a broken acpi-video
> >>> backlight control. Note in order for this to actually fix things on the
> >>> ThinkPad W530 the commit titled:
> >>> "nouveau: Don't check acpi_video_backlight_support() before registering backlight"
> >>> is also needed.
> >>
> >> Note that the backlight_device_registered(raw) may return false as when
> >> acpi_video_verify_backlight_support is called, the nouveau driver may
> >> not run yet.
> >>
> >> Previously, we don't know anything about how laptops with nvidia graphics
> >> card alone control backlight in Win8, so the existing solution doesn't
> >> consider this case. If nvidia graphics system also should favour native
> >> backlight control interface in Win8, the current solution needs
> >> modifications.
> > 
> > Hmm, how is this dealt with in the case of the intel gfx driver ?
> 
> Ok, I've figured out now how this is dealt with in the case of the intel gfx
> drivers. That looks like something which will likely be hard to do for
> nouveau, since it relies on some intel gfx specific ACPI calls being there,
> which nouveau does not have. So this would require doing something like
> duplicating the nouveau pci-ids or some such, which would be far from ideal.
> 
> Still this bug: https://bugzilla.redhat.com/show_bug.cgi?id=1093171
> 
> Shows that we need *working* video.use_native_brightness=1 support for
> non intel too. Which the current loading order issues caused by the
> backlight_device_registered(raw) breaks.
> 
> So maybe we should simply drop the backlight_device_registered(raw) check?
> I don't think we really need it any win8 supporting laptop will have
> intel, nv or ati gfx, and all 3 of them have native backlight support,
> which if our experiences so far is any indication we will likely want
> to use instead of acpi_video.

We can try that, but if it turns out to break things for someone, we'll need
a different approach.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
