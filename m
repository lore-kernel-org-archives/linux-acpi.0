From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPI: Implement overriding of arbitrary ACPI tables via
 initrd
Date: Sun, 25 Mar 2012 11:25:33 +0200
Message-ID: <20120325092533.GA13307@liondog.tnic>
References: <1332512984-79664-1-git-send-email-trenn@suse.de>
 <4F6CD79A.8020805@zytor.com>
 <201203240242.07724.trenn@suse.de>
 <4F6D2AF8.3070707@zytor.com>
 <20120324184238.GB13978@phenom.dumpdata.com>
 <4F6E1D6F.4000308@zytor.com>
 <20120324191718.GA3927@phenom.dumpdata.com>
 <4F6E48CD.9050002@zytor.com>
 <4F6E4E3A.7060307@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:46070 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754894Ab2CYJZi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Mar 2012 05:25:38 -0400
Content-Disposition: inline
In-Reply-To: <4F6E4E3A.7060307@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Renninger <trenn@suse.de>, eric.piel@tremplin-utc.net, vojcek@tlen.pl, dsdt@gaugusch.at, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Lin Ming <ming.m.lin@intel.com>, lenb@kernel.org, robert.moore@intel.com, Al Viro <viro@zeniv.linux.org.uk>, Harald Hoyer <harald@redhat.com>

On Sat, Mar 24, 2012 at 03:44:10PM -0700, H. Peter Anvin wrote:
> On 03/24/2012 03:21 PM, H. Peter Anvin wrote:
> > The attached cpio-parsing code compiles to 458 bytes on x86-64 and 476
> > bytes on i386, and that is without any library dependencies at all.
> > Again, it will completely stop at the first compressed data item, so any
> > such kernel objects absolutely will have to be first.  In good Linux
> > tradition, it is also completely untested.
> > 
> > However, given that very reasonable size I would think that this is a
> > reasonable approach.  Anyone who has a better suggestion for the
> > namespace than "kernel/"?
> > 
> 
> Slightly improved version with actually working memcmp()...

[..]

> /*
>  * findcpio.c
>  *
>  * Find a specific cpio member; must precede any compressed content.

Looks simple enough. Btw, there's some cpio handling already done in
<init/initramfs.c> - probably reuse some of the code there...?

-- 
Regards/Gruss,
    Boris.
