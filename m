From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: [RFC, PATCH] sysdev suspend/resume order?
Date: Mon, 16 Aug 2004 15:26:43 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41210A73.7000101@optonline.net>
References: <88056F38E9E48644A0F562A38C64FB60029C689B@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60029C689B-exJ48ZlmiLpQxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Pallipadi, Venkatesh wrote:
>  
> Problem:
> Most of the sysdev_register calls in various devices
> are being done using device_initcalls. This method of 
> initialization has a side-effect, as we loose the 
> ordering requirements for various resume calls. 
> Order in which _resume() functions gets called during 
> a resume, just depends on the order device_initcalls 
> were called on these devices.
> 
> Shaohua's mail below describes one issue that is a 
> result of this problem, where in pci link device get 
> initialized before PIC. There can be more issues 
> like this.

Actually, the PCI links are initialized from a subsys_initcall, which is 
not to be confused with a device_initcall, and anyway the PCI links 
don't have their own suspend/resume callbacks unless you're using a 
specific patch that I posted.

Maybe the problem you guys are thinking of has to do with PIC/APIC and 
PIT resume order?

> 
> One solution to this problem:
> Call the sysdev_registers during the actual device 
> initialization. Say, i8259 sysdev_register should be 
> called when i8259 device is getting registered and 
> not with a device_initcall 'sometime' later.
> 
> With this, we will be able to save the original 
> device initialization order (bootup order), and call 
> the resume methods in the same order.
> 
> Attached are the couple of sample patches that does 
> this in particular files.
> 
> Questions:
> Is this solution proper?

I think that's dubious. Haven't looked at your patch yet, but... if you 
call sysdev_register from with an ACPI subsys_initcall you will run into 
some sort of data structure corruption and your kernel will fail to boot.

Also, some of the devices you refer to are initialized from 
subsys_initcall's anyway, and I assume that the order of those is also 
somewhat undefined.

> Is there any better solution to this problem? Say 
> introducing some sort of levels in device_initcall.
> If the above soultion is proper, is it 
> practical/feasible to audit all usages of 
> sysdev_register() and try to move it to the 
> device initialization function?
> 
> Thanks,
> Venki
> 
> 
>>-----Original Message-----
>>From: Pallipadi, Venkatesh 
>>Sent: Friday, August 13, 2004 11:58 AM
>>To: Li, Shaohua; 'Patrick Mochel'
>>Cc: 'acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'; Brown, Len
>>Subject: RE: sysdev suspend/resume order?
>>
>>
>>
>>I think, there should be a relation between the order
>>in which actual device initialization happens during 
>>the boot time and the order in which device initcalls 
>>are called (at boot time).
>>
>>In this example, actual PIC initialization happens 
>>before pci_link device initialization. So, device 
>>initcall should have a similar ordering. That will 
>>take care of this after S3 ordering in a natural manner.
>>
>>Thanks,
>>Venki 
>>
>>
>>>-----Original Message-----
>>>From: Li, Shaohua 
>>>Sent: Friday, August 13, 2004 12:37 AM
>>>To: Patrick Mochel
>>>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Brown, Len; Pallipadi, Venkatesh
>>>Subject: sysdev suspend/resume order?
>>>
>>>Patrick,
>>>My sound card dies after S3 sometimes. Basically, if it dies 
>>>depends on the order of sysdev's resume. If IRQ router resume 
>>>before PIC (I use a tricky method to change order. It's 
>>>changing the initcall level of the sysfs initialization for 
>>>the device), the sound card die. Otherwise, it works. Is it 
>>>possible that we add some levels for sysdev? I'd like some 
>>>sysdevs resume before other sysdevs. Does this make sense? 
>>>
>>>Thanks,
>>>Shaohua
>>>
>>



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
