From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/3] ACPI / X86: Add KIOX000A accelerometer on GPD win
 to always_present_ids array
Date: Mon, 10 Jul 2017 13:29:30 +0300
Message-ID: <1499682570.22624.321.camel@linux.intel.com>
References: <20170709190514.3437-1-hdegoede@redhat.com>
         <20170709190514.3437-3-hdegoede@redhat.com>
         <1499682140.22624.318.camel@linux.intel.com>
         <03da3e2a-0a81-e4b8-092e-211d2f08cf93@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14042 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753196AbdGJK3e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 06:29:34 -0400
In-Reply-To: <03da3e2a-0a81-e4b8-092e-211d2f08cf93@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Mon, 2017-07-10 at 12:25 +0200, Hans de Goede wrote:
> Hi,
> 
> On 10-07-17 12:22, Andy Shevchenko wrote:
> > On Sun, 2017-07-09 at 21:05 +0200, Hans de Goede wrote:
> > > The GPD win BIOS dated 20170320 has disabled the accelerometer,
> > > the
> > > drivers sometimes cause crashes under Windows and this is how the
> > > manufacturer has solved this :|
> > > 
> > > I see no other way to keep the accelerometer working under Windows
> > > then
> > > adding it to the always_present_ids array.
> > > 
> > > +	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
> > > +		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),

> > > +		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
> > > +		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),

Just noticed above, don't think it's a good idea to place kinda defaults
there.

> > > +		DMI_MATCH(DMI_BIOS_DATE, "03/20/2017")
> > 
> > 4 entries for 2 entry array?
> 
> No, there are 2 dmi_system_id array entries, one with the
> actual id, one empty to terminate the array. The
> dmi_system_id array entry has a matches array which is 4 big:
> 
> struct dmi_system_id {
>          int (*callback)(const struct dmi_system_id *);
>          const char *ident;
>          struct dmi_strmatch matches[4];
>          void *driver_data;
> };
> 
> And the ENTRY macro puts the passed in arguments into the matches
> array.

Ah, indeed. Thanks for explanation.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
