From: Per-Anders Glans <PAGlans-/3juihCSby0@public.gmane.org>
Subject: Re: Laptop turn off nuisance.
Date: Wed, 1 Dec 2004 21:03:22 -0800
Message-ID: <20041202050322.GC3523@chipmunk>
References: <20041201164548.19685ffb@dxpl.pdx.osdl.net>
Reply-To: glans-Js2reWni+0b2fBVCVOL8/A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041201164548.19685ffb-39adWEZt0cRD9Q4cBsb+HV6hYfS7NtTn@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I see the same behavior. This started after upgrading the kernel from 
2.6.5 to 2.6.9 (sorry, never tried any of the intermediate kernels) on
a Fujitsu E-series 7010. I am running Debian testing/unstable.
2.6.5 shut down as expected, but with 2.6.9 I get the fan (and wireless) 
turn on briefly when the lid is closed and automatic boot when the lid
is opened.

On Wed, Dec 01, 2004 at 04:45:48PM -0800, Stephen Hemminger wrote:
> When I shutdown Linux on my laptop (Fujitsu S6000) [2004] it acts as
> if it is turned off, but when I close the lid the fan turns on, then turns off.
> When lid is opened, the machine boots. It seems as if it doesn't really
> turn off?
> 
> Of course, with Windows it doesn't do that.
> And if I shut off by using the power button, it goes completely off.
> 
> It is a nuisance, and might reduce the battery life?
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now. 
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
