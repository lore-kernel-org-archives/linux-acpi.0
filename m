From: Ken Hughes <khughes-s7p20SfEDVaVc3sceRu5cw@public.gmane.org>
Subject: Re: Presario R3120US not updating present rate
Date: Thu, 17 Jun 2004 10:48:17 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40D1D961.7050504@pacific.edu>
References: <20040614215520.GA17906@dominikbrodowski.de> <40CE5F69.7030500@pacific.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40CE5F69.7030500-s7p20SfEDVaVc3sceRu5cw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ken Hughes <khughes-s7p20SfEDVaVc3sceRu5cw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ken Hughes wrote:
> I noticed that I alway get "present rate: 0 mA" when I
> cat /proc/acpi/battery/BAT1/state .  Running acpi -ab
> gives the following:
> 
>  35 budgie: ./acpi -ab
>      Battery 1: charging, 88%, charging at zero rate - will never fully 
> charge.
>    AC Adapter 1: on-line
>  36 budgie: ./acpi -ab
>      Battery 1: discharging, 88%, charging at zero rate - will never 
> fully charge.
>    AC Adapter 1: off-line

Discovered that one field read from the embedded controller actually
returns the precentage of charge remaining in the battery.

In any case, is there a way thru software to determine the type of
embedded controller?  I'd rather not take the screwdriver to my
laptop to find out.

Thanks -- Ken


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
