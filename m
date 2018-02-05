From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Mon, 5 Feb 2018 14:45:31 -0800
Message-ID: <20180205224531.GA46524@dtor-ws>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
 <1517388005-14852-2-git-send-email-alex.hung@canonical.com>
 <20180205141447.6e1442ac@endymion>
 <1517840100.22495.25.camel@linux.intel.com>
 <5de252ed95ee48eab3bd8deeea5c610a@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40804 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeBEWpf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2018 17:45:35 -0500
Received: by mail-pl0-f67.google.com with SMTP id g18so12771817plo.7
        for <linux-acpi@vger.kernel.org>; Mon, 05 Feb 2018 14:45:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5de252ed95ee48eab3bd8deeea5c610a@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: andriy.shevchenko@linux.intel.com, jdelvare@suse.de, alex.hung@canonical.com, rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org, davem@davemloft.net, mika.westerberg@linux.intel.com, f.fainelli@gmail.com, kishon@ti.com, karniksayli1995@gmail.com, linux-acpi@vger.kernel.org

On Mon, Feb 05, 2018 at 05:36:18PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
> > Sent: Monday, February 5, 2018 8:15 AM
> > To: Jean Delvare <jdelvare@suse.de>; Alex Hung <alex.hung@canonical.com>
> > Cc: rjw@rjwysocki.net; lenb@kernel.org; gregkh@linuxfoundation.org;
> > davem@davemloft.net; mika.westerberg@linux.intel.com; f.fainelli@gmail.com;
> > dmitry.torokhov@gmail.com; kishon@ti.com; karniksayli1995@gmail.com; linux-
> > acpi@vger.kernel.org; Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
> > 
> > On Mon, 2018-02-05 at 14:14 +0100, Jean Delvare wrote:
> > 
> > > On Wed, 31 Jan 2018 00:40:05 -0800, Alex Hung wrote:
> > > > A number of Dell systems require an OEM _OSI string "Linux-Dell-
> > > > Video" as
> > > > a BIOS workaround for a system hang bug caused by discrete VGA. The
> > > > form of
> > > > the OEM _OSI string is discussed in Documentation/acpi/osi.txt and
> > > > is
> > > > defined by each OEM.
> > >
> > > I admit I don't understand how it is the operating system's job to
> > > carry the information from the BIOS to the BIOS.
> > 
> > > > +	for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
> > > > +		osi = &osi_setup_entries[i];
> > > > +		if (!strcmp(osi->string, str)) {
> > >
> > > This can only happen if the user passes acpi_osi=Linux-Dell-Video or
> > > acpi_osi=!Linux-Dell-Video on the boot command line, right?
> > >
> > > > +			osi->enable = true;
> > >
> > > Does this not prevent the user from explicitly disabling it with
> > > acpi_osi=!Linux-Dell-Video ?
> > 
> > Playing with OSI string is a bad idea. I wouldn't do anything while
> > Rafael, or even Len can confirm that is the right thing to do.
> > 
> > For me, AFAIK we need to be bug-to-bug compatible with Windows (at least
> > on ACPICA side), so, what Windows exactly does on such laptops?
> > 
> 
> The issue that's being worked around isn't an ACPICA interpreter issue, but it's 
> a graphics device configuration issue.
> 
> Windows expects to use RTD3 on the NVIDIA GPU but Linux drivers
> don't.  It leads to system hangs on the Linux side.

Can we adjust Linux drivers to do the right thing? Or is it regarding
the binary NVIDIA blob?

Thanks.

-- 
Dmitry
