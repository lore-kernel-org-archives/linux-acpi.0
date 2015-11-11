From: Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH 3/4] nvdimm: Add IOCTL pass thru
Date: Tue, 10 Nov 2015 18:42:38 -0700
Message-ID: <20151111014238.GA61637@tevye.fc.hp.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
 <cover.1446684001.git.jerry.hoemann@hpe.com>
 <2792786733bc18d561ca352d7a642b3989a370fa.1446684001.git.jerry.hoemann@hpe.com>
 <x49fv0djzaj.fsf@segfault.boston.devel.redhat.com>
Reply-To: Jerry.Hoemann@hpe.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t5424.austin.hp.com ([15.216.225.54]:50885 "EHLO
	g1t5424.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbbKKBmn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2015 20:42:43 -0500
Content-Disposition: inline
In-Reply-To: <x49fv0djzaj.fsf@segfault.boston.devel.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org

On Tue, Nov 10, 2015 at 04:54:28PM -0500, Jeff Moyer wrote:
> Jerry Hoemann <jerry.hoemann@hpe.com> writes:
> 
> > +	uuid = pkg->h.dsm_uuid;
> > +	rev  = pkg->h.dsm_rev ? pkg->h.dsm_rev : 1;
> 
> Shouldn't revision id be required?
> 

Yes it should be.  Good catch.

I was testing use of reclaiming previously unused members of
the structure.  I should have removed this line.

And this reminds me that I should also add a test that the reserved fields
of ndn_pkg are actually zero.

I'll address both in version 2.

thanks

-- 

-----------------------------------------------------------------------------
Jerry Hoemann            Software Engineer      Hewlett-Packard Enterprise
-----------------------------------------------------------------------------
