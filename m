From: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: PCI power state mapping
Date: Tue, 27 Jul 2004 20:18:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41069C59.5020603@drzeus.cx>
References: <B44D37711ED29844BEA67908EAF36F036BCB8C@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F036BCB8C-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
I'm still learning the structure of the linux kernel so I wasn't aware 
that there was a device layer above the drivers. I figured that devices 
that weren't claimed by any driver were just ignored :)

Anyhow, I did some hacks into pci_device_suspend() getting it to suspend 
devices without a driver. Combined with my escalation patch in 
pci_set_power_state() all devices on the machine now enters D2 or D3 
depending on device capabilities. My laptop still cannot enter the 
suspend state so there is still something missing... Are there any more 
areas of power management in linux that aren't quite up to spec.?

When it comes to ACPI to PCI mapping, one immediately wonders how 
Windows handles this. I only see one option and that is comparing 
allocated resources. But that assumes that the driver assumes resources 
identically to how the guy writing the DSDT. Does anyone here have 
insight into how Windows does this?

In my attempts to fiddle with PCI power states I also tried using 
/sys/devices/pci*/*/power/state but nothing happens when writing values 
to this file. Where in the kernel is this file attached?

Rgds
Pierre Ossman

Li, Shaohua wrote:

>Hi,
>I agree with what you said. Currently most drivers will directly send
>'PM_*" state to 'pci_set_power_state', which cause many drivers can't
>suspend. I found my two laptops, Toshiba Satellite M20 and Thinkpad T40,
>EHCI can't suspend and the reason is exactly they only support D3 state
>but 'PM_SUSPEND_MEM' equals to 2.
>
>I suggest that 'pci_set_power_state' should be called in
>'pci_device_suspend', so even a device has no driver, it gets a chance
>to sleep. I have a sample patch for it actually, but it still uses wrong
>D-state number ('PM_*').
> 
>For determining D-state of a device in sleep state, bind guess is not a
>good idea. Some devices only support D3 or D2 for S3. ACPI defined
>methods _SxD, which return maximum device's D-state when entering Sx.
>But it's not easy to find a clean way to relate ACPI devices with PCI
>devices.
>
>Thanks,
>Shaohua
>
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
