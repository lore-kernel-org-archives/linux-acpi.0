From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi_enable_wakeup_device question
Date: Mon, 23 Aug 2004 14:29:27 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F039EA6FA@pdsmsx401.ccr.corp.intel.com>
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
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
Please look at the P212 in 2.0a or P215 in 2.0c(_PRW method). The reason
is ACPI recommend disabling interrupt, please look at the example at the
end of the section. Yes, enabling interrupt possibly doesn't matter (my
test shows it works), but we don't know if it works for all systems, so
we just obey to spec.

Thanks,
Shaohua

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Dmitry Torokhov
>Sent: Monday, August 23, 2004 2:19 PM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] acpi_enable_wakeup_device question
>
>Hi,
>
>I see the following comment in drivers/acpi/sleeip/wakeup.c:
>
>/**
> * acpi_enable_wakeup_device - enable wakeup devices
> *      @sleep_state:   ACPI state
> * Enable all wakup devices's GPE
> */
>void
>acpi_enable_wakeup_device(
>        u8              sleep_state)
>{
>        struct list_head * node, * next;
>
>
>        /*
>         * Caution: this routine must be invoked when interrupt is
disabled
>         * Refer ACPI2.0: P212
>         */
>
>But I can not seem to find anything related to that on p.212 ACPI 2.0c.
>As far as I can tell functions called by acpi_enable_wakeup_device
(such
>as acpi_set_gpe_type and acpi_enable_gpe) can be safely called from
>process context. Why this function has to be called with interrupts
>disabled?
>
>Thanks!
>
>--
>Dmitry
>
>
>-------------------------------------------------------
>SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
>100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
>Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
>http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
