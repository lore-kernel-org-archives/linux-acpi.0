From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Shutting down PCI devices on suspend
Date: Sat, 11 Dec 2004 15:20:38 -0800
Message-ID: <41BB80C6.1020404@root.org>
References: <1102779460.5984.17.camel@tyrosine>  <41BB4F70.9060606@root.org> <1102804893.5984.23.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1102804893.5984.23.camel@tyrosine>
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
> On Sat, 2004-12-11 at 11:50 -0800, Nate Lawson wrote:
> 
>>In FreeBSD, we do this at the bus layer.  So the ACPI and PCI bus code 
>>is responsible for powering down/up children.  We currently do it:
>>
>>1. When no driver is attached and on reprobe
>>2. When suspending/resuming, based on evaluating _SxD
>>
>>See this commit for details:
>>http://docs.freebsd.org/cgi/getmsg.cgi?fetch=1604853+0+archive/2004/cvs-all/20041205.cvs-all
> 
> 
> Does _SxD represent the "desired" mode for the hardware, or merely the
> highest state it can be left in? A mail from Len earlier this year
> suggested that if S3D returned 0x2, that meant that either D3 or D2 were
> acceptable.

_SxD is the highest state supported by the device for a given sleep 
state, yes.  We put devices in D3 unless _SxD specifies something 
higher.  The reason to do this is some devices can't wake the system if 
they are in D3.  ACPI 3.0 has ways to indicate a desired power state 
(not just maximum).  I don't have any evidence but fear some devices 
won't work after resuming if set to D3 and they indicate this with an 
_SxD so we always use the value in _SxD if present.

> Is there any reason why adding something like
> 
> if (state==3) {
> 	pci_set_power_state(dev,ACPI_STATE_D3COLD)
> }
> 
> to pci_device_suspend in the non-driver path and reenabling it in
> pci_default_resume would result in things breaking?
> 
> (Possibly with sanity checks as to whether it's a bridge or not)

Not that I can think of.  You probably want state == S3 || S4 since it's 
fine to power down devices for S4.  You'll probably find drivers that 
don't properly resume their device.  You have to make sure you power 
devices down after suspending them and power them up before resuming them.

-- 
Nate


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
