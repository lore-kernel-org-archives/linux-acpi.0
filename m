From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: ibm-acpi-0.1
Date: Tue, 10 Aug 2004 14:37:32 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.08.10.11.37.29.407984@yahoo.com>
References: <20040810080826.GD28939@aero.ensim.com> <pan.2004.08.10.10.18.05.651578@yahoo.com>
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

Hi Boris,

Some more feedback from my T41.
First, the environment:
Fedora Core 2, Kernel 2.6.8-rc2 vanilla with acpica-20040715 patch.
This is the first version of kernel and acpi that does s3 suspend to ram
reliably on my T41. If you want my dsdt, just tell me and I will send you
privately, because PAN is not able to attach anything to news posts.
(maybe is not even possible).

now:
cd /proc/acpi/ibm
cat fan 
current:        -1 -1 -1
preset1:        3000 3720 4410
preset2:        3120 3520 3800
preset3:        3120 3520 3800
commands:       <low> <medium> <high>, preset1, preset2, preset3

and i found this in dmesg:
ibm_acpi: acpi_invokef(FAN9, d, ...) failed
ibm_acpi: acpi_invokef(FANB, d, ...) failed
ibm_acpi: acpi_invokef(FAND, d, ...) failed
ibm_acpi: acpi_invokef(FAN9, d, ...) failed
ibm_acpi: acpi_invokef(FANB, d, ...) failed
ibm_acpi: acpi_invokef(FAND, d, ...) failed

if I echo preset1 > fan, I got this in dmesg:

ibm_acpi: acpi_invokef(FANS, vddd, ...) failed
ibm_acpi: FANS(3000, 3720, 4410) failed

As for docking, I don't have the dock right now, but I'll test it some
other time.

The hotkey is the only thing working right now, but not completely.
Like I said before, the Fn+F5 should enable/disable the wlan AND the
bluetooth, but with this acpi driver, the bluetooth is not enabled any
more.
The bluetooth is an internal USB device, which gets connected and
disconnected from the USB bus when pressing Fn+F5:

usb 3-1: new full speed USB device using address 4
Bluetooth: HCI USB driver ver 2.6
usbcore: registered new driver hci_usb



> 
> On a T41 it inserts in the kernel only if I replace _SB.GDCK with
> _SB.PCI0.PCI1.DOCK.
> If I don't, I get the following message:
> insmod ./ibm_acpi.ko 
> insmod: error inserting './ibm_acpi.ko': -1 No such device
> 
> and in dmesg I found:
> ibm_acpi: acpi_get_handle(\_SB.GDCK) failed
> 
> At a fist glance, hot-keys work, but the Fn-F5 does not enable bluetooth
> anymore.
> I will get back with more feedback.
> 
> Thanks,
> Paul
> 
> On Tue, 10 Aug 2004 01:08:26 -0700, Borislav Deianov wrote:
> 
>> Hi,
>> 
>> This is the first public release of my ACPI driver for IBM ThinkPad
>> laptops. The features currently supported are:
>> 
>> - hot keys (Fn key combinations)
>> - docking and undocking
>> - some basic fan speed control
>> 
>> Note that I've only tested on a ThinkPad X40 with the X4 UltraBase. I
>> suspect many other recent models are sufficiently similar to work with
>> this driver but I have no such reports yet.
>> 
>> I'll release this on the linux-thinkpad list as well, but I thought
>> I'd get some comments here first. This is my first foray into the ACPI
>> code, so do let me know if I'm doing something horribly wrong. :-)
>> 
>> (Sorry, no web page yet. One thing at a time.)
>> 
>> Thanks,
>> Boris
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
