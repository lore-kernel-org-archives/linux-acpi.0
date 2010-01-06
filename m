From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/5] ACPI, APEI, Document for APEI
Date: Wed, 6 Jan 2010 08:16:09 +0100
Message-ID: <20100106071609.GA1648@ucw.cz>
References: <1261980744-4450-1-git-send-email-ying.huang@intel.com> <1261980744-4450-2-git-send-email-ying.huang@intel.com> <1261980744-4450-3-git-send-email-ying.huang@intel.com> <1261980744-4450-4-git-send-email-ying.huang@intel.com> <1261980744-4450-5-git-send-email-ying.huang@intel.com> <1261980744-4450-6-git-send-email-ying.huang@intel.com> <20100106071431.GB1494@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55292 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab0AFHQY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2010 02:16:24 -0500
Content-Disposition: inline
In-Reply-To: <20100106071431.GB1494@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: lenb@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


> > +The user interface of EINJ is in debug file system, under the
> > +directory apei/einj. The following files are provided.
> > +
> > +- available_error_type
> > +  Read this file will return the error injection capability of the
> > +  platform, that is, which error types are supported. The error type
> > +  definition is as follow, the left field is the error type value, the
> > +  right field is error description.
> > +
> > +    0x00000001	Processor Correctable
> > +    0x00000002	Processor Uncorrectable non-fatal
> > +    0x00000004	Processor Uncorrectable fatal
> > +    0x00000008  Memory Correctable
> > +    0x00000010  Memory Uncorrectable non-fatal
> > +    0x00000020  Memory Uncorrectable fatal
> > +    0x00000040	PCI Express Correctable
> > +    0x00000080	PCI Express Uncorrectable fatal
> > +    0x00000100	PCI Express Uncorrectable non-fatal
> > +    0x00000200	Platform Correctable
> > +    0x00000400	Platform Uncorrectable non-fatal
> > +    0x00000800	Platform Uncorrectable fatal
> > +
> > +  The format of file contents are as above, except there are only the
> > +  available error type lines.

Strange interface. Why not simply pass single integer -- the bit mask?
Bit meanings are not going to change, anyway.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
