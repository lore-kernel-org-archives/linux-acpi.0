From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH v2 8/9] ACPI, APEI,
 CPER: Cleanup CPER memory error output format
Date: Thu, 17 Oct 2013 07:27:38 -0300
Message-ID: <20131017072738.24ea5c05@samsung.com>
References: <1381935366-11731-1-git-send-email-gong.chen@linux.intel.com>
 <1381935366-11731-9-git-send-email-gong.chen@linux.intel.com>
 <20131016172410.GM13608@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]:59198 "EHLO
	usmailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab3JQK1o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2013 06:27:44 -0400
In-reply-to: <20131016172410.GM13608@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, joe@perches.com, naveen.n.rao@linux.vnet.ibm.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Em Wed, 16 Oct 2013 19:24:10 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Wed, Oct 16, 2013 at 10:56:05AM -0400, Chen, Gong wrote:
> > Keep up only the most important fields for memory error
> > reporting. The detail information will be moved to perf/trace
> > interface.
> > 
> > Suggested-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>

Considering the suggested fixes below:

Reviewed-by: Mauro Carvalho Chehab <m.chehab@samsung.com>

> > ---
> >  drivers/acpi/apei/cper.c | 69 +++++++++++++++++++++++-------------------------
> >  1 file changed, 33 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/acpi/apei/cper.c b/drivers/acpi/apei/cper.c
> > index b1a8a55..f5bc227 100644
> > --- a/drivers/acpi/apei/cper.c
> > +++ b/drivers/acpi/apei/cper.c
> > @@ -33,6 +33,9 @@
> >  #include <linux/pci.h>
> >  #include <linux/aer.h>
> >  
> > +#define INDENT_SP	" "
> > +#define HW_CE_INFO \
> > +	"Above error has been corrected by h/w and no further action required"
> 
> Leftover?
> 
> 
> > +	if (severity != CPER_SEV_FATAL)
> > +		printk("%s%s\n", pfx,
> > +		       "Above error has been corrected by h/w "
> > +		       "and require no further action");
> 
> Let's write it out and correct grammar:
> 
> "Above error has been corrected by the hardware and requires no further action."
> 
> Thanks.
> 


-- 

Cheers,
Mauro
