From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 2/2] acpi: nfit: Add support for hot-add
Date: Sat, 7 Nov 2015 10:57:17 -0800
Message-ID: <CAPcyv4gytTTVgU6evY9d+EoxD0wRs4J1D_LS+ucJ5vOju0Kd2A@mail.gmail.com>
References: <1445986707-15395-1-git-send-email-vishal.l.verma@intel.com>
	<1445986707-15395-3-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33109 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbbKGS5S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2015 13:57:18 -0500
Received: by wijp11 with SMTP id p11so47652739wij.0
        for <linux-acpi@vger.kernel.org>; Sat, 07 Nov 2015 10:57:17 -0800 (PST)
In-Reply-To: <1445986707-15395-3-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Elliott Robert <elliott@hpe.com>, Toshi Kani <toshi.kani@hpe.com>

Rafael, awaiting your ack...

Vishal, one thing I'll fix up on applying...

On Tue, Oct 27, 2015 at 3:58 PM, Vishal Verma <vishal.l.verma@intel.com> wrote:
> Add a .notify callback to the acpi_nfit_driver that gets called on a
> hotplug event. From this, evaluate the _FIT ACPI method which returns
> the updated NFIT with handles for the hot-plugged NVDIMM.
>
> Iterate over the new NFIT, and add any new tables found, and
> register/enable the corresponding regions.
>
> In the nfit test framework, after normal initialization, update the NFIT
> with a new hot-plugged NVDIMM, and directly call into the driver to
> update its view of the available regions.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Toshi Kani <toshi.kani@hpe.com>
> Cc: Elliott, Robert <elliott@hpe.com>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: <linux-acpi@vger.kernel.org>
> Cc: <linux-nvdimm@lists.01.org>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
[..]

> +static int acpi_nfit_add(struct acpi_device *adev)
> +{
> +       struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
> +       struct acpi_nfit_desc *acpi_desc;
> +       struct device *dev = &adev->dev;
> +       struct acpi_table_header *tbl;
> +       acpi_status status = AE_OK;
> +       acpi_size sz;
> +       int rc = 0;
> +
> +       device_lock(dev);

The device is already locked by the time we reach this point.  The
unit tests don't trip this path which might be why this wasn't seen
earlier.
