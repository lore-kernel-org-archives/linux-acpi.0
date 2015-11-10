From: Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH 3/4] nvdimm: Add IOCTL pass thru
Date: Tue, 10 Nov 2015 15:15:54 -0700
Message-ID: <20151110221554.GF47666@tevye.fc.hp.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
 <cover.1446684001.git.jerry.hoemann@hpe.com>
 <2792786733bc18d561ca352d7a642b3989a370fa.1446684001.git.jerry.hoemann@hpe.com>
 <x49io59lt4g.fsf@segfault.boston.devel.redhat.com>
 <20151110213613.GC47666@tevye.fc.hp.com>
 <x49k2ppjzpv.fsf@segfault.boston.devel.redhat.com>
Reply-To: Jerry.Hoemann@hpe.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2354.austin.hp.com ([15.217.128.53]:32966 "EHLO
	g2t2354.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbbKJWP5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2015 17:15:57 -0500
Content-Disposition: inline
In-Reply-To: <x49k2ppjzpv.fsf@segfault.boston.devel.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org

On Tue, Nov 10, 2015 at 04:45:16PM -0500, Jeff Moyer wrote:
> Jerry Hoemann <jerry.hoemann@hpe.com> writes:
> 
> > On Tue, Nov 10, 2015 at 11:24:47AM -0500, Jeff Moyer wrote:
> >> Jerry Hoemann <jerry.hoemann@hpe.com> writes:
> >> 
> >> > @@ -633,10 +718,11 @@ static int match_dimm(struct device *dev, void *data)
> >> >  
> >> >  static long nvdimm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >> >  {
> >> > -	int rc = -ENXIO, read_only;
> >> > +	int rc = -ENXIO, ro;
> >> >  	struct nvdimm_bus *nvdimm_bus;
> >> > +	unsigned int type = _IOC_TYPE(cmd);
> >> >  
> >> > -	read_only = (O_RDWR != (file->f_flags & O_ACCMODE));
> >> > +	ro = (O_RDWR != (file->f_flags & O_ACCMODE));
> >> 
> >> I'm still reviewing the rest of this, but this is bugging me.  The
> >> existing check for read_only looks pretty fishy to me.  O_WRONLY is a
> >> thing (even though it's probably not a supportable mode for this ioctl).
> >> Why not just check for O_RDONLY?
> >
> >
> > Good question.  I'll look into changing for version 2.
> > I suspect you would like something more like:
> >
> > 	ro = ((file->f_flags & O_ACCMODE) == O_RDONLY);
> 
> Yeah.  I'd make that a separate patch, and put it first in the series
> since it's a cleanup than can be applied to older kernels if necessary.
> 

  Will do.

-- 

-----------------------------------------------------------------------------
Jerry Hoemann            Software Engineer      Hewlett-Packard Enterprise

3404 E Harmony Rd. MS 36                        phone:  (970) 898-1022
Ft. Collins, CO 80528                           FAX:    (970) 898-0707
                                                email:  jerry.hoemann@hpe.com
-----------------------------------------------------------------------------
