From: Takanori Watanabe <takawata-yzSWc4HAx5xL9jVzuh4AOg@public.gmane.org>
Subject: Re: PNPACPI breaks my asus k6-2 parallel port
Date: Wed, 08 Dec 2004 11:17:18 +0900
Message-ID: <200412080217.LAA15383@axe-inc.co.jp>
References: <16A54BF5D6E14E4D916CE26C9AD30575BB93FB@pdsmsx402.ccr.corp.intel.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: Your message of "Wed, 08 Dec 2004 09:08:04 +0800."
             <16A54BF5D6E14E4D916CE26C9AD30575BB93FB-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In message <16A54BF5D6E14E4D916CE26C9AD30575BB93FB-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org
>, "Li, Shaohua" wrote:
>>>>Turning on PNPACPI changes this in my dmesg:
>>>>
>>>>-parport0: PC-style at 0x378 [PCSPP(,...)]
>>>>-lp0: using parport0 (polling).
>>>>+ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
>>>>+ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
>>>>+parport: PnPBIOS parport detected.
>>>>+parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
>>>>+lp0: using parport0 (interrupt-driven).
>>>>+pnp: Device 00:08 activated.
>>>>+parport: PnPBIOS parport detected.
>>>>+parport1: PC-style at 0x278, irq 5 [PCSPP(,...)]
>>>>+lp1: using parport1 (interrupt-driven).
>>>>
>>>>As a result, my parallel port stops working.  Any more information I
>can
>>>>provide?
>>>
>>>
>>> I don't know little about Linux specific, but generally,
>>> a Printer port device will appear several times as ACPI devices.
>>>
>>> If you forget to check device status (_STA),
>>> confliction will occur as you got.
>>
>>You are right Watanabe-san.  It appears linux just parses all resource
>>sets in _PRS as separate devices instead of parsing the DPFs and
>>treating them as separate sets for a single device.
>Hi Nate,
>Could you please clarify it? Linux did check _STA, and only assigned
>dependent resources (that is one set of resources) from _PRS to a
>device.
>In Wilcox's case, LPT (PNP0400) has resources of 0x378, irq 7. PNPACPI
>can only assign 0x278, irq 5 to ECP (PNP0401) the resources are listed
>in ECP's _PRS. ECP possibly isn't a parport (Dunno why it said a parport
>detected), it can use DMA per the _PRS.

In many case, single Parallel port is appeared as multiple device,
like ECP port, simple parport,etc ...  in ACPI name space 
with only one of them activated. And if you try to wake up all resources,
only the last activated one will make available, I think.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
