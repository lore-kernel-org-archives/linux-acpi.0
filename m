From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: smartbattery support
Date: Tue, 12 Oct 2004 09:03:32 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305754B4711@pdsmsx402.ccr.corp.intel.com>
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
To: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In this case, the EC based SMBus host isn't EC. Actually it's a child of
EC. You must use its HID (ACPI0001) to find it. I suggest you write a
new driver for the SMBus host.

Thanks,
Shaohua

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Pedro Venda
>Sent: Tuesday, October 12, 2004 5:26 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] smartbattery support
>
>Pedro Venda wrote:
>>>> Device (SMBC)
>>>>                    {
>>>>                        Name (_HID, "ACPI0001")
>>>>                        Name (_EC, 0x1820)
>>>>                        Device (SBS0)
>>>>                        {
>>>>                            Name (_HID, "ACPI0002")
>>>>                            Name (_SBS, 0x02)
>>>>                        }
>>>>                    }
>
>hi everyone,
>
>i can't get an acpi_handle for the ec host.
>
>i am writing code in bruno ducrot's i2c-ec-smbus driver and i'm trying
>to detect the smbus address from the ACPI's ASL code above.
>
>i'm trying to acpi_get_handle(NULL,"_EC",ec->handle) but it fails
>because of the parent=3DNULL (i think).
>
>i suspect i need to use the ec driver's device handler in the parent
>paramenter of acpi_get_handle(). is that correct?
>
>or am i doing everything wrong?
>
>[]
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: IT Product Guide on
ITManagersJournal
>Use IT products in your business? Tell us what you think of them. Give
us
>Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out
more
>http://productguide.itmanagersjournal.com/guidepromo.tmpl
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
