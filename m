From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: acpi_enable_wakeup_device question
Date: Mon, 23 Aug 2004 13:12:55 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408231312.59209.dtor_core@ameritech.net>
References: <B44D37711ED29844BEA67908EAF36F039EA6FA@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F039EA6FA-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 23 August 2004 01:29 am, Li, Shaohua wrote:
> Hi,
> Please look at the P212 in 2.0a or P215 in 2.0c(_PRW method). The reason
> is ACPI recommend disabling interrupt, please look at the example at the
> end of the section. Yes, enabling interrupt possibly doesn't matter (my
> test shows it works), but we don't know if it works for all systems, so
> we just obey to spec.
> 

Thank you for pointing the exact place in the spec, although I do not
agree with your reading of it. I think it says that before entering the
sleep state all 3 conditions should be satisfied, but it does not
necessarily specifies the order in which the actions should be performed.
For example checking the validity of requested sleep state in no way
relies on interupts being disabled as _PRW is required to return the same
information every time it is invoked and as far as I can see Linux ACPI
implementation only executes it at device scan.

I think that it is safe to move acpi_enable_wakeup_device up a bit;
having interrupts disabled when entering sleep state is completely
reasonable though.

-- 
Dmitry


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
