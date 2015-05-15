From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [Linux-nvdimm] [PATCH v2 04/20] libnd: ndctl class device, and nd bus attributes
Date: Fri, 15 May 2015 17:00:08 -0400
Message-ID: <x49lhgpwo87.fsf@segfault.boston.devel.redhat.com>
References: <20150428181203.35812.60474.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150428182434.35812.49091.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39894 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161002AbbEOVAP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 May 2015 17:00:15 -0400
In-Reply-To: <20150428182434.35812.49091.stgit@dwillia2-desk3.amr.corp.intel.com>
	(Dan Williams's message of "Tue, 28 Apr 2015 14:24:34 -0400")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@ml01.01.org, Neil Brown <neilb@suse.de>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> This is the position (device topology) independent method to find all
> the libnd buses in the system.  The expectation is that there will only
> ever be one "nd" bus discovered via /sys/class/nd/ndctl0.  However, we
> allow for the possibility of multiple buses and they will listed in
> discovery order as ndctl0...ndctlN.  This character device hosts the
> ioctl for passing control messages (inspired by the ACPI-NFIT DSM
> interface commands).
>
> Note, nd_ioctl() and the backing ->ndctl() implementation are defined in
> a subsequent patch.

Acked-by: Jeff Moyer <jmoyer@redhat.com>
