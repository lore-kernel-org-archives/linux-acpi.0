From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: ibm-acpi-0.1
Date: Wed, 11 Aug 2004 03:48:25 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.08.11.00.48.24.245774@yahoo.com>
References: <20040810080826.GD28939@aero.ensim.com> <pan.2004.08.10.10.18.05.651578@yahoo.com> <pan.2004.08.10.11.37.29.407984@yahoo.com> <20040810231129.GN28939@aero.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
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

On Tue, 10 Aug 2004 16:11:29 -0700, Borislav Deianov wrote:


> If it's not too much trouble, I'd appreciate it. In the mean time, I'm
> looking at a hacked one off http://acpi.sf.net, so it's not very
> important.
> 

I've sent my dsdt to your email at sourceforge.

>> The hotkey is the only thing working right now, but not completely.
>> Like I said before, the Fn+F5 should enable/disable the wlan AND the
>> bluetooth, but with this acpi driver, the bluetooth is not enabled
>> any more.
> 
> That was to be expected. The code for the hot keys usually does
> something like this:
> 
> if hot key events enabled
> 	generate event
> else
> 	invoke default hot key behaviour
> 
> In this case, the default behaviour is toggling bluetooth on and
> off. This should be easy to fix, though - a /proc/acpi/ibm/bluetooth
> control would allow you to toggle the state from the ACPI handler for
> Fn-F5.

Yeap, that would do. I much prefer this option that hard-coding it in the
notify handler. 

>> > On a T41 it inserts in the kernel only if I replace _SB.GDCK with
>> > _SB.PCI0.PCI1.DOCK.
> 
> I'll make it look for that. As Shaohua noted, though, I'm not yet
> scanning the PCI bus on the dock.
Yes, I know that. I managed to test a T50p in a dock, but it doesn't work
as expected. So there may be some IBM magic added in here.

>> Do you have the same problems ?
> 
> Yes, although I hadn't noticed DMA was off. I found all these posts
> saying that both IDE and ACPI hot plugging are basically not supported
> yet, so I was happy to get docking and undocking with the CD drive
> working at all...

Well, they are not supported, but somewhat working half way.
Anyway, if you put a secondary hard disk in the bay as I do, then you WILL
want DMA for sure.

Thanks,
Paul



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
