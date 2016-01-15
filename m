From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/4] Revert "thinkpad_acpi: Use acpi_video_handles_brightness_key_presses()"
Date: Fri, 15 Jan 2016 01:52:01 +0100
Message-ID: <5899370.z9zLpjS80K@vostro.rjw.lan>
References: <1452760908-15965-1-git-send-email-hdegoede@redhat.com> <1452760908-15965-4-git-send-email-hdegoede@redhat.com> <20160114231856.GA20294@malice.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59986 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757169AbcAOAvZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jan 2016 19:51:25 -0500
In-Reply-To: <20160114231856.GA20294@malice.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Adrien Schildknecht <adrien+dev@schischi.me>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thursday, January 14, 2016 03:18:56 PM Darren Hart wrote:
> On Thu, Jan 14, 2016 at 09:41:48AM +0100, Hans de Goede wrote:
> > acpi_video_handles_brightness_key_presses()'s may return false if the i915
> > driver is not loaded yet when thinkpad_acpi loads, and then return true
> > after the i915 driver has loaded. This means that thinkpad_acpi cannot
> > use it as is since thinkpad_acpi caches the return value.
> > 
> > This reverts commit 7714687a2b2d ("thinkpad_acpi: Use
> > acpi_video_handles_brightness_key_presses()").
> > 
> 
> Rafael, I presume this would go through your tree?

Yes, I'll take care of this, thanks!

> No objection from me. Henrique?
> 
> Acked-by: Darren Hart <dvhart@linux.intel.com>
> 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/platform/x86/thinkpad_acpi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> > index f453d5d..0bed473 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -3488,7 +3488,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
> >  	/* Do not issue duplicate brightness change events to
> >  	 * userspace. tpacpi_detect_brightness_capabilities() must have
> >  	 * been called before this point  */
> > -	if (acpi_video_handles_brightness_key_presses()) {
> > +	if (acpi_video_get_backlight_type() != acpi_backlight_vendor) {
> >  		pr_info("This ThinkPad has standard ACPI backlight "
> >  			"brightness control, supported by the ACPI "
> >  			"video driver\n");
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
