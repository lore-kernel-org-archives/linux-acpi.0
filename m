From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: help needed with invalid method in GPE block
Date: 18 Mar 2003 09:54:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1047977655.2192.20.camel@dutidad>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BBCC@orsmsx107.jf.intel.com>
	 <20030318001918.GA651@dutidad.twi.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030318001918.GA651-V1rPnKwUOrA59+mn7qD7y50iERQUc4G+@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2003-03-18 at 01:19, Charl P. Botha wrote:
> On Mon, Mar 17, 2003 at 03:57:00PM -0800, Moore, Robert wrote:
> > Here's what the code should look like
> > 
> >     /* Ensure that we have a valid GPE number for this GPE block */
> > 
> >     if ((GpeNumber < GpeBlock->BlockBaseNumber) ||
> >         (GpeNumber >= (GpeBlock->BlockBaseNumber + (GpeBlock->RegisterCount
> > * 8))))
> >     {
> >         /* 
> >          * Not valid for this GPE block, just ignore it
> >          * However, it may be valid for a different GPE block, since GPE0
> > and GPE1
> >          * methods both appear under \_GPE.
> >          */
> >         return (AE_OK);
> >     }
> 
> Aaaah, the "if" is now clearly corrected.  The way it was did constitute a
> bug, right?  It resulted in control methods that were valid for the second
> GPE block not getting added.

BTW, before making this change, my laptop would go INSTANTLY to sleep if
I pressed the sleep button.  After applying it, messages flash by
indicating that the kernel is preparing devices for the suspend.

This would mean that, in my case, the handler for method _L1D() was not
being added (in either GPE block), so the Notify() by that method was
not getting handled by the kernel, which was a bad thing.

Will this fix go into the next BK push, or whatever it's called?

Thanks,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
