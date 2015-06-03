From: Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL v4 00/21] libnd: non-volatile memory device support
Date: Wed, 3 Jun 2015 08:55:10 +0200
Message-ID: <20150603065510.GB11344@lst.de>
References: <20150527210155.17965.74864.stgit@dwillia2-desk3.amr.corp.intel.com> <20150528085124.GA26120@lst.de> <CAPcyv4ieTpdTdH=X9o0+YQ4B+fk9Wp85a55yWKReFAXpdVnSVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:50541 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbbFCGzN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Jun 2015 02:55:13 -0400
Content-Disposition: inline
In-Reply-To: <CAPcyv4ieTpdTdH=X9o0+YQ4B+fk9Wp85a55yWKReFAXpdVnSVg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Boaz Harrosh <boaz@plexistor.com>, Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>, Lv Zheng <lv.zheng@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Ingo Molnar <mingo@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>, Nicholas Moulin <nicholas.w.moulin@linux.intel.com>, Matthew Wilcox <willy@linux.intel.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Vishal Verma <vishal.l.verma@linux.intel.com>, Jens Axboe <axboe@fb.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kerne>

On Thu, May 28, 2015 at 07:55:47AM -0700, Dan Williams wrote:
> >  - stong NAK for the linker wrapping abuse in the test module
>=20
> This capability has been our single largest generator of bug fixes an=
d
> regression prevention.  Please tell me you have a non-bikeshed
> argument why this test approach must die?  We need more tests in tree=
,
> not less.  That said, it's at the end of the series ready to be loppe=
d
> off like a spent booster rocket if it's really a blocker.

No - you're overloading general functionality to go to something much
slower, with locking implications etc totally invisible to someone read=
ing
the code.  I could be persuaded that a test module makes sense if you
make it an explicit opt-in at the source code level, e.g. a version
of a the pmem driver that needs to be explicitly loaded.

Then again I really don't see the point - if you already need a VM with
ACPI / EFI tables to claim that you have pmem support you might as well
do the pmem emulation in that same virtual=D1=96zation environment.

> It makes the identifier prefixes shorter is the bulk of the reasoning
> and a hardware memory resource need not always be a "dimm".  If it's
> just the top-level directory I'm fine with 'nvdimm' or are you lookin=
g
> for a rename throughout?

That's the most important part.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
