From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: fix ACPI poweroff in 2.4.25-rc2
Date: Wed, 3 Mar 2004 13:05:31 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403031305.31966.bjorn.helgaas@hp.com>
References: <200403031117.25937.bjorn.helgaas@hp.com> <20040303194656.GV25779@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040303194656.GV25779-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 03 March 2004 12:46 pm, Matthew Wilcox wrote:
> On Wed, Mar 03, 2004 at 11:17:25AM -0700, Bjorn Helgaas wrote:
> > ===== drivers/acpi/system.c 1.18 vs edited =====
> > --- 1.18/drivers/acpi/system.c	Tue Mar  2 14:50:40 2004
> > +++ edited/drivers/acpi/system.c	Wed Mar  3 10:43:11 2004
> > @@ -95,7 +95,9 @@
> >  {
> >  	if (unlikely(in_interrupt())) 
> >  		BUG();
> > +#ifdef CONFIG_ACPI_SLEEP
> >  	acpi_system_save_state(ACPI_STATE_S5);
> > +#endif
> 
> Should we not rather define a null acpi_system_save_state() function if
> CONFIG_ACPI_SLEEP is not set?

Here's a patch to do it that way, if you prefer.  acpi_system_save_state()
isn't defined before use, so you get a warning about that, which I didn't
bother to fix (I expect x86 probably sees the same warning).

===== drivers/acpi/system.c 1.18 vs edited =====
--- 1.18/drivers/acpi/system.c	Tue Mar  2 14:50:40 2004
+++ edited/drivers/acpi/system.c	Wed Mar  3 13:03:01 2004
@@ -360,6 +360,15 @@
 	return status;
 }
 
+#else
+
+acpi_status
+acpi_system_save_state(
+	u32			state)
+{
+	return AE_OK;
+}
+
 #endif /* CONFIG_ACPI_SLEEP */
 
 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
