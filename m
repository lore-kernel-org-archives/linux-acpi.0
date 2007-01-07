From: "Matthew Brett" <matthew.brett@gmail.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Sun, 7 Jan 2007 20:10:46 +0000
Message-ID: <1e2af89e0701071210i3efc9f50w635013f7ec0b0a32@mail.gmail.com>
References: <1e2af89e0612280914n62a192e2kdb7e2677b55d2670@mail.gmail.com>
	 <1e2af89e0612281536y769323a7l62c9df334d1e8a06@mail.gmail.com>
	 <1e2af89e0701030340q7a01520cm831b6064af8f7881@mail.gmail.com>
	 <200701031329.34665.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:32368 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965102AbXAGUKs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jan 2007 15:10:48 -0500
Received: by ug-out-1314.google.com with SMTP id 44so6077750uga
        for <linux-acpi@vger.kernel.org>; Sun, 07 Jan 2007 12:10:46 -0800 (PST)
In-Reply-To: <200701031329.34665.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, konstantin.a.karasyov@intel.com

Hi,

I am sorry, I am a bit lost.  Should I expect replacing:

> +       device->flags.force_power_state = 1;
> +       acpi_bus_set_power(device->handle, state);
> +       device->flags.force_power_state = 0;

with:

> +       if (state == ACPI_STATE_D0)
> +               acpi_bus_set_power(fan->handle, ACPI_STATE_D3);
> +       else if (state == ACPI_STATE_D3)
> +               acpi_bus_set_power(fan->handle, ACPI_STATE_D0);
> +       acpi_bus_set_power(fan->handle, state);

in fan.c from 2.6.20-rc3 should solve the problem (replacing
fan->handle with device->handle)?  It does not seem to.

Thanks a lot for the feedback...

Matthew
