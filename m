From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/3] nfit: Account for table size length variation
Date: Tue, 24 Nov 2015 08:31:24 -0800
Message-ID: <CAPcyv4jC5DURXdyny7gOkMRv62koSabn_KJpCr8O7MqMrjcy5g@mail.gmail.com>
References: <cover.1448045168.git.linda.knippers@hpe.com>
	<e65332cc9dbb7eff02f739aa5ba357d4097b4e6a.1448045168.git.linda.knippers@hpe.com>
	<1448320884.27481.2.camel@intel.com>
	<56548F20.7090407@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38203 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbbKXQbZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Nov 2015 11:31:25 -0500
Received: by wmec201 with SMTP id c201so34469530wme.1
        for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2015 08:31:24 -0800 (PST)
In-Reply-To: <56548F20.7090407@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linda Knippers <linda.knippers@hpe.com>
Cc: "Verma, Vishal L" <vishal.l.verma@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "toshi.kani@hpe.com" <toshi.kani@hpe.com>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "elliott@hpe.com" <elliott@hpe.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

On Tue, Nov 24, 2015 at 8:24 AM, Linda Knippers <linda.knippers@hpe.com> wrote:
[..]
> If we want to be more paranoid about buggy FW when we're comparing old
> and new tables, we could compare based on the length of the old and new
> tables since we have both pieces of information.  That would let you catch
> the case where a table size changes during a hotplug event or whenever the
> _FIT is processed.  Since you were comparing based on structure size instead
> of header length, I didn't change that.

Comparing that the size didn't change sounds like a good incremental
change to tag on later.
