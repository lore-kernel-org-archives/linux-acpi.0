From: Len Brown <lenb@kernel.org>
Subject: Re: linux-next: first tree
Date: Thu, 14 Feb 2008 23:58:38 -0500
Message-ID: <200802142358.39171.lenb@kernel.org>
References: <20080215003537.8911ce35.sfr@canb.auug.org.au> <200802141545.56488.rjw@sisk.pl> <20080215020019.f7cb5895.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35604 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863AbYBOE7L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Feb 2008 23:59:11 -0500
In-Reply-To: <20080215020019.f7cb5895.sfr@canb.auug.org.au>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday 14 February 2008 10:00, Stephen Rothwell wrote:
> Hi Rafael,
> 
> On Thu, 14 Feb 2008 15:45:55 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > Perhaps you can add:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6 test
> 
> I would prefer that the trees be added by the subsystem maintainers and
> they can tell me which branch represents their expectations for the next
> kernel release (in this case 2.6.26). But thanks, hopefully you will have
> prodded them along. :-)

Rafael has it right, please add the branch above.
It will include both the upcoming ACPI and suspend patches.

Note that I reserve the right to re-base it from time to time -
so when you pull it, you want to pull it onto a new branch vs. Linux
rather than onto a previous copy of itself.

thanks,
-Len
