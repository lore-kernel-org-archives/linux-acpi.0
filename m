From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [Linux-nvdimm] [PATCH 00/21] ND: NFIT-Defined / NVDIMM Subsystem
Date: Thu, 23 Apr 2015 07:43:27 +0200
Message-ID: <20150423054327.GA28898@gmail.com>
References: <20150418013256.25237.96403.stgit@dwillia2-desk3.amr.corp.intel.com>
 <94D0CD8314A33A4D9D801C0FE68B40295A8BE846@G9W0745.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33106 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbDWFnd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2015 01:43:33 -0400
Content-Disposition: inline
In-Reply-To: <94D0CD8314A33A4D9D801C0FE68B40295A8BE846@G9W0745.americas.hpqcorp.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Elliott, Robert (Server Storage)" <Elliott@hp.com>
Cc: Dan Williams <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Neil Brown <neilb@suse.de>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Robert Moore <robert.moore@intel.com>, Andy Lutomirski <luto@amacapital.net>, Jens Axboe <axboe@fb.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


* Elliott, Robert (Server Storage) <Elliott@hp.com> wrote:

> > -----Original Message-----
> > From: Linux-nvdimm [mailto:linux-nvdimm-bounces@lists.01.org] On Be=
half Of
> > Dan Williams
> > Sent: Friday, April 17, 2015 8:35 PM
> > To: linux-nvdimm@lists.01.org
> > Subject: [Linux-nvdimm] [PATCH 00/21] ND: NFIT-Defined / NVDIMM Sub=
system
> >=20
> ...
> >  create mode 100644 drivers/block/nd/acpi.c
> >  create mode 100644 drivers/block/nd/blk.c
> >  create mode 100644 drivers/block/nd/bus.c
> >  create mode 100644 drivers/block/nd/core.c
> ...
>=20
> The kernel already has lots of files with these names:
>  5 acpi.c
> 10 bus.c
> 66 core.c
>=20
> I often use ctags like this:
> 	vim -t core.c
> but that doesn=E2=80=99t immediately work with common filenames - it=20
> presents a list of all 66 files to choose from.
>=20
> Also, blk.c is a name one might expect to see in the block/=20
> directory (e.g., next to blk.h).
>=20
> An nd_ prefix on all the filenames would help.

It's really stupid to duplicate information that is present in the=20
pathname.

To type:

  vim -t nd/core.c

should be the same as:

  vim -t nd_core.c

Thanks,

	Ingo
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
