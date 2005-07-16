From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Re: Compaq Deskpro EN SFF P500 DSDT Compile Error 1022
Date: Sat, 16 Jul 2005 12:31:44 +0200
Message-ID: <20050716103144.GA19128@tangens.sinus.cz>
References: <11957.137.71.23.54.1121461356.squirrel@www.briarhood.com> <20050716060825.GA4330@tangens.sinus.cz> <1749.192.168.1.3.1121495967.squirrel@www.briarhood.com>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-Message-ID: <20050716103327.GA21846-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
Resent-To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1749.192.168.1.3.1121495967.squirrel-/xmnpVUFZ0+a+sir6i7KpgC/G2K4zDHf@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jared Jones <jared.jones-2fML+01oaiNBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> Hi,
> 
>   MLEN is never defined in my DSDT.  It is only used once in the line of
> the compile error.
> 
> What does this line and section of code do?
> What bogus value can be used to define MLEN?
> Could this have anything to do with WOL?
> 
> >>             Method (_CRS, 0, NotSerialized)
This method returns the list of resources, allocated by the device (in our case
PCI bus IMHO).
> >>             {
> >>                 CreateDWordField (CRES, 0x76, RAMT)
In a formerly created buffer named CRES a field at offset 0x76 called RAMT is
defined.
> >>                 CreateDWordField (CRES, 0x82, PCIT)
The same for field called PCIT at offset 0x82.
> >>                 Add (MLEN, 0x00100000, RAMT)
A sum of "MLEN" and 0x100000 (1Meg) is stored to RAMT.
If an intuitively deduced meaning "Memory Length" is applied and this 1M is
taken as a base of the Extended Memory, RAMT could be understand as RAM TOP
(hey, any former Sinclair hacker there :-) ?) - i.e. the end (upper address)
of RAM.
> >>                 Subtract (0xFFE00000, RAMT, PCIT)
The above result is subtracted from FFE00000 and stored as PCIT.
> >>                 Return (CRES)
All the buffer is returned to the caller of the _CRES method.
> >>             }
It seems to be related to the main resources (address spaces) of the PCI bus.
I'm afraid it has no relation to WOL.
> >>
                 Regards, Pavel Troller


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
