From: Krzysztof Oledzki <olel-gcSpNFQc7Gg@public.gmane.org>
Subject: RE: PNP device interrupt type?
Date: Tue, 11 Oct 2005 10:26:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0510111019490.3345@bizon.gios.gov.pl>
References: <59D45D057E9702469E5775CBB56411F196FE43@pdsmsx406>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-743947895-1129019217=:3345"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <59D45D057E9702469E5775CBB56411F196FE43@pdsmsx406>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-743947895-1129019217=:3345
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Tue, 11 Oct 2005, Li, Shaohua wrote:

> Hi,
>>
>> On Mon, 10 Oct 2005, Shaohua Li wrote:
>>
>>> On Sat, 2005-10-01 at 21:44 +0200, Krzysztof Oledzki wrote:
>>>>
>>>> On Thu, 22 Sep 2005, Shaohua Li wrote:
>>>>
>>>>> Hi,
>>>>> Sorry, I wrongly cc-ed the maillist address in previous email.
>>>>>
>>>>> On Wed, 2005-09-21 at 23:16 +0800, Bjorn Helgaas wrote:
>>>>>> On Wednesday 21 September 2005 8:59 am, Krzysztof Oledzki wrote:
>>>>>>> On Wed, 21 Sep 2005, Bjorn Helgaas wrote:
>>>>>>>
>>>>>>>> On Tuesday 20 September 2005 7:32 pm, Li, Shaohua wrote:
>>>>>>>>> Is it possible PNP devices use level trigger interrupt?
>>>>>>>>> IIRC, PNP devices always use edge trigger interrupt under x86,
>>>>>>>>> how about the IA64 case?
>>>>>>>>
>>>>>>>> I'm not aware of any reason why ACPI devices should always
>>>>>>>> be edge triggered on ia64.
>>>>>>>>
>>>>>>>>> If PNP devices always use edge trigger
>>>>>>>>> interrupt,
>>>>>>>>> we might ignore BIOS setting.
>>>>>>>>> We have a bug BIOS assign wrong interrupt info to RTC
>>>>>>>>> http://bugzilla.kernel.org/show_bug.cgi?id=3D5243
>>>>>>>>
>>>>>>>> ACPI can describe any combination of edge/level, high/low,
>>>>>>>> so I think it would be a bad idea to throw away the information
>>>>>>>> the firmware is giving us.
>>>>>>>>
>>>>>>>> We might have to figure out ways to work around firmware
>>>>>>>> defects.  But that seems better to me than just ignoring
>>>>>>>> what the firmware tells us.  That will lead to situations
>>>>>>>> where the hardware and firmware are perfectly legal and
>>>>>>>> correct, but Linux doesn't work (i.e., the hardware uses
>>>>>>>> level triggered interrupts for some device, and Linux ignores
>>>>>>>> that and treats it as edge-triggered).
>>>>>>>
>>>>>>> As far as i understand question, it was not about *ALL* ACPI
> devices
>>>>>> but
>>>>>>> only about PNP ones.
>>>>>>
>>>>>> What is the difference between a "PNP" ACPI device and a "non-PNP"
>>>>>> ACPI device?  It looks to me like PNPACPI will expose all ACPI
>>>>>> devices as PNP devices (with a couple exceptions, like things that
>>>>>> don't have any _CRS method).
>>>>>>
>>>>>>> And IMO the real problem is only RTC on x86 so the
>>>>>>> workaround can only force this type of interrupt.
>>>>>>
>>>>>> Any workaround should be applied as narrowly as possible, to
>>>>>> minimize the chance of breaking a platform that legitimately
>>>>>> chooses to use a level-triggered interrupt.  If there's a
>>>>>> spec or convention that requires RTC to be edge-triggered
>>>>>> on x86, I don't object to reflecting that in the code somehow.
>>>>> Ok, maybe we could do this workaround for x86 and report a warning.
>>>>> Let's see if it breaks anything.
>>>>
>>>> Is there something ready to test? Patches, etc? ;)
>>> Sorry for the long delay. Does this workaround work for you?
>>>
>>> --- a/drivers/pnp/pnpacpi/rsparser.c=092005-10-10 09:25:31.000000000
>> +0800
>>> +++ b/drivers/pnp/pnpacpi/rsparser.c=092005-10-10 09:22:13.000000000
>> +0800
>>> @@ -89,6 +89,12 @@ pnpacpi_parse_allocated_irqresource(stru
>>> =09=09return;
>>>
>>> =09res->irq_resource[i].flags =3D IORESOURCE_IRQ;  // Also clears
> _UNSET
>> flag
>>> +#ifdef CONFIG_X86
>>> +=09if (gsi < 16 && edge_level !=3D ACPI_EDGE_SENSITIVE) {
>>> +=09=09pnp_err("Legacy IRQ %d should be edge trigger\n", gsi);
>>> +=09=09edge_level =3D ACPI_EDGE_SENSITIVE;
>>> +=09}
>>> +#endif
>>> =09irq =3D acpi_register_gsi(gsi, edge_level, active_high_low);
>>> =09if (irq < 0) {
>>> =09=09res->irq_resource[i].flags |=3D IORESOURCE_DISABLED;
>>>
>>
>> Not sure... It seems that this check may be to wide - ACPI IRQ #9 seems
> to
>> be LEVEL on all my mainboards and the same is for ide2 & ohci_hcd on a
>> different mainboard (ServerWorks):
>>
>>   0:        154  404777113    IO-APIC-edge  timer
>>   8:          0       1352    IO-APIC-edge  rtc
>>   9:          0          0   IO-APIC-level  acpi
>>  14:          0         13    IO-APIC-edge  ide0
>>
>>
>>   0: 2107479012          0    IO-APIC-edge  timer
>>   1:      17349          0    IO-APIC-edge  i8042
>>   8:          1          0    IO-APIC-edge  rtc
>>   9:          0          0   IO-APIC-level  acpi
>>  12:      13394          0    IO-APIC-edge  i8042
>>  14:         20          0    IO-APIC-edge  ide0
>>
>>   0: 1751027335          0          0          0  local-APIC-edge
> timer
>>   1:       1299          0          0          0    IO-APIC-edge
> i8042
>>   8:          1          0          0          0    IO-APIC-edge  rtc
>>   9:          0          0          0          0   IO-APIC-level
> acpi,
>> ohci_hcd:usb1
>>  11:         24          0          0          0   IO-APIC-level  ide2
>>  12:        474          0          0          0    IO-APIC-edge
> i8042
>>
>>
>> Shouldn't we better force edge_level only for IRQ #8 and maybe #6, #1,
> #0.
>> AIAFK they cannot be assigned to a PCI device?
> IDE, OHCI, ACPI's IRQs should not be shared by PNP devices. So the IRQs
> should never be passed to the check.
OK. I wasn't aware of this.

> PS. Does the machine work at WinXP? If not, we'd better not apply the
> workaround.

Don't know. It is a dual P4 Xeon Server first powered by Linux 2.4.x and=20
now by 2.6.x. I don't have any possibility to install and test WinXP. I'll=
=20
check your patch and let you know what happens. Thank you.


Best regards,

 =09=09=09Krzysztof Ol=EAdzki
---187430788-743947895-1129019217=:3345--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
