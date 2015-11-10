From: Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH 0/4] nvdimm: Add an IOCTL pass thru for DSM calls
Date: Tue, 10 Nov 2015 14:39:01 -0700
Message-ID: <20151110213901.GD47666@tevye.fc.hp.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
 <x49r3jxlvhy.fsf@segfault.boston.devel.redhat.com>
Reply-To: Jerry.Hoemann@hpe.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:44465 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbbKJVjF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2015 16:39:05 -0500
Content-Disposition: inline
In-Reply-To: <x49r3jxlvhy.fsf@segfault.boston.devel.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org

On Tue, Nov 10, 2015 at 10:33:29AM -0500, Jeff Moyer wrote:
> Jerry Hoemann <jerry.hoemann@hpe.com> writes:
> 
> > The NVDIMM code in the kernel supports an IOCTL interface to user
> > space based upon the Intel Example DSM:
> >
> > 	http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
> >
> > This interface cannot be used by other NVDIMM DSMs that support
> > incompatible functions.
> >
> > This patch set adds a generic "passthru" IOCTL interface which
> > is not tied to a particular DSM.
> >
> > A new IOCTL type "P" is added for the pass thru call.
> >
> > The new data structure ndn_pkg serves as a wrapper for the passthru
> > calls.  This wrapper supplies the data that the kernel needs to
> > make the _DSM call.
> 
> What does 'ndn' stand for?  If it stands for NVDIMM-N, then I think

  Yes, hold over from earlier, less generic version.

> that's too narrow a scope.  Anyway, it helps readability if you call out
> what abbreviations mean, especially when it's non-obvious.

  Will fix in version 2.



> 
> > Jerry Hoemann (4):
> >   nvdimm: Add wrapper for IOCTL pass thru.
> >   nvdimm: Add IOCTL pass thru
> >   nvdimm: Add IOCTL pass thru
> 
> You should really give each patch a different subject.


  Will do.


> 
> Cheers,
> Jeff

-- 

-----------------------------------------------------------------------------
Jerry Hoemann            Software Engineer      Hewlett-Packard Enterprise

3404 E Harmony Rd. MS 36                        phone:  (970) 898-1022
Ft. Collins, CO 80528                           FAX:    (970) 898-0707
                                                email:  jerry.hoemann@hpe.com
-----------------------------------------------------------------------------
