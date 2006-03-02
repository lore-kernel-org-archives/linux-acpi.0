From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 14:37:09 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30063F908B@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:50573 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751679AbWCBTjW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Mar 2006 14:39:22 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Andi Kleen <ak@suse.de>


>On Thu, Mar 02, 2006 at 02:26:24PM -0500, Brown, Len wrote:
> > Dave,
> > Your DSDT looks fine.
> > I was wrong assuming there were 3 Processor entries there.
> > 
> > > > Did you really build a 256-CPU SMP kernel or is ACPI 
> > > > ignoring CONFIG_NR_CPUS or something?
> > >
> > >Yes, it's =256.
> > 
> > I expect this is the root problem.
>
>If this is the _cause_, something needs fixing, but it's hardly
>something we can brush off as 'the root problem'.
>
>It's entirely possible for such a configuration (higher
>CONFIG_NR_CPUS than actual cpus), cf. distro kernels.

I agree.
Did Ashok's sigined-unsigned patch work?
