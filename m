From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [RFC] ACPI S3 and Xen (suprisingly small\!).
Date: Fri, 19 Oct 2012 14:49:08 -0400
Message-ID: <20121019184908.GA19834@phenom.dumpdata.com>
References: <1350481786-4969-1-git-send-email-konrad.wilk@oracle.com>
 <CAOvdn6WBj_-=3Z=ZrD670Zup4H=pvjXknvHGgjs55k3LWJyDxQ@mail.gmail.com>
 <20121017174317.GA25443@phenom.dumpdata.com>
 <CAOvdn6Uubr8J0a5+nhDKrtMYebKkBTX6+-0v0J1BGMnU-ZkVRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:30305 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694Ab2JSTBV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Oct 2012 15:01:21 -0400
Content-Disposition: inline
In-Reply-To: <CAOvdn6Uubr8J0a5+nhDKrtMYebKkBTX6+-0v0J1BGMnU-ZkVRA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Guthro <ben@guthro.net>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, lenb@kernel.org, linux-acpi@vger.kernel.org, hpa@zytor.com, x86@kernel.org

On Wed, Oct 17, 2012 at 02:00:29PM -0400, Ben Guthro wrote:
> I'm not sure it matters, but I'm testing against a changeset about a week old:
> http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=1c4a5b37b55c56e49135e65728137f54288d1fe6

I was able to reproduce it with Xen 4.2 so found the culprit.

.. And then another issue :-(

> 
> Plus patches specific to XenClient Enterprise.
> 
> 
> On Wed, Oct 17, 2012 at 1:43 PM, Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
> > On Wed, Oct 17, 2012 at 01:46:09PM -0400, Ben Guthro wrote:
> >> On Wed, Oct 17, 2012 at 9:49 AM, Konrad Rzeszutek Wilk
> >> <konrad.wilk@oracle.com> wrote:
> >> [...]
> >>
> >> > The end result is this is a nice set of patches where there is only
> >> > _one_ change in the x86 code (and it is just more of dealing with
> >> > error case) - and the rest are all done in Xen side.
> >>
> >> I'm sorry to report that this series doesn't seem to work in my setup
> >> against xen-unstable.
> >>
> >> To verify that it was, in fact this patch series, and not another Xen
> >> regression - I swapped out the kernel with this patch series, with an
> >> identical one, replacing only this series with your acpi-s3.v9 branch
> >> - and everything worked fine.
> >
> > Thanks for testing it!
> >
> > I had tested it with Xen 4.1.3, which could be doing something different.
> > Will see what is up.
