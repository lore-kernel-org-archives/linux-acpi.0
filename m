From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: RE: help needed with invalid method in GPE block
Date: 18 Mar 2003 09:51:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1047977474.2189.16.camel@dutidad>
References: <F760B14C9561B941B89469F59BA3A84725A201@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A201-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2003-03-18 at 01:34, Grover, Andrew wrote:
> > From: Charl P. Botha [mailto:c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org] 
> > My frikking sleep button is still not waking my laptop up 
> > though.  I would
> > appreciate any other tips for debugging that problem.
> 
> I would guess that we are disabling your sleep button's GPE when we are
> sleeping.

Yes!  After going to bed last night, I remembered reading about the
various wake-up capable devices being enabled or disabled.

> To verify this, you might try calling _PRW from the button driver (or
> just look at the ASL), and then using that GPE number call
> acpi_enable_gpe(gpe_num, NULL, ACPI_EVENT_WAKE_ENABLE).

Hmmm, there are several other wake-up devices writing to GPE bit 0x1D,
e.g.:

Device (LID)
{
   Name (_HID, EisaId ("PNP0C0D"))
   Name (_PRW, Package (0x02)
   {
      0x1D, 
      0x03
   })
...

but the corresponding method in the _GPE namespace, _L1D(), Notify()s
the OS about wakeup (event 0x02) and sends only the button object along.

If I do acpe_enable_gpe(0x1D, NULL, ACPI_EVENT_WAKE_ENABLE), will it
mean that all these other devices will also be able to wake the laptop
up from S3?  My DSDT is at http://cpbotha.net/thingies/dsdt.asl.original

> This is not the correct long-term solution but it should at least verify
> the root cause of the problem...

Great.  I will try this tonight, thank you very much.  What would be the
Right Way(tm) of fixing this?

Thanks again,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
