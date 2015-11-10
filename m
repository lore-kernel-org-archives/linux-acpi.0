From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 1/4] nvdimm: Add wrapper for IOCTL pass thru.
Date: Tue, 10 Nov 2015 12:51:59 -0500
Message-ID: <x49d1vhlp34.fsf@segfault.boston.devel.redhat.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
	<cover.1446684001.git.jerry.hoemann@hpe.com>
	<5411049831df211c8280e3239aaf344af033fa25.1446684001.git.jerry.hoemann@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5411049831df211c8280e3239aaf344af033fa25.1446684001.git.jerry.hoemann@hpe.com>
	(Jerry Hoemann's message of "Fri, 6 Nov 2015 15:27:28 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org
List-Id: linux-acpi@vger.kernel.org

Jerry Hoemann <jerry.hoemann@hpe.com> writes:

> Add IOCTL type 'P' to denote NVDIMM_TYPE_PASSTHRU.

Can't you just make passthrough a separate command?  If you actually add
the ioctl definition for passthrough (which you didn't do for some
reason?), it looks odd:

#define ND_IOCTL_PASSTHRU        _IOWR(NVDIMM_TYPE_PASSTHRU,, ND_CMD_PASSTHRU, \
                                 struct ndn_package)

Care to comment on why you chose a different type instead of specifying
a new command?

> +struct ndn_pkg {
> +	struct {
> +		__u8	dsm_uuid[16];
> +		__u32	dsm_in;			/* size of _DSM input    */
> +		__u32	dsm_out;		/* size of user buffer   */
> +		__u32	dsm_rev;		/* revision of dsm call  */
> +		__u32	res[8];			/* reserved must be zero */
> +		__u32	dsm_size;		/* size _DSM would write */
> +	} h;
> +	unsigned char buf[];

Please change that to:
	__u8 *buf;
since acpi_object.buffer.pointer is a u8 *.

Note that the size of this structure will be different for 32 vs. 64
bit, but I don't think it matters since offsets won't change (the
pointer is at the end of the structure).
