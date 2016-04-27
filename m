From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/device_sysfs: Add sysfs support for _HRV hardware revision
Date: Wed, 27 Apr 2016 23:19:15 +0200
Message-ID: <12004194.mLBeKcyjTJ@vostro.rjw.lan>
References: <1460558894-11971-1-git-send-email-betty.dall@hpe.com> <3691881.pb3S7Il1cr@vostro.rjw.lan> <AT5PR84MB0083E24D7512C359906A09489D640@AT5PR84MB0083.NAMPRD84.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58000 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753085AbcD0VQP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Apr 2016 17:16:15 -0400
In-Reply-To: <AT5PR84MB0083E24D7512C359906A09489D640@AT5PR84MB0083.NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Dall, Betty" <betty.dall@hpe.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wednesday, April 27, 2016 04:15:30 PM Dall, Betty wrote:
> On 04/26/2016 02:33 PM, Rafael J. Wysocki wrote:
> > On Wednesday, April 13, 2016 08:48:14 AM Betty Dall wrote:
> >> The ACPI _HRV object on the device is used to supply Linux with
> >> the device's hardware revision. This is an optional object. Add
> >> sysfs support for the _HRV object if it exists on the device.
> >>
> >> Signed-off-by: Betty Dall <betty.dall@hpe.com>
> > 
> > The patch itself looks OK to me, but why exactly do we need that thing in sysfs?
> > 
> > Thanks,
> > Rafael
> > 
> Hi Rafael,
> 
> I am working on a platform where non-PCI hardware is changing quickly
> and users want to check what hardware version they are running on. For
> example, someone checks out a lab system and wants to see if the device
> is the latest version or if it needs to be updated - they could cat the
> sysfs hrv file to find the version. It is most useful for non-PCI
> devices because lspci can list the hardware version for PCI devices; PCI
> devices in my testing don't supply _HRV. But, there is not an easy
> solution for non-PCI devices to get the hardware revision from user
> space with out this hrv sysfs patch.
> 
> Originally, I added the sysfs hrv to my specific device driver. On
> review, I thought it would a good improvement for all devices that have
> an _HRV.

OK

Can you please add a motivation paragraph to the patch changelog then?

Thanks,
Rafael

