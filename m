From: Heiko Ettelbrueck <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Compaq Evo N160: Fixed DSDT - battstat_applet works now
Date: Sat, 21 Dec 2002 17:25:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E049608.8030807@gmx.net>
References: <3DFB6C25.4030805@gmx.net> <200212201958.53205@-mixdown.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200212201958.53205-T9p8nP5vHr8sA/PxXw9srA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Kohlsmith <akohlsmith-acpi-uiYP0llB1AZBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew Kohlsmith wrote:
> I just wanted to drop a note and say that I've been running this for just 
> about a week now on and off AC and have not had a hang from klaptopdaemon 
> polling the battery status yet.

Thank you for your note - i'm happy to read that it works as I hoped it 
should ;-)

One question arose during the last days: What is the "last full 
capacity" of your battery? Is it near 4000 mAh as specified by Compaq?

As mine only "stores" (what is the right word for this?) 3357 mAh, I 
wasn't satisfied with battstat_applet showing a fill state of only 84% 
when the battery does not charge any more. That's why I patched 
battstat_applet to work with the "last full capacity" instead of 
"maximum capacity": Now it shows 100% when charging has finished. But 
I'm not really satisfied with this "solution" either, as "my" value of 
3357 mAh probably is only correct for my special Evo n160 (or to be more 
precise: my one's battery) at a special time.

So a question to the people who (hopefully) know: Is some piece of ACPI 
code supposed to change the "last full capacity" in the DSDT, as the 
name of the value suggests? Or what else should one understand by this?

Regards,
Heiko



-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
