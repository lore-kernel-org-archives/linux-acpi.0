From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 0/4] nvdimm: Add an IOCTL pass thru for DSM calls
Date: Tue, 10 Nov 2015 10:33:29 -0500
Message-ID: <x49r3jxlvhy.fsf@segfault.boston.devel.redhat.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36961 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753778AbbKJPdc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Nov 2015 10:33:32 -0500
In-Reply-To: <cover.1446684001.git.jerry.hoemann@hpe.com> (Jerry Hoemann's
	message of "Fri, 6 Nov 2015 15:27:27 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org

Jerry Hoemann <jerry.hoemann@hpe.com> writes:

> The NVDIMM code in the kernel supports an IOCTL interface to user
> space based upon the Intel Example DSM:
>
> 	http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
>
> This interface cannot be used by other NVDIMM DSMs that support
> incompatible functions.
>
> This patch set adds a generic "passthru" IOCTL interface which
> is not tied to a particular DSM.
>
> A new IOCTL type "P" is added for the pass thru call.
>
> The new data structure ndn_pkg serves as a wrapper for the passthru
> calls.  This wrapper supplies the data that the kernel needs to
> make the _DSM call.

What does 'ndn' stand for?  If it stands for NVDIMM-N, then I think
that's too narrow a scope.  Anyway, it helps readability if you call out
what abbreviations mean, especially when it's non-obvious.

> Jerry Hoemann (4):
>   nvdimm: Add wrapper for IOCTL pass thru.
>   nvdimm: Add IOCTL pass thru
>   nvdimm: Add IOCTL pass thru

You should really give each patch a different subject.

Cheers,
Jeff
