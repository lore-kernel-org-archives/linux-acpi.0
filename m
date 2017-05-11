From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] Revert "ACPI / button: Change default behavior to
 lid_init_state=open"
Date: Thu, 11 May 2017 11:45:51 +0200
Message-ID: <20170511094551.GF30987@mail.corp.redhat.com>
References: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
 <20170510161240.13229-3-benjamin.tissoires@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA1274@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdEKJp5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 May 2017 05:45:57 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CEA1274@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Jiri Eischmann <jeischma@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On May 11 2017 or thereabouts, Zheng, Lv wrote:
> Hi,
> 
> > From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> > Subject: [PATCH 2/2] Revert "ACPI / button: Change default behavior to lid_init_state=open"
> > 
> > This reverts commit 77e9a4aa9de10cc1418bf9a892366988802a8025.
> > 
> > Even if the method implementation can be buggy on some platform,
> > the "open" choice is worse. It breaks docking stations basically
> > and there is no way to have a user-space hwdb to fix that.
> > 
> > On the contrary, it's rather easy in user-space to have a hwdb
> > with the problematic platforms. Then, libinput (1.7.0+) can fix
> > the state of the LID switch for us: you need to set the udev
> > property LIBINPUT_ATTR_LID_SWITCH_RELIABILITY to 'write_open'.
> > 
> > When libinput detects internal keyboard events, it will
> > overwrite the state of the switch to open, making it reliable
> > again. Given that logind only checks the LID switch value after
> > a timeout, we can assume the user will use the internal keyboard
> > before this timeout expires.
> > 
> > For example, such a hwdb entry is:
> > 
> > libinput:name:*Lid Switch*:dmi:*svnMicrosoftCorporation:pnSurface3:*
> >  LIBINPUT_ATTR_LID_SWITCH_RELIABILITY=write_open
> 
> For the reason mentioned previously and proofs here (see patch descriptions):
> https://patchwork.kernel.org/patch/9717111/

I am not sure you can call this proofs. The "close" state is IMO the
exact same as the "method" one, it's just that the intel driver
triggers the evaluation of the _LID method, not acpi/button.c.

And remember that this new default prevents userspace to fix it because
it's rather easy to detect that the device is actually opened (input
events coming from interanl keyboard, touchscreen, or touchpad), while
reporting the lid switch as open means we can't know if the user is
simply not using the internal devices, or if we have just a wrong state.

Given that this patch breaks all Lenovos with a dock (I can guess that 6
lines this year are using docks, and within each line you have 2-5
variants), I'd suggest we do not break those existing laptops and just
revert this patch.

I would think other OEMs have a docking station with an actual power
button but I can't be sure by looking at the product pages.

> We shouldn't do this.

I strongly disagree.

I am fine if you don't want to have a blacklist in the kernel for the
devices that are problematic (the ones that require open), but please
don't prevent user space to have this blacklist and please do not make
false assumptions in the kernel on the state of a switch. This is worse
than it helps and in the end, user space won't be able to solve this if
you change the default behavior at each release.

Cheers,
Benjamin

> 
> Thanks and best regards
> Lv
> 
> > 
> > Link: https://bugzilla.gnome.org/show_bug.cgi?id=782380
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >  drivers/acpi/button.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> > index 6d5a8c1..e19f530 100644
> > --- a/drivers/acpi/button.c
> > +++ b/drivers/acpi/button.c
> > @@ -113,7 +113,7 @@ struct acpi_button {
> > 
> >  static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
> >  static struct acpi_device *lid_device;
> > -static u8 lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
> > +static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
> > 
> >  static unsigned long lid_report_interval __read_mostly = 500;
> >  module_param(lid_report_interval, ulong, 0644);
> > --
> > 2.9.3
> 
