From: Peter Meier <crazy-b-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Several problems with sleep states
Date: Fri, 27 Feb 2004 15:28:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077892124.10771.25.camel@homer>
References: <403F0BA9.6060905@lip6.fr> <1077876965.10771.15.camel@homer>
	 <20040227121824.GA8316@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040227121824.GA8316-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Nicolas Sabouret <Nicolas.Sabouret-L2FTfq7BK8M@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Fri, 2004-02-27 at 13:18, Karol Kozimor wrote:
> On the contrary, the current radeonfb from 2.6.3 does restore the console
> contents. That said, the backlight might still be a problem, but this is
> usually independent of the display driver.
> Best regards,

Actually, I had no success with 2.6.3-mm4 and the new radeonfb driver
for restoring the console. Even worse, using the radeonfb driver, I was
not abled to restore x11 anymore. Using the patch Giridhar Pemmasani
posted here some days ago, I was abled to get the backlight back, but
still no resume of the console, (Ati Radeon 9000 Mobility, I think its
R250). Its not that bad for me, its cool that x11 works :-)

With best regards, P.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
