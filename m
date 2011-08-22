From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: APEI: Can not request iomem region for GARs
Date: Mon, 22 Aug 2011 10:45:03 -0600
Message-ID: <CAErSpo71XHyuji1HxZwShtg-YQCavgkgcdH23ic38q3COB3MgQ@mail.gmail.com>
References: <CAG1a4rs4Cr1z50gGuK9SLE6aOvibE1sdV_GSLPv+gqYC8g+ORQ@mail.gmail.com>
 <CAErSpo4FfBoGDUquoLNsJ9=z-M-x6NQgP8xJL_VqEXpsL2H5PA@mail.gmail.com> <4E520149.3010802@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:23773 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab1HVQp0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Aug 2011 12:45:26 -0400
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id p7MGjOx5024549
	for <linux-acpi@vger.kernel.org>; Mon, 22 Aug 2011 09:45:25 -0700
Received: from gwm11 (gwm11.prod.google.com [10.200.13.11])
	by wpaz29.hot.corp.google.com with ESMTP id p7MGjNWn032053
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 22 Aug 2011 09:45:23 -0700
Received: by gwm11 with SMTP id 11so3776771gwm.2
        for <linux-acpi@vger.kernel.org>; Mon, 22 Aug 2011 09:45:23 -0700 (PDT)
In-Reply-To: <4E520149.3010802@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Pavel Ivanov <paivanof@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>

On Mon, Aug 22, 2011 at 1:12 AM, Huang Ying <ying.huang@intel.com> wrote:
> Do you have time to try the patch attached with the mail?
> acpi_nvs.patch should go first.

I'm sure these patches make the messages go away, but I think this is
the wrong way to fix the problem.

We mark things "busy" in the resource trees as a mutual exclusion
mechanism -- normally when a driver claims a resource and nothing else
should be allowed to touch it.

e820_reserve_resources() marks everything (except "reserved" regions)
as busy.  That probably makes sense for available RAM, since RAM is
allocated and managed via other mechanisms.  But I think it's wrong in
this case because e820 is not a driver that is using the ACPI NVS
region.

In this case, we have an ACPI NVS region, and the APEI code is
essentially a driver for some registers that reside there.  APEI is
the entity that manages those registers, and it needs to enforce
mutual exclusion so nobody else touches them behind its back, so I
think it makes sense for it to request the register regions and mark
them busy.

My proposal is to change e820 so it either leaves ACPI NVS out of the
iomem_resource tree or puts it in but leaves it non-busy.

Bjorn
