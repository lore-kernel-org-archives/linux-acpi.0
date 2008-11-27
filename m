From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH 7/8] acpi: avoid using internal acpica structures
Date: Thu, 27 Nov 2008 09:03:26 +0800
Message-ID: <1227747806.16339.13.camel@minggr.sh.intel.com>
References: <1227668177.7702.99.camel@minggr.sh.intel.com>
	 <492D0504.8010301@gmail.com> <1227692693.16339.8.camel@minggr.sh.intel.com>
	 <492D2587.9070408@gmail.com>
	 <d3f22a0811261702q39d89093y52d22c3e9ea0e488@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:56033 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755659AbYK0BJO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Nov 2008 20:09:14 -0500
In-Reply-To: <d3f22a0811261702q39d89093y52d22c3e9ea0e488@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


> Merge the above two lines?
> >
> > +
> > +       if (ACPI_SUCCESS(status)) {
> > +               if (sscanf(node_name, "_Q%x", &value) == 1) {
> >
> 
> single if (ACPI_SUCCESS(status) && sscanf(node_name, "_Q%x", &value) == 1) ?

OK, that makes code compact.

Thanks,
Lin Ming

