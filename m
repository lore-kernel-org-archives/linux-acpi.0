From: Bradley Chapman <kakadu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Intel 855PM Thermal Zone support
Date: Mon, 30 Aug 2004 18:10:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <e294b46e04083010102fb6d4a0@mail.gmail.com>
Reply-To: Bradley Chapman <kakadu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Andrew,

(I forgot to say that I'm not a member of acpi-devel; please Cc all
replies to me, thanks)

> On Mon, 2004-08-30 at 07:24, Bradley Chapman wrote:
> > I"m having trouble with the thermal zone drivers in the 20040715
> > 2.6.8.1 ACPI driverset on my Sager NP3760 laptop, which has an Intel
> > 855PM chipset. The thermal zone drivers are unable to lcate any
> > thermalzones, and subsequently I can"t monitor the CPU termperature.
> > The CPU itself is an Intel Pentium M Dothan, 1.5GHz. dmesg and cpuinfo
> > outputs appear below.
> > 
> > Does anyone know where I can learn about the current state of support
> > for the 855PM chipset?
>
> Using vanilla kernels 2.6.7, 2.6.8 and 2.6.8.1, thermal zone and CPU
> temperature reporting works on my custom built Astone Z7 (rebranded Asus
> M6N) which has an Intel Pentium M Dothan 735 (1.7Ghz) and the 855PM
> chipset. 
> 
> Perhaps you have DSDT problems? Have you read
> http://acpi.sourceforge.net/dsdt/index.php ?

Thanks for the link - unfortunately, Sager is not listed in the
manufacturer's table. Who builds the NP3760 laptops anyway? And where
would I find that information out?

>
> Cheers
>
> Andrew

Brad


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
