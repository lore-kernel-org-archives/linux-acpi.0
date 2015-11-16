From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 0/3] nvdimm: Add an IOCTL pass thru for DSM calls
Date: Mon, 16 Nov 2015 11:00:20 -0800
Message-ID: <CAPcyv4j_KcwztL3ACRafSFGEiaspCuM_+CwkcSeymVk5s5vYWg@mail.gmail.com>
References: <cover.1447698598.git.jerry.hoemann@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34234 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbbKPTAW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2015 14:00:22 -0500
Received: by wmvv187 with SMTP id v187so192388322wmv.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2015 11:00:21 -0800 (PST)
In-Reply-To: <cover.1447698598.git.jerry.hoemann@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>, jmoyer <jmoyer@redhat.com>, Dmitry Krivenok <krivenok.dmitry@gmail.com>, Linda Knippers <linda.knippers@hpe.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Nov 16, 2015 at 10:38 AM, Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
>
> The NVDIMM code in the kernel supports an IOCTL interface to user
> space based upon the Intel Example DSM:
>
>         http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
>
> This interface cannot be used by other NVDIMM DSMs that support
> incompatible functions.
>
> This patch set adds a generic "passthru" IOCTL interface which
> is not tied to a particular DSM.
>
> A new _IOC_NR ND_CMD_PASSTHRU == "100" is added for the pass thru call.
>
> The new data structure nd_passthru_pkg serves as a wrapper for the passthru
> calls.  This wrapper supplies the data that the kernel needs to
> make the _DSM call.
>
> Unlike the definitions of the _DSM functions themselves, the nd_passthru_pkg
> provides the calling information (input/output sizes) in an uniform
> manner making the kernel marshaling of the arguments straight
> forward.
>
> This shifts the marshaling burden from the kernel to the user
> space application while still permitting the kernel to internally
> call _DSM functions.
>
> To make the resultant kernel code easier to understand the existing
> functions acpi_nfit_ctl and __nd_ioctl were renamed to .*_intel to
> denote calling mechanism as in 4.3 tailored to the Intel Example DSM.
> New functions acpi_nfit_ctl_passthru and __nd_ioctl_passthru were
> created to supply the pass thru interface.

Let's not do the _intel vs _passthru split.  I want to convert the
existing commands over to this new interface and deprecate the old
ioctl-command formats.  I.e. it isn't the case that this will be a
always be a blind "passthru" mechanism, the kernel will need to crack
open this payload in some circumstances.
