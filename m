From: Alexander Isacson <alexander-O4oeKNg1Q5OZuzBka8ofvg@public.gmane.org>
Subject: Re: acer TM 233 s3 problem: screen does not resume, no
	autohalt
Date: Thu, 26 Feb 2004 17:32:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077813152.5989.1.camel@alexanders.isacson.dyndns.info>
References: <20040225014430.GA2559@rap.rap.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040225014430.GA2559-EittdKFJ/bZ/SzgSGea1oA@public.gmane.org>
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

Hi, I have the same problem with the screen not resuming on my Acer 3000
Ferrari. I have had that problem from the first kernel 2.6.0-test6 to my
current kernel 2.6.3. Otherwise ACPI works fine. But I get alot of group
battery / action battery events and some group processor / processor
events that I don't know how to use. What are they for?

/Alexander

> Hi
>
> I have an Acer Travelmate 233 running MDK 10.0 RC1, kernel 2.6.2.
> When I put it in "mem" save and resume it, the screen will not come
> up, but other things work, such as an ssh from another machine.
> Also the cpu does not seem to go into autohalt, consuming about 38 W
> instead of the normal 18 W (ideling)?
>
> Can I turn the screen on with some shell command?
> (from my ssh session)
>
> Why does the cpu not idle halt?
>
> Is there a way to just put the CPU off (seletcet S3 or you could call it
> S2)? I would like to have the ram, screen and keyboard and mouse running,
> and
> the CPU shut down (no power)
> This could happen after ideling for 1 second. How could that be done,
> and any comments on it?
>
> I think I in this way could get down to maybe 11 W.
>
> Or, as it only takes about 0,8 W in S3 mode, it could be:
>
> RAM      0,8 W
> Screen   3,6 W
> Mouse      ? W
> -----------------
> Total    5,0 W
>
> Leaving me 12 hours on my 60000 mWh battery
>
> best regards
> keld
>
>
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
