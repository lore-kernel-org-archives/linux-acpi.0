From: Alberto Ornaghi <alor-G/4Acn03FKk@public.gmane.org>
Subject: Re: Update on my Compaq Presario 730US
Date: Sun, 25 Aug 2002 10:09:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <5.1.0.14.2.20020825100615.019d6c78@wheresmymailserver.com>
References: <5.1.0.14.0.20020825003345.03296a68@pop-server.triad.rr.com
 >
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <5.1.0.14.0.20020825003345.03296a68-oPn9/et4zcN1gFWS+Ai4M0mb8e9+yvj5@public.gmane.org
 >
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Michael Notforyou <sqfreak-goaWJWIt5zpWk0Htik3J/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

At 00.49 25-08-2002, Michael Notforyou wrote:

>Buttons detected:
>lid
>power
>power
>sleep

double power directory is a bug of that version... please use the latest 
20020725 (for 2.4.18) or 20020815 (for 2.4.19)


>Any of the weird (no thermal_zones, no P-states) fixed by newer versions?

IIRC this laptop doesn't have thermal control in ACPI it is hardware 
controlled.

>Also, can I get it to sleep? Or hibernate (save state to disk)?

use the swsusp patch to get hibernation.
http://sourceforge.net/project/showfiles.php?group_id=25964

bye

    --==> ALoR <==---------------------- -  -   -

There are only 10 types of people in this world...
those who understand binary, and those who don't.



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
