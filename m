From: Gertjan <g.zwartjes-oe7qfRrRQfdlL9U78CI+FQ@public.gmane.org>
Subject: Re: Asus ACPI Hotkeys
Date: Fri, 9 May 2003 16:17:02 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030509161702.0df6e715.g.zwartjes@student.tue.nl>
References: <20030503112602.3d2ac1c3.g.zwartjes@student.tue.nl>
	<Pine.LNX.4.53.0305031214220.4945@tweety.gaugusch.at>
	<20030503123325.5246f48f.g.zwartjes@student.tue.nl>
	<20030503141516.GA29022@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030503141516.GA29022-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Julien Lerouge <julien.lerouge-o/5/jSaJEHk+NdeTPqioyti2O/JbrIOy@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi both,

I tested it and the driver works for my Asus L3400D too! I'll put up a
page about Linux on the Asus L3400D within a few days... I use kernel 2.5
in stead of 2.4 for better ACPI and CPU frequency scaling support and I'll
take a look at this driver to port it to 2.5. Will this driver be
supported in the ACPI patch sooner or later? What has to be done to have
it supported in the ACPI patch? Maybe it is a good idea to use
/proc/acpi/event and /proc/acpi/button in stead of /proc/acpi/asus/hotk.
Maybe /proc/acpi/led can be introduced for the status leds... Please let
me know what I can do...

Regards,

Gertjan


On Sat, 3 May 2003 16:15:16 +0200 Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
wrote:

> Thus wrote Gertjan:
> > It just seems that no support for these buttons is in the kernel yet.
> 
> There is currently a driver, made by Julien Lerouge
> (http://julien.lerouge.free.fr) that supports both these buttons, and
> the 2 status LEDs. I'm currently beginning to work on developing this
> driver further on, so if you're willing to contribute, you're welcome.
> 
> What exactly is the model (and the BIOS version) of the laptop you have?
> 
> Best regards,
> 
> -- 
> Karol 'sziwan' Kozimor
> sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
