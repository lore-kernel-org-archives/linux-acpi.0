From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 7/12] acpi: fix another compile warning
Date: Tue, 19 Jun 2007 20:51:58 -0700
Message-ID: <20070619205158.8d6da762.randy.dunlap@oracle.com>
References: <20070619225035.GI5193@alberich.amd.com>
	<200706192338.02807.lenb@kernel.org>
	<20070619204934.f56722a8.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:25004 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757227AbXFTDvX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jun 2007 23:51:23 -0400
In-Reply-To: <20070619204934.f56722a8.randy.dunlap@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andreas Herrmann <andreas.herrmann3@amd.com>, linux-acpi@vger.kernel.org

On Tue, 19 Jun 2007 20:49:34 -0700 Randy Dunlap wrote:

> On Tue, 19 Jun 2007 23:38:02 -0400 Len Brown wrote:
> 
> > On Tuesday 19 June 2007 18:50, Andreas Herrmann wrote:
> > > Avoid compile warning if !ACPI_BLACKLIST_YEAR
> > > 
> > >   CC      drivers/acpi/blacklist.o
> > >   drivers/acpi/blacklist.c:76:5: warning: "CONFIG_ACPI_BLACKLIST_YEAR" is not defined
> > 
> > How were you able to produce a .config with CONFIG_ACPI_BLACKLIST_YEAR not defined?
> > Can you send it to me?
> 
> 'make randconfig' does that kind of thing.  It doesn't enforce/follow
> "select" clauses.

I should have also said:  randconfig is good for detecting some
missing conditions/configs or missing header files, but if you find one
that is just plain Invalid (like some of these), just say so
and do whatever you want with the patch (IMHO of course).


> > thanks,
> > -Len
> > 
> > > Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> > > ---
> > >  drivers/acpi/blacklist.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> > > index 3ec110c..ac96c47 100644
> > > --- a/drivers/acpi/blacklist.c
> > > +++ b/drivers/acpi/blacklist.c
> > > @@ -73,7 +73,7 @@ static struct acpi_blacklist_item acpi_blacklist[] __initdata = {
> > >  	{""}
> > >  };
> > >  
> > > -#if	CONFIG_ACPI_BLACKLIST_YEAR
> > > +#if	defined(CONFIG_ACPI_BLACKLIST_YEAR) && CONFIG_ACPI_BLACKLIST_YEAR
> > >  
> > >  static int __init blacklist_by_year(void)
> > >  {
> > -

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
