From: Andrew Ross <aross-ncau/BB9MAPvnOemgxGiVw@public.gmane.org>
Subject: Re: Intel 855PM Thermal Zone support
Date: Mon, 30 Aug 2004 10:03:25 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1093824204.8551.5.camel@localhost>
References: <e294b46e04082914245adf173e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <e294b46e04082914245adf173e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Mon, 2004-08-30 at 07:24, Bradley Chapman wrote:
> I'm having trouble with the thermal zone drivers in the 20040715
> 2.6.8.1 ACPI driverset on my Sager NP3760 laptop, which has an Intel
> 855PM chipset. The thermal zone drivers are unable to lcate any
> thermalzones, and subsequently I can't monitor the CPU termperature.
> The CPU itself is an Intel Pentium M Dothan, 1.5GHz. dmesg and cpuinfo
> outputs appear below.
> 
> Does anyone know where I can learn about the current state of support
> for the 855PM chipset?

Using vanilla kernels 2.6.7, 2.6.8 and 2.6.8.1, thermal zone and CPU
temperature reporting works on my custom built Astone Z7 (rebranded Asus
M6N) which has an Intel Pentium M Dothan 735 (1.7Ghz) and the 855PM
chipset. 

Perhaps you have DSDT problems? Have you read
http://acpi.sourceforge.net/dsdt/index.php ?

Cheers

Andrew



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
