From: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Subject: Re: [RFC] ACPI power-off on P4 HT
Date: Thu, 26 Feb 2004 14:29:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077802199.1503.5.camel@chevrolet.hybel>
References: <1076145024.8687.32.camel@dhcppc4>
	 <20040208082059.GD29363@alpha.home.local>
	 <20040208090854.GE29363@alpha.home.local>
	 <20040214081726.GH29363@alpha.home.local>
	 <1076824106.25344.78.camel@dhcppc4>
	 <20040225070019.GA30971@alpha.home.local>
	 <1077695701.5911.130.camel@dhcppc4> <20040226075609.GA745@uberboxen>
	 <20040226105744.GA3406@alpha.home.local>
	 <1077798440.955.1.camel@chevrolet.hybel>
	 <20040226130724.GA3704@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040226130724.GA3704-HkMpAodKYdnXX8ko2wsARw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

tor, 26.02.2004 kl. 14.07 skrev Willy Tarreau:
> On Thu, Feb 26, 2004 at 01:28:49PM +0100, Stian Jordet wrote:
> > Hi Willy,
> > 
> > Do you have a similar patch for 2.6?
> 
> No, but since Marcelo recently told me that acpi_power_off() was the same in
> 2.4 and 2.6, I think it should apply without much difficulties. A dirty gpm
> cut-n-paste in vi should be enough ;-)

Well, I cut-n-paste it into drivers/acpi/sleep/poweroff.c (which must
have been the place it fits in 2.6). Get this compile failures:

drivers/acpi/sleep/poweroff.c: In function `acpi_power_off':
drivers/acpi/sleep/poweroff.c:30: warning: implicit declaration of
function `apicid_to_phys_cpu_present'
drivers/acpi/sleep/poweroff.c:30: error: invalid operands to binary &
drivers/acpi/sleep/poweroff.c:69: warning: implicit declaration of
function `disable_IO_APIC'
make[3]: *** [drivers/acpi/sleep/poweroff.o] Error 1
make[2]: *** [drivers/acpi/sleep] Error 2
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2

But I'm sure a patch like yours for 2.6 would have fixed my, since using
a non-smp kernel works everytime :) Anyway, thanks for your efforts,
hope someone will get this fixed soon :)

Best regards,
Stian



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
