From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Shutting down PCI devices on suspend
Date: Sat, 11 Dec 2004 11:50:08 -0800
Message-ID: <41BB4F70.9060606@root.org>
References: <1102779460.5984.17.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1102779460.5984.17.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> The default PCI suspend/resume calls (used if the driver doesn't
> implement them itself) don't alter the device power state. This seems to
> cause problems on some Thinkpads - going into S3 doesn't seem to result
> in the on-board Radeon being put into D3, and as a result the battery is
> drained at a higher rate than it should be. Who should be responsible
> for making sure that devices are properly put to sleep:
> 
> 1) The drivers (not immensely helpful in the case where we don't
> necessarily have drivers registered for every device)
> 2) The kernel
> 3) The hardware itself?
> 
> I seem to remember someone mentioning something about Linux not checking
> for hints from the hardware as to what state devices should be put in,
> but I know little about this.

In FreeBSD, we do this at the bus layer.  So the ACPI and PCI bus code 
is responsible for powering down/up children.  We currently do it:

1. When no driver is attached and on reprobe
2. When suspending/resuming, based on evaluating _SxD

See this commit for details:
http://docs.freebsd.org/cgi/getmsg.cgi?fetch=1604853+0+archive/2004/cvs-all/20041205.cvs-all

Notes: we had problems switching serial ports into D3.  It seems that an 
interrupt storm happens for this type of device.  This is likely a 
deficiency in our serial driver.  We only switch type 0 devices 
(non-bridge) since our bridge resume code needs improvement.

Hope this helps.

-- 
Nate


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
