From: Herman Sheremetyev <mlists-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: PBLK length again
Date: Thu, 24 Jun 2004 14:08:31 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1088100511.10272.61.camel@camel>
References: <BAY16-F112kKIBXEHt30004aded@hotmail.com>
	 <20040620154726.GT20511@parcelfarce.linux.theplanet.co.uk>
	 <1087770015.23371.27.camel@djinn> <40D73F9E.4030805@pca.it>
	 <1087850404.2501.43.camel@camel>
	 <20040623133208.GA3152@message-id.gmane0305.slipkontur.de>
	 <20040624162117.GA697@hell.org.pl>
Reply-To: mlists-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040624162117.GA697-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Karol,

> Well, since Intel shipped / still ships chipsets that actually do have a 
> PBLK of length 7, that's somehow odd.
> Best regards,

If what you're saying is right then this patch should probably be included 
in the main source since right now value of 6 is the only one hardcoded in
to be accepted.  Is there some other place than this list I should submit it?

Thanks,

-Herman

--- linux-2.6.7/drivers/acpi/processor.c        2004-06-20 14:49:10.066168648 -0400
+++ linux-2.6.7.hack/drivers/acpi/processor.c   2004-06-19 21:26:33.000000000 -0400
@@ -2214,7 +2230,8 @@

        if (!object.processor.pblk_address)
                ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No PBLK (NULL address)\n"));
-       else if (object.processor.pblk_length != 6)
+       else if ((object.processor.pblk_length != 6 ) &&
+               (object.processor.pblk_length != 7 ))
                ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid PBLK length [%d]\n",
                        object.processor.pblk_length));
        else {
@@ -2233,7 +2250,7 @@
                 *
                 * (In particular, allocating the IO range for Cardbus)
                 */
-               request_region(pr->throttling.address, 6, "ACPI CPU throttle");
+               request_region(pr->throttling.address, object.processor.pblk_length, "ACPI CPU throttle");
                request_region(acpi_fadt.xpm_tmr_blk.address, 4, "ACPI timer");
        }




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
