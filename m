From: Sebastian Seifert <lathander-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: clear/enable power button on resume
Date: Sun, 7 Mar 2004 23:43:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040307224318.GA1551@ergo.gotdns.org>
References: <1078685555.541.9.camel@sunshine> <404B7A1B.80006@pca.it> <1078689765.541.20.camel@sunshine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1078689765.541.20.camel-eqrHSpLoP5M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Mar 07, 2004 at 09:02:46PM +0100, Timo Hoenig wrote:
> Thanks. But I don't use the power event anyway. As long as acpi works I
> am happy with suspend / resume. rm -rf /etc/acpi/events/powerbtn did it
> for me.

That's what I did, too. On my system, it happens after S3 sleep (I
haven't tested S1/S2). 

And the power button is the only way to power on after S3, since all
other wake-capable devices aren't enabled.

> Isn't the acpi spec telling whether the pressing of the power button
> after suspending has to be reported to the OS?

The ACPI spec says that the pressing of a button (e.g. the power button)
that leads to a wake event is reported differently to the OS. The Notify
value (second column in output of /proc/acpi/event) of a regular button event 
is 0x80, that of a wake event is 0x02. Nevertheless, on my system, 0x80
is generated for a power button wake. Strange.

Sebastian


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
