From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: posible bug 2.6.9: allow config to specify custom DSDT (Ulf Dambacher)
Date: Thu, 21 Oct 2004 22:37:59 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3001C104A9@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: brian-/bzczjCP1d2sTnJN9+BGXg@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Note that CONFIG_ACPI_CUSTOM_DSDT depends on
CONFIG_STANDALONE=3Dn

The reason is that otherwise the allmodconfig and allyesconfig builds
break.

thanks,
-Len
=20

>-----Original Message-----
>From: Brian Pritchard [mailto:brian-/bzczjCP1d2sTnJN9+BGXg@public.gmane.org]=20
>Sent: Wednesday, October 20, 2004 5:21 PM
>To: Brown, Len
>Subject: posible bug 2.6.9: [ACPI] allow config to specify=20
>custom DSDT (Ulf Dambacher)
>
>Hi,
>in the change log:
>[ACPI] allow config to specify custom DSDT (Ulf Dambacher)
>
>but i can't seem to find this option
>


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
