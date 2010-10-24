From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: Make Embedded Controller command timeout delay configurable
Date: Mon, 25 Oct 2010 00:34:50 +0200
Message-ID: <201010250034.51170.trenn@suse.de>
References: <201010211824.57893.trenn@suse.de> <201010230046.06637.trenn@suse.de> <201010230143.24858.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:55220 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374Ab0JXWes (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Oct 2010 18:34:48 -0400
In-Reply-To: <201010230143.24858.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Saturday 23 October 2010 01:43:24 am Rafael J. Wysocki wrote:
> On Saturday, October 23, 2010, Thomas Renninger wrote:
> > On Friday 22 October 2010 11:22:00 pm Rafael J. Wysocki wrote:
> > > On Friday, October 22, 2010, Len Brown wrote:
> > > > applied
> > > 
> > > OK
> > > 
> > > What if I do ec_delay=0 ?
> > Same as with quite some other boot params:
> > Your machine won't boot.
> > 
> > Why should this be a problem?
> 
> Because your intention is to allow the users to _increase_ the delay and not
> to decrease it.  Decreasing it is known dangerous, so why don't you simply
> put a limit in there?
> 
> I know there are many boot params that will hurt you if not used with care,
> but is that a sufficient reason for adding another one?
To be honest I have not thought about the debug aspect of this param when
I sent it.
But I think Len is right and this can be used as a nice debug param to test
whether there are EC accesses that take really long.
For example you have the requirement that your EC provides data for all
requests in X ms. You boot acpi.ec_delay=X and if there are timeout complaints 
you can then have a look at your EC firmware or at the kernel/ACPI code what 
the reasons were that things timed out.

Nobody will decrease the limit, unless he wants to examine above problems.
I can write kernel-parameters documentation, but I expect people finding this
had a look at the code. If people see AE_TIME messages with a too low value, 
they should know that it obviously was the boot param they added and they can 
simply remove it again.

        Thomas
