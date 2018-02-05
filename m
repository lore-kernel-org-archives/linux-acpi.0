From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Mon, 05 Feb 2018 16:15:00 +0200
Message-ID: <1517840100.22495.25.camel@linux.intel.com>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
         <1517388005-14852-2-git-send-email-alex.hung@canonical.com>
         <20180205141447.6e1442ac@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34484 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753107AbeBEOPH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Feb 2018 09:15:07 -0500
In-Reply-To: <20180205141447.6e1442ac@endymion>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Alex Hung <alex.hung@canonical.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org, davem@davemloft.net, mika.westerberg@linux.intel.com, f.fainelli@gmail.com, dmitry.torokhov@gmail.com, kishon@ti.com, karniksayli1995@gmail.com, linux-acpi@vger.kernel.org, Mario.Limonciello@dell.com

On Mon, 2018-02-05 at 14:14 +0100, Jean Delvare wrote:

> On Wed, 31 Jan 2018 00:40:05 -0800, Alex Hung wrote:
> > A number of Dell systems require an OEM _OSI string "Linux-Dell-
> > Video" as
> > a BIOS workaround for a system hang bug caused by discrete VGA. The
> > form of
> > the OEM _OSI string is discussed in Documentation/acpi/osi.txt and
> > is
> > defined by each OEM.
> 
> I admit I don't understand how it is the operating system's job to
> carry the information from the BIOS to the BIOS.

> > +	for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
> > +		osi = &osi_setup_entries[i];
> > +		if (!strcmp(osi->string, str)) {
> 
> This can only happen if the user passes acpi_osi=Linux-Dell-Video or
> acpi_osi=!Linux-Dell-Video on the boot command line, right?
> 
> > +			osi->enable = true;
> 
> Does this not prevent the user from explicitly disabling it with
> acpi_osi=!Linux-Dell-Video ?

Playing with OSI string is a bad idea. I wouldn't do anything while
Rafael, or even Len can confirm that is the right thing to do.

For me, AFAIK we need to be bug-to-bug compatible with Windows (at least
on ACPICA side), so, what Windows exactly does on such laptops?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
