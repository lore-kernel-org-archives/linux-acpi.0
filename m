From: Michael Notforyou <sqfreak-goaWJWIt5zpWk0Htik3J/w@public.gmane.org>
Subject: Re: Problems with T30
Date: Mon, 02 Sep 2002 13:55:03 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <5.1.0.14.0.20020902135446.03408d48@pop-server.triad.rr.com>
References: <20020902151012.GA892@rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3D7383B2.7000704-0XxM1C5uZkkb1SvskN2V4Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

DON'T compile ACPI as a module - that causes problems.


At 05:28 PM 9/2/2002 +0200, you wrote:
>Ethan Glasser-Camp wrote:
>
>>I have spent the past three or four days toying with the kernel, trying 
>>to convince it to allow me to compile debug messages into the ACPI 
>>modules. No can do. I'm not quite sure why, but if I try, make 
>>modules_install will give me unresolved symbol errors.
>does this also happen when you compile acpi not as module but in the
>kernel?
>
>i.e. the .config should say "ACPI.*=y" not "ACPI*=m"
>
>  yours
>  Joerg
>
>
>
>-------------------------------------------------------
>This sf.net email is sponsored by: OSDN - Tired of that same old
>cell phone?  Get a new here for FREE!
>https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel

*Michael Notforyou*

"My God, I'm full of stars!"
Darmok and Jalad at Tanagra!



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
