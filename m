From: Sean Middleditch <elanthis-LAuFFeG505qL5ISr76wZmQ@public.gmane.org>
Subject: Re: lockup on boot
Date: 28 Sep 2002 14:53:35 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1033239215.3157.2.camel@stargrazer>
References: <1032631567.23480.23.camel@stargrazer>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1032631567.23480.23.camel-5lwDtw4hGk+puJRAN1am9g@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ack, sorry the third post, but it dawns on me I was an idiot and didn't
post what machine I'm using:

It's a Compaq Presario 700US laptop.

On Sat, 2002-09-21 at 14:06, Sean Middleditch wrote:
> Hi,
> 
>  Using kernel 2.4.20-pre7 with the 20020918 ACPI patch, I'm unable to
> boot the machine.
> 
>  With debugin off, it gets as far as
> PCI: Using configuration type 1
> 
>  Turning debugging on, the messages following the above are
> (approximately - no cut and paste ~,^):
> 
>  tbxface-0099 [03] Acpi_load_tables    : ACPI Tables successfully loaded
> Parsing Methods: ... (many dots)
> Table [DSDT] - 441 Objects with 45 Devices 109 Methods 15 Regions
> Parsing Methods: (complete lack of dots)
> Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
> ACPI Namespace successfully loaded at root c02f705c
> 
>  And that's it.  It's sat there for around 10 minutes and nothing else
> has happened.  Passing pci=noacpi results in no changes.
> 
>  Passing acpi=off, the machine boots up much further, but some devices
> don't seem to work properly (it may just be I didn't add support to the
> correct devices in the kernel config - my working kernel is the default
> Redhat 7.3 pcmcia-cs kernel image, which is great except the laptop gets
> rather hotter than it did in WinXP...)
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
