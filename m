From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/4] nvdimm: Add wrapper for IOCTL pass thru.
Date: Tue, 10 Nov 2015 10:05:04 -0800
Message-ID: <CAPcyv4iHK6NP+52aVBFwW1SEO03x4NQLSvL68L6GghJWKjh1tA@mail.gmail.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
	<5411049831df211c8280e3239aaf344af033fa25.1446684001.git.jerry.hoemann@hpe.com>
	<x49d1vhlp34.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <x49d1vhlp34.fsf@segfault.boston.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Jerry Hoemann <jerry.hoemann@hpe.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2015 at 9:51 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Jerry Hoemann <jerry.hoemann@hpe.com> writes:
>
>> Add IOCTL type 'P' to denote NVDIMM_TYPE_PASSTHRU.
>
> Can't you just make passthrough a separate command?  If you actually add
> the ioctl definition for passthrough (which you didn't do for some
> reason?), it looks odd:
>
> #define ND_IOCTL_PASSTHRU        _IOWR(NVDIMM_TYPE_PASSTHRU,, ND_CMD_PASSTHRU, \
>                                  struct ndn_package)
>
> Care to comment on why you chose a different type instead of specifying
> a new command?

+1 for making this just a new command number without a new top-level
number space.
