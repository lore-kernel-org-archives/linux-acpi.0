From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 01/12] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to
 enable this ACPI mode
Date: Mon, 25 Nov 2013 08:14:24 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880248D268@SHSMSX101.ccr.corp.intel.com>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
 <1384047382-20623-2-git-send-email-al.stone@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E880248C95D@SHSMSX101.ccr.corp.intel.com>
 <528F2A4F.90908@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E880248D23D@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23476 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778Ab3KYIO3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Nov 2013 03:14:29 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880248D23D@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Hanjun Guo <hanjun.guo@linaro.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Al Stone <ahs3@redhat.com>

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Zheng, Lv
> Sent: Monday, November 25, 2013 3:44 PM
> 
> HI,
> 
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Hanjun Guo
> > Sent: Friday, November 22, 2013 5:57 PM
> >
> > On 2013-11-22 14:14, Zheng, Lv wrote:
> > [...]
> > >>  endif	# ACPI
> > >> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
> > >> index 28f4f4d..ae93a91 100644
> > >> --- a/include/acpi/platform/aclinux.h
> > >> +++ b/include/acpi/platform/aclinux.h
> > >> @@ -67,6 +67,10 @@
> > >>
> > >>  /* Host-dependent types and defines for in-kernel ACPICA */
> > >>
> > >> +#ifdef CONFIG_ACPI_REDUCED_HARDWARE
> > >> +#define ACPI_REDUCED_HARDWARE TRUE
> > >> +#endif
> > >> +
> > >
> > > Maybe you put this here because of my previous wrong comment.
> > >
> > > For ACPICA environments that work like Kconfigs for Linux, it is good to define them before including any ACPICA files.
> > > While putting things here cannot cover <asm/acpi.h>.
> >
> > Good catch! thanks for the reminding.
> >
> > >
> > > Normally, I will do:
> > >
> > > ...
> > >
> > > #ifdef __KERNEL__
> > >
> > > /* some comment */
> > > (one empty line as ACPICA enforces 1 empty line after 1 line comment and no empty lines after a block of comments)
> > > #ifdef CONFIG_ACPI_REDUCED_HARDWARE
> > > #define ACPI_REDUCED_HARDWARE(spaces not tabs here according to ACPICA's coding style)TRUE
> > > #endif
> > >
> > > #include <linux/string.h>
> >
> > There is a problem when I try yours suggestion, it is a compiling warning:
> >
> > warning: "TRUE" is not defined
> >
> > And I find that "TRUE" is defined in include/acpi/actypes.
> >
> > So, is this ok to you?
> 
> ... How ugly the TRUE is.
> OK, you can keep your original code as this is really not a real issue, just a tricky point.
> I'll try to offer a cleanup after another ACPICA cleanup that tries to modify all "#if" condition related TRUE into "1" in ACPICA.

I checked ACPICA code base and found there is really nothing need to be cleaned up.

Why not:
+#ifdef CONFIG_ACPI_REDUCED_HARDWARE
+#define ACPI_REDUCED_HARDWARE 1
+#endif

If you take a look at generated/autoconf.h, such environmental conditions should be 1 rather than TRUE as they are meant to be included prior than any source code.

Thanks and best regards
-Lv

> 
> Thanks and best regards
> -Lv
> 
> >
> > --- a/include/acpi/platform/aclinux.h
> > +++ b/include/acpi/platform/aclinux.h
> > @@ -63,6 +63,13 @@
> >  #ifdef EXPORT_ACPI_INTERFACES
> >  #include <linux/export.h>
> >  #endif
> > +
> > +#define TRUE    (1 == 1)
> > +
> > +#ifdef CONFIG_ACPI_REDUCED_HARDWARE
> > +#define ACPI_REDUCED_HARDWARE TRUE
> > +#endif
> > +
> >  #include <asm/acpi.h>
> >
> > >
> > > The coding style can help ACPICA release process to generate correct Linuxized patches.
> > > It would be good to Linux developers to follow this currently for ACPICA internal code or we may see a small useless divergences
> > commit generated from a back ported Linux commit :-( .
> > > I'm sorry for the inconvenience.
> >
> > ok, will update in next version.
> >
> > >
> > > Thanks
> > > -Lv
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
