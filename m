From: Andrew Kohlsmith <akohlsmith-acpi-uiYP0llB1AZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Compaq Evo N160: Fixed DSDT - battstat_applet works now
Date: Sat, 21 Dec 2002 13:52:42 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212211352.42773@-mixdown.ca>
References: <3DFB6C25.4030805@gmx.net> <200212201958.53205@-mixdown.ca> <3E049608.8030807@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E049608.8030807-hi6Y0CQ0nG0@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> One question arose during the last days: What is the "last full
> capacity" of your battery? Is it near 4000 mAh as specified by Compaq?

I've currently see 3357mAh in the "last full capacity" -- I too patched 
klaptopdaemon to use this value instead of the design capacity since I'd only 
ever get as high as 98%, which suggests 3920mAh was seen at some point.  :-)

> I'm not really satisfied with this "solution" either, as "my" value of
> 3357 mAh probably is only correct for my special Evo n160 (or to be more
> precise: my one's battery) at a special time.

Exactly -- I just patched klaptopdaemon to keep the highest "last full 
capacity" as a high-water mark (but it isn't persistent).

Regards,
Andrew


-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
