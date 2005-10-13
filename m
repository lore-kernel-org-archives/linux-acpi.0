From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC]convert ACPI driver model to Linux driver model -
	takes 2
Date: Thu, 13 Oct 2005 16:32:53 +0800
Message-ID: <1129192373.10268.1.camel@linux-hp.sh.intel.com>
References: <20051013081837.PTGN24578.fep01-app.kolumbus.fi@mta.imail.kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051013081837.PTGN24578.fep01-app.kolumbus.fi-7B1qVitd7rZYRdgNIgFt/t8DI8KqlI9s@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mika.penttila-9Aww8k/80nUxHbG02/KK1g@public.gmane.org
Cc: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-10-13 at 11:18 +0300, mika.penttila-9Aww8k/80nUxHbG02/KK1g@public.gmane.org wrote:
> >+/* this driver is linking acpi device with acpi phys device */
> >+static struct acpi_driver dummy_driver = {
> >+ .name = "acpi_dummy",
> >+ /* List all ids of ACPI phys devices */
> >+ .ids =
> >+// "PNP0C09," /* EC */
> >+// "ACPI0003," /* AC */
> >+// "PNP0C0F," /* Link */
> >+// "PNP0C0A," /* battery */
> >+// "PNP0C0C,PNP0C0E,PNP0C0D,ACPI_FPB,ACPI_FSB," /* button */
> >+// "PNP0C0B," /* fan */
> >+// "PNP0A03," /* PCI root */
> >+// ACPI_POWER_HID"," /* power */
> >+// ACPI_PROCESSOR_HID"," /* CPU */
> >+// ACPI_THERMAL_HID"," /* thermal */
> >+ "",
> >+ .ops = {
> >+ .add = acpi_phys_bus_add,
> >+ .remove = acpi_phys_bus_remove,
> >+ },
> >+};
> 
> Are those ids meant to be commented out in the dummy driver?
The patch is just to show my idea not for merging, so there is some
debug info. Please ignore them currently. I'm sorry I didn't mention
this in previous email.

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
