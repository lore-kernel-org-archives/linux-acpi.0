From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: _STA workaround regression
Date: Mon, 16 Aug 2004 17:37:46 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F038F8996@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>-----Original Message-----
>From: Bjorn Helgaas [mailto:bjorn.helgaas-VXdhtT5mjnY@public.gmane.org]
>Sent: Friday, August 13, 2004 11:22 PM
>To: Li, Shaohua
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Brown, Len
>Subject: Re: _STA workaround regression
>
>On Thursday 12 August 2004 7:02 pm, Li, Shaohua wrote:
>> I got below boot message
>> >ACPI: Device [CSFF] status [00000008]: functional but not present;
>> setting
>> >present
>> >ACPI: PCI Root Bridge [CSFF] (00:ff)
>> in tiger4, and then lspci -vv display many garbage info (many PCI
>> devices' bus number is 0xFF).
>> Looks like the _STA workaround for big sur and Bull system breaks
>> tiger4. Any idea?
>
>Here's a pointer to the start of this whole thing:
>	https://sourceforge.net/mailarchive/message.php?msg_id=3D6923358
>
>On my tiger4, lspci shows this, which I assume is what you are
referring
>to:
>
>	ff:18.0 Host bridge: Intel Corp.: Unknown device 0500 (rev 20)
>	ff:18.1 Host bridge: Intel Corp.: Unknown device 0501 (rev 20)
>	ff:18.2 Host bridge: Intel Corp.: Unknown device 0502 (rev 20)
>	ff:18.3 Host bridge: Intel Corp.: Unknown device 0503 (rev 20)
>	ff:1c.0 Host bridge: Intel Corp.: Unknown device 0510 (rev 22)
>	ff:1c.1 Host bridge: Intel Corp.: Unknown device 0511 (rev 22)
>	ff:1c.2 Host bridge: Intel Corp.: Unknown device 0512 (rev 22)
>	ff:1c.3 Host bridge: Intel Corp.: Unknown device 0513 (rev 22)
>	ff:1c.4 Host bridge: Intel Corp.: Unknown device 0514 (rev 22)
>	ff:1c.5 Host bridge: Intel Corp.: Unknown device 0515 (rev 22)
>	ff:1c.6 Host bridge: Intel Corp.: Unknown device 0516 (rev 22)
Yep. This is what I saw. I'm strange there are so many unknown devices
with bus 0xff, which confused me. I went through the SIOH datasheet, and
the devices are really existent. Sorry for the noise.

Thanks,
Shaohua

>
>I'm not sure what makes you think this is a regression, though.  Does
>this actually break something on your system?  My system works just
>fine.  It's true that it would be nice to teach lspci what the devices
>are, so it could say something more intelligent than "Unknown device",
>but as far as I know, they are real things that somebody could write
>drivers for someday.
>
>But I don't work for Intel, and I don't know anything about the tiger4
>internals.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
