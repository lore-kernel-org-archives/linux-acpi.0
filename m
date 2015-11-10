From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 3/4] nvdimm: Add IOCTL pass thru
Date: Tue, 10 Nov 2015 16:54:28 -0500
Message-ID: <x49fv0djzaj.fsf@segfault.boston.devel.redhat.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
	<cover.1446684001.git.jerry.hoemann@hpe.com>
	<2792786733bc18d561ca352d7a642b3989a370fa.1446684001.git.jerry.hoemann@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51428 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031AbbKJVya (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Nov 2015 16:54:30 -0500
In-Reply-To: <2792786733bc18d561ca352d7a642b3989a370fa.1446684001.git.jerry.hoemann@hpe.com>
	(Jerry Hoemann's message of "Fri, 6 Nov 2015 15:27:30 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org

Jerry Hoemann <jerry.hoemann@hpe.com> writes:

> +	uuid = pkg->h.dsm_uuid;
> +	rev  = pkg->h.dsm_rev ? pkg->h.dsm_rev : 1;

Shouldn't revision id be required?

Cheers,
Jeff
