From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Cast removal
Date: Wed, 4 Oct 2006 22:19:14 -0700
Message-ID: <20061004221914.0811b28a.akpm@osdl.org>
References: <Pine.LNX.4.61.0610010026050.32229@yvahk01.tjqt.qr>
	<200610042356.03348.len.brown@intel.com>
	<20061004211259.8274db49.akpm@osdl.org>
	<200610050043.41997.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:25515 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751449AbWJEFT7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Oct 2006 01:19:59 -0400
In-Reply-To: <200610050043.41997.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI List <linux-acpi@vger.kernel.org>

On Thu, 5 Oct 2006 00:43:41 -0400
Len Brown <len.brown@intel.com> wrote:

> On Thursday 05 October 2006 00:12, Andrew Morton wrote:
> > On Wed, 4 Oct 2006 23:56:02 -0400
> > Len Brown <len.brown@intel.com> wrote:
> > 
> > > I'm okay applying this patch it touches the linux-specific
> > > drivers/acpi/* files only, no ACPICA files.
> > 
> > Why?
> 
> Why am I okay with it?

No, I meant why not clean up ACPICA too?

> If maintaining individual ACPI-related patches in -mm is a burden,
> then refuse to.

Not an especial burden, but it would be nice to get more acks or nacks when
I send them over.  scsi is a bit of a problem in this regard too.
