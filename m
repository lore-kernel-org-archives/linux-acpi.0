From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: help needed with invalid method in GPE block
Date: Tue, 18 Mar 2003 01:19:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030318001918.GA651@dutidad.twi.tudelft.nl>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BBCC@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19BBCC-LkGsggTGxVmSsB6bSF6DdVDQ4js95KgL@public.gmane.org>
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

On Mon, Mar 17, 2003 at 03:57:00PM -0800, Moore, Robert wrote:
> Here's what the code should look like
> 
>     /* Ensure that we have a valid GPE number for this GPE block */
> 
>     if ((GpeNumber < GpeBlock->BlockBaseNumber) ||
>         (GpeNumber >= (GpeBlock->BlockBaseNumber + (GpeBlock->RegisterCount
> * 8))))
>     {
>         /* 
>          * Not valid for this GPE block, just ignore it
>          * However, it may be valid for a different GPE block, since GPE0
> and GPE1
>          * methods both appear under \_GPE.
>          */
>         return (AE_OK);
>     }

Aaaah, the "if" is now clearly corrected.  The way it was did constitute a
bug, right?  It resulted in control methods that were valid for the second
GPE block not getting added.

My frikking sleep button is still not waking my laptop up though.  I would
appreciate any other tips for debugging that problem.

Thanks,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
