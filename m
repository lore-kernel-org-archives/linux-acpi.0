From: Herman Sheremetyev <mlists-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
Subject: PBLK length again
Date: Sun, 20 Jun 2004 18:20:43 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1087770015.23371.27.camel@djinn>
References: <BAY16-F112kKIBXEHt30004aded@hotmail.com>
	 <20040620154726.GT20511@parcelfarce.linux.theplanet.co.uk>
Reply-To: mlists-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-yoUHmFuORoPanLyHP21Z"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040620154726.GT20511-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
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


--=-yoUHmFuORoPanLyHP21Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi All,

I have an Asus M6N and the Bios DSDT provides a PBLK length of 7 which
causes ACPI to always use the C1 processor state.  This laptop
definitely supports C2 and most people have just used custom DSDT's and
changed the value to 6.  I don't like using a custom DSDT so I made a
quick kernel patch (attached) to accept 7 as a good value.

I've searched the archives and found that other people have had issues
with PBLK being set to something other than 0 or 6 and at one point the
ACPI code was relaxed to allow for other values but then changed back to
the original strict mode due to issues with C2 being used when it
shouldn't be.  There was also talk of making the relaxed code optional
but it seems that never got off the ground.  

My question is, if I make a nicer patch that allows for either strict
interpretation versus a relaxed one, is there a chance that it will get
included?  It seems there is enough interest out there to make it worth
the effort.

Thanks,

-Herman

 

--=-yoUHmFuORoPanLyHP21Z
Content-Disposition: attachment; filename=pblk_length-7-hack.patch
Content-Type: text/x-patch; name=pblk_length-7-hack.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.7/drivers/acpi/processor.c	2004-06-20 14:49:10.066168648 -0400
+++ linux-2.6.7.hack/drivers/acpi/processor.c	2004-06-19 21:26:33.000000000 -0400
@@ -2214,7 +2230,8 @@
 
 	if (!object.processor.pblk_address)
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No PBLK (NULL address)\n"));
-	else if (object.processor.pblk_length != 6)
+	else if ((object.processor.pblk_length != 6 ) && 
+		(object.processor.pblk_length != 7 ))
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid PBLK length [%d]\n",
 			object.processor.pblk_length));
 	else {
@@ -2233,7 +2250,7 @@
 		 *
 		 * (In particular, allocating the IO range for Cardbus)
 		 */
-		request_region(pr->throttling.address, 6, "ACPI CPU throttle");
+		request_region(pr->throttling.address, object.processor.pblk_length, "ACPI CPU throttle");
 		request_region(acpi_fadt.xpm_tmr_blk.address, 4, "ACPI timer");
 	}
 

--=-yoUHmFuORoPanLyHP21Z--



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
