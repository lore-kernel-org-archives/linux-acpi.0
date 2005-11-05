From: Berthold Cogel <cogel-F8dkAKZEjLURtNtAH2Wc8g@public.gmane.org>
Subject: Re: Acer Extensa 3002 WLMi: DSDT fixed but system misses keyboard
 and mouse events
Date: Sat, 05 Nov 2005 23:05:08 +0100
Message-ID: <436D2C94.90207@rrz.uni-koeln.de>
References: <971FCB6690CD0E4898387DBF7552B90E032CF08F@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E032CF08F-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Development <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Moore, Robert wrote:
> smbus-cm.asl    87:         Method (_SBI, 0, NotSerialized)
> Warning  2097 -  Unknown reserved name ^  (_SBI)
> 
> smbus-cm.asl   147:         Method (_SBR, 3, NotSerialized)
> Warning  2097 -  Unknown reserved name ^  (_SBR)
> 
> smbus-cm.asl   237:         Method (_SBW, 5, NotSerialized)
> Warning  2097 -  Unknown reserved name ^  (_SBW)
> 
> smbus-cm.asl   314:         Method (_SBA, 0, NotSerialized)
> Warning  2097 -  Unknown reserved name ^  (_SBA)
> 
> These are valid warnings from the compiler. It certainly can't do
> anything about BIOS writers that simply refuse to follow the ACPI spec
> :-(
> 
> Bob
> 

I cn live wih that, if I can get informations on the battery state. But
what is rally anoying is the prplemwith the missig keyoard and mouse events.

See what i mean? Suppose you try to log in or type the password of your
mailaccount! Last time I had to try 5 times ... X-|

This did not happen with linux-2.6.11.11 and the acpi_sbs-20050120
package from Rich Townsend (acpi-ec-2.6.10.diff, modules i2c-acpi-ec and
acpi-sbs).

And it is interesting, that it does not happen when the battery is
missing. The question is: Is it a problem with the DSDT or with the
kernel code?

Is there any patch available that I can try. Or is there a acpi_sbs
version that compiles with recent kernel versions? It is not very
effective to hit each key twice...

Berthold


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
