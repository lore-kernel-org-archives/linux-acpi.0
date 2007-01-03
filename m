From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Wed, 3 Jan 2007 13:29:34 -0700
Message-ID: <200701031329.34665.bjorn.helgaas@hp.com>
References: <1e2af89e0612280914n62a192e2kdb7e2677b55d2670@mail.gmail.com> <1e2af89e0612281536y769323a7l62c9df334d1e8a06@mail.gmail.com> <1e2af89e0701030340q7a01520cm831b6064af8f7881@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:47349 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932075AbXACU3l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Jan 2007 15:29:41 -0500
In-Reply-To: <1e2af89e0701030340q7a01520cm831b6064af8f7881@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Brett <matthew.brett@gmail.com>
Cc: linux-acpi@vger.kernel.org, konstantin.a.karasyov@intel.com

On Wednesday 03 January 2007 04:40, Matthew Brett wrote:
> > > > CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
> 
> I am sorry to persist - but is there anything I can do further to help
> debug this problem?  Or somewhere else that I should ask?

Thanks for your report and for persisting.  This is exactly the right
place to complain, but people might still be recovering from the
holidays.

There weren't many interesting changes in fan.c between 2.6.17 and
2.6.18.  The problem you found is probably related to this:
  http://bugzilla.kernel.org/show_bug.cgi?id=5000

The patch in comment #24 looks like this for add and resume:

        result = acpi_bus_get_power(device->handle, &state);

+	if (state == ACPI_STATE_D0)
+		acpi_bus_set_power(fan->handle, ACPI_STATE_D3);
+	else if (state == ACPI_STATE_D3)
+		acpi_bus_set_power(fan->handle, ACPI_STATE_D0);
+	acpi_bus_set_power(fan->handle, state);

whereas the code in 2.6.18 is this:

        result = acpi_bus_get_power(device->handle, &state);

+       device->flags.force_power_state = 1;
+       acpi_bus_set_power(device->handle, state);
+       device->flags.force_power_state = 0;

It's interesting that the bugzilla patch inverts the fan power state
while the 2.6.18 code does not.

Konstantin can probably give you more useful help.  I don't know
the details of how the fan state is controlled.

Bjorn
