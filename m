From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 3/4] nvdimm: Add IOCTL pass thru
Date: Tue, 10 Nov 2015 11:24:47 -0500
Message-ID: <x49io59lt4g.fsf@segfault.boston.devel.redhat.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
	<cover.1446684001.git.jerry.hoemann@hpe.com>
	<2792786733bc18d561ca352d7a642b3989a370fa.1446684001.git.jerry.hoemann@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37047 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753938AbbKJQYt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Nov 2015 11:24:49 -0500
In-Reply-To: <2792786733bc18d561ca352d7a642b3989a370fa.1446684001.git.jerry.hoemann@hpe.com>
	(Jerry Hoemann's message of "Fri, 6 Nov 2015 15:27:30 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org

Jerry Hoemann <jerry.hoemann@hpe.com> writes:

> @@ -633,10 +718,11 @@ static int match_dimm(struct device *dev, void *data)
>  
>  static long nvdimm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
> -	int rc = -ENXIO, read_only;
> +	int rc = -ENXIO, ro;
>  	struct nvdimm_bus *nvdimm_bus;
> +	unsigned int type = _IOC_TYPE(cmd);
>  
> -	read_only = (O_RDWR != (file->f_flags & O_ACCMODE));
> +	ro = (O_RDWR != (file->f_flags & O_ACCMODE));

I'm still reviewing the rest of this, but this is bugging me.  The
existing check for read_only looks pretty fishy to me.  O_WRONLY is a
thing (even though it's probably not a supportable mode for this ioctl).
Why not just check for O_RDONLY?

Cheers,
Jeff
