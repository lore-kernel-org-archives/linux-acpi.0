From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v3] libnvdimm, region: sysfs trigger for nvdimm_flush()
Date: Thu, 27 Apr 2017 15:43:41 -0400
Message-ID: <x491ssdprf6.fsf@segfault.boston.devel.redhat.com>
References: <149307780135.7155.11108531648914675756.stgit@dwillia2-desk3.amr.corp.intel.com>
        <149315140303.23340.14688142799059150805.stgit@dwillia2-desk3.amr.corp.intel.com>
        <x49zif23nvl.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4jQXRQVHnNMqJDrwSMM=1kJx_7sWifUN-u1yusVCZ0roQ@mail.gmail.com>
        <x49y3umufpm.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4jOP6fhk4wXahdEWH2O_93LQe9yzrWYZatSXXDwEk5OBA@mail.gmail.com>
        <x49d1bxsngb.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4g1zbaNDttkzGv4NV9ZQXrObLqpPLMQW2wqoP_iTozrsQ@mail.gmail.com>
        <CAPcyv4hDmwSO8szjn+mqL6xpW2H92WsTDn=8qLtJi7Y8kduX5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967863AbdD0Tnn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Apr 2017 15:43:43 -0400
In-Reply-To: <CAPcyv4hDmwSO8szjn+mqL6xpW2H92WsTDn=8qLtJi7Y8kduX5Q@mail.gmail.com>
        (Dan Williams's message of "Thu, 27 Apr 2017 12:21:54 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Dan Williams <dan.j.williams@intel.com> writes:

> We also still seem to need a discovery mechanism as I've had questions
> about "how do I tell if my system supports deep flush?". That's where
> sysfs is much better than an ioctl. The need for deep flush discovery
> tips the scales, at least for me, to also do deep flush triggering
> through the same interface.

Return ENXIO or EOPNOTSUPP from the ioctl when it isn't supported?

Cheers,
Jeff
