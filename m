From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Clean up whitespace of indentation
Date: Tue, 7 Nov 2017 15:09:55 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E6183BD@ORSMSX110.amr.corp.intel.com>
References: <1509154461-23909-1-git-send-email-bhe@redhat.com>
 <20171107104324.GA14732@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:52905 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbdKGPJ5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Nov 2017 10:09:57 -0500
In-Reply-To: <20171107104324.GA14732@x1>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Baoquan He <bhe@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "Schmauss, Erik" <erik.schmauss@intel.com>

Anything like this probably happens during the conversion of ACPICA code to Linux-style code. This conversion happens after every release (monthly) of ACPICA.

Specifically indent/lindent seems to do things like this, if I remember correctly.


> -----Original Message-----
> From: Baoquan He [mailto:bhe@redhat.com]
> Sent: Tuesday, November 7, 2017 2:43 AM
> To: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org
> Cc: rjw@rjwysocki.net; lenb@kernel.org; Moore, Robert
> <robert.moore@intel.com>; Zheng, Lv <lv.zheng@intel.com>
> Subject: Re: [PATCH] ACPICA: Clean up whitespace of indentation
> 
> PING!
> 
> On 10/28/17 at 09:34am, Baoquan He wrote:
> > Use tabs (not spaces) for indentation.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/acpi/actbl1.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h index
> > 6b8714a428b6..d8a4fc066abe 100644
> > --- a/include/acpi/actbl1.h
> > +++ b/include/acpi/actbl1.h
> > @@ -1438,9 +1438,9 @@ struct acpi_srat_mem_affinity {
> >  	u16 reserved;		/* Reserved, must be zero */
> >  	u64 base_address;
> >  	u64 length;
> > -       u32 reserved1;
> > +	u32 reserved1;
> >  	u32 flags;
> > -       u64 reserved2;	       /* Reserved, must be zero */
> > +	u64 reserved2;	       /* Reserved, must be zero */
> >  };
> >
> >  /* Flags */
> > --
> > 2.5.5
> >
