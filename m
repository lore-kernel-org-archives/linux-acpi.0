From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: ACPI Compaq Presario
Date: Tue, 30 Jul 2002 12:08:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730110827.GB8277@clara.net>
References: <1027988630.1812.9.camel@p2710>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1027988630.1812.9.camel-QUVSR2uV0NY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Troy Schultz <tschultz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org>
Cc: "A.MAINS" <armains-ZO4F0KnmCDHk1uMJSBkQmQ@public.gmane.org>, ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Troy Schultz [tschultz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org] wrote:
> In my daily digest of ACPI messages I see you have a Compaq Presario
> 2700 Notebook and are trying to get Linux running.
> 
> Here is a link to my web page with my experiences with my 2710CA
> notebook and Linux. 
> http://www.schultzcentral.org/notebook/notebook.html
> 
> I have made some changes to my DSDT and have fairly good ACPI support. 
> I do have battery and thermal, and can pick between two CPU speeds.  I
> have not tried Suspend/Resume as I have no need for it at this time.
> 
> Please send me a copy of your /proc/acpi/dsdt file and I'll compare it
> to the ones I have on file.  I should be able to send you a "corrected"
> DSDT that will run on your system.

I have a 2701 EA and have documented my experiences on
http://dude.noc.clara.net/~faye/compaq2701ea/

I created a patch which includes the 0709 ACPI, nocorruption and also
Firewire and USB patches.  All the hardware works on my laptop and I
have Battery, AC, Thermal, Processor, Events and Alarms.

I've repeated the patches with 0725 but I haven't yet tested that
sufficiently to put it on the website.

It's possible the 2700 is similar enough to the 2701 to have the same
DSDT in which case you could just compile the patched kernel, install
and go.  My DSDT is also available on that page separately so you could
check before installing.

My advice would be not to install it as your main kernel until you are
satisfied everything is working correctly (or at least better than your
old kernel did!)


Faye

-- 
Faye Pearson,
Software Development Manager,
ClaraNET Ltd.       Tel 020 7903 3000

checkuary, n:
	The thirteenth month of the year.  Begins New Year's Day and ends
	when a person stops absentmindedly writing the old year on his checks.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
