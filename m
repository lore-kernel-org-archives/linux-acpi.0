From: "Robert M. Peterson" <robertmpeterson-Bdlq13kUjeyLZ21kGMrzwg@public.gmane.org>
Subject: Re: Acpi-devel digest, Vol 1 #1632 - 7 msgs
Date: Sat, 28 Feb 2004 18:15:09 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078010109.1436.7.camel@debian>
References: <20040228220646.WGNP26103.imf02aec.mail.bellsouth.net@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040228220646.WGNP26103.imf02aec.mail.bellsouth.net-ek0oC1U1TqqnvZpeIfgr/KQD96bmaF075NbjCUgZEJk@public.gmane.org>
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

On Sat, 2004-02-28 at 17:09, acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
wrote:

> 
> Message: 5
> From: "Robert M. Peterson" <robertmpeterson-Bdlq13kUjeyLZ21kGMrzwg@public.gmane.org>
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Date: Sat, 28 Feb 2004 17:18:28 -0500
> Subject: [ACPI] problems with acpi_button in a 2.6 kernel running on a dell i8500
> 
> The button to turn the lcd screen off (as when the lid is closed) has
> isn't functional. Also, I found this error in Dmesg: Dell Inspiron with
> broken BIOS detected. Refusing to enable the local APIC. Other areas of
> ACPI seem to be functioning properly as the battery status
> (charging/discharging) and charge level are accurately reported.
> 
> Any help would be welcome

I have never used mailing lists before, so if my ettiquette is a bit
off, please excuse me; I did some more research and I have found out
that acpi does in fact properly detect my lid button events... however
it doesn't do anything after that. I am not sure if the problem is with
suspend states or what.

-Robert



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
