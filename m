From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] ACPICA: Clean up whitespace of indentation
Date: Wed, 8 Nov 2017 10:10:02 +0800
Message-ID: <20171108021002.GH22644@x1>
References: <1509154461-23909-1-git-send-email-bhe@redhat.com>
 <20171107104324.GA14732@x1>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E6183BD@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbdKHCKI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Nov 2017 21:10:08 -0500
Content-Disposition: inline
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E6183BD@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "Schmauss, Erik" <erik.schmauss@intel.com>

On 11/07/17 at 03:09pm, Moore, Robert wrote:
> Anything like this probably happens during the conversion of ACPICA code to Linux-style code. This conversion happens after every release (monthly) of ACPICA.
> 
> Specifically indent/lindent seems to do things like this, if I remember correctly.

I found it when went through system init code, it was introduced in this
commit and looks very obvious: 

commit 19d0cfe9ddfdf7afa8d1765ab0bd2a7dd30e47c9
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Jun 10 15:54:40 2008 +0800

    ACPICA: Update DMAR and SRAT table definitions

If there has been a mechanism to check them, I am fine to leave it as is
or the tools like lindent to deal with it.

Thanks
Baoquan

> 
> > -----Original Message-----
> > From: Baoquan He [mailto:bhe@redhat.com]
> > Sent: Tuesday, November 7, 2017 2:43 AM
> > To: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org
> > Cc: rjw@rjwysocki.net; lenb@kernel.org; Moore, Robert
> > <robert.moore@intel.com>; Zheng, Lv <lv.zheng@intel.com>
> > Subject: Re: [PATCH] ACPICA: Clean up whitespace of indentation
> > 
> > PING!
> > 
> > On 10/28/17 at 09:34am, Baoquan He wrote:
> > > Use tabs (not spaces) for indentation.
> > >
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  include/acpi/actbl1.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h index
> > > 6b8714a428b6..d8a4fc066abe 100644
> > > --- a/include/acpi/actbl1.h
> > > +++ b/include/acpi/actbl1.h
> > > @@ -1438,9 +1438,9 @@ struct acpi_srat_mem_affinity {
> > >  	u16 reserved;		/* Reserved, must be zero */
> > >  	u64 base_address;
> > >  	u64 length;
> > > -       u32 reserved1;
> > > +	u32 reserved1;
> > >  	u32 flags;
> > > -       u64 reserved2;	       /* Reserved, must be zero */
> > > +	u64 reserved2;	       /* Reserved, must be zero */
> > >  };
> > >
> > >  /* Flags */
> > > --
> > > 2.5.5
> > >
