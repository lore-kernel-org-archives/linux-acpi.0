From: Dan Magenheimer <dan.magenheimer@oracle.com>
Subject: RE: [Xen-devel] Is: axe read_tscp pvops call. Was: Re: [RFC] ACPI S3
 and Xen (suprisingly small\!).
Date: Thu, 18 Oct 2012 08:22:50 -0700 (PDT)
Message-ID: <84b3cbf9-7c84-4d7e-a2d7-46b0d1cc5975@default>
References: <1350481786-4969-1-git-send-email-konrad.wilk@oracle.com>
 <507ED6C0.4020503@zytor.com> <20121017161036.GA10691@phenom.dumpdata.com>
 <507EE1C3.7070300@zytor.com> <20121017165452.GA22740@phenom.dumpdata.com>
 <507EEC53.1010309@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:34836 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881Ab2JRPXD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Oct 2012 11:23:03 -0400
In-Reply-To: <507EEC53.1010309@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>, Konrad Wilk <konrad.wilk@oracle.com>
Cc: linux-acpi@vger.kernel.org, x86@kernel.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, lenb@kernel.org

> From: H. Peter Anvin [mailto:hpa@zytor.com]
> Sent: Wednesday, October 17, 2012 11:35 AM
> To: Konrad Rzeszutek Wilk
> Cc: linux-acpi@vger.kernel.org; x86@kernel.org; xen-devel@lists.xensource.com; linux-
> kernel@vger.kernel.org; lenb@kernel.org
> Subject: Re: [Xen-devel] Is: axe read_tscp pvops call. Was: Re: [RFC] ACPI S3 and Xen (suprisingly
> small\!).
> 
> On 10/17/2012 09:54 AM, Konrad Rzeszutek Wilk wrote:
> >>
> >> Could you do an audit for other pvops calls that have no users?  If
> >> the *only* user is lguest, we should talk about it, too...
> >
> > I can do that - but I don't want to be hasty here. There is a bit of
> > danger here - for example the read_pmc (or read_tsc) is not in use right
> > now. But it might be when one starts looking at making perf be able to
> > analyze the hypervisor (hand-waving the implementation details). So while
> > removing read_pmc now sounds good, it might be needed in the future.
> >
> 
> We do not keep a pvop around just because it "might be needed in the
> future".  That's just crazy.
> 
> 	-hpa

It's a bit more complicated than that.  The problem is that if
any patch is ever submitted to the kernel that uses the rdtscp
instruction *in kernel space* in some clever way, the resultant
kernel may not behave as expected (depending on how the instruction
is used) on a 32-bit[1] PV kernel running on Xen, up to and including
the possibility of data corruption.

I don't know how one would implement it, but it's like a
BUILD_BUG_ON is needed if any kernel developer uses rdtscp
(one that never gets invoked by vdso code), that prints:

"WARNING: Please do not use this instruction in the kernel
without notifying the Xen maintainer as there is a possibility
it may behave unpredictably in some Xen environments.
See Documentation/.../xen_pv_limitations for detail."

The other virtualization-unsafe instructions may have similar
problems.

Just FYI...

Dan

[1] I _think_ this is not a problem on 64-bit kernels but
am not certain.
