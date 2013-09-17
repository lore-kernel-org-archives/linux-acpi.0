From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 06/14] ACPICA: Validate start object for
 acpi_walk_namespace.
Date: Tue, 17 Sep 2013 02:56:51 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FEED6FF@ORSMSX103.amr.corp.intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
	<557903201460512616d36b45c10d989f7196a690.1377844863.git.lv.zheng@intel.com>
 <CAJvTdKnjwTG+M-2-xKQnhd0e1GfT8VeqxBLm+zQ31xmjEKKz2g@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E8802463FD2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28067 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab3IQC5c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Sep 2013 22:57:32 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802463FD2@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

Just adds a sanity check. I don't think we see it, otherwise the caller would fault dead in its tracks.


> -----Original Message-----
> From: Zheng, Lv
> Sent: Monday, September 16, 2013 6:26 PM
> To: Len Brown
> Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi
> Subject: RE: [PATCH 06/14] ACPICA: Validate start object for
> acpi_walk_namespace.
> 
> Hi, Bob
> 
> Could you help to answer this?
> Thanks in advance.
> 
> Best regards
> -Lv
> 
> > From: linux-acpi-owner@vger.kernel.org
> > [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Len Brown
> > Sent: Tuesday, September 17, 2013 8:44 AM
> >
> > This was filed an fixed very quickly.
> > Is it something we see in the field?
> > The patch is small, should we mark it for -stable?
> >
> > thanks
> >
> > On Thu, Sep 12, 2013 at 4:55 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> > > From: Bob Moore <robert.moore@intel.com>
> > >
> > > Perform a sanity check on the start object to prevent problems
> > > later. ACPICA BZ 1025.
> > >
> > > Buglink: http://bugs.acpica.org/show_bug.cgi?id=1025
> > > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > > ---
> > >  drivers/acpi/acpica/nsxfeval.c |    8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/acpi/acpica/nsxfeval.c
> > > b/drivers/acpi/acpica/nsxfeval.c index b38b4b0..481a6b4 100644
> > > --- a/drivers/acpi/acpica/nsxfeval.c
> > > +++ b/drivers/acpi/acpica/nsxfeval.c
> > > @@ -605,11 +605,19 @@ acpi_walk_namespace(acpi_object_type type,
> > >                 goto unlock_and_exit;
> > >         }
> > >
> > > +       /* Now we can validate the starting node */
> > > +
> > > +       if (!acpi_ns_validate_handle(start_object)) {
> > > +               status = AE_BAD_PARAMETER;
> > > +               goto unlock_and_exit2;
> > > +       }
> > > +
> > >         status = acpi_ns_walk_namespace(type, start_object, max_depth,
> > >                                         ACPI_NS_WALK_UNLOCK,
> > >                                         descending_callback,
> ascending_callback,
> > >                                         context, return_value);
> > >
> > > +      unlock_and_exit2:
> > >         (void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
> > >
> > >        unlock_and_exit:
> > > --
> > > 1.7.10
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > > linux-acpi" in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> > --
> > Len Brown, Intel Open Source Technology Center
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
