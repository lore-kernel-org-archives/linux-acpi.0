From: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Radeon PM Support
Date: Wed, 11 Aug 2004 13:36:36 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <88056F38E9E48644A0F562A38C64FB600296D17B@scsmsx403.amr.corp.intel.com>
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
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ole.rohne-vJEk5272eHo@public.gmane.org, Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, anib-La3J9u0raUk@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=20

>-----Original Message-----
>From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org]=20
>Sent: Wednesday, August 11, 2004 12:08 PM
>To: Pallipadi, Venkatesh
>Cc: ole.rohne-vJEk5272eHo@public.gmane.org; Nathan Bryant;=20
>acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; anib-La3J9u0raUk@public.gmane.org
>Subject: Re: [ACPI] Radeon PM Support
>
>Hi!
>
>> > I"ve been hesitant to propose a generic VGAPOST, but it=20
>could be good
>> > to have a way of resuming without using a driver. Would it=20
>be cleaner
>> > to put the call in pci_default_resume?
>>=20
>> Yes. If this patch works for tohers, then we can move it into
>> pci_default_resume during the cleanup.
>
>
>I'd rather not do that. Some cards are already posted after
>S3, some even preserve state over S3.=20
> It is okay to do VGAPOST
>for radeon and any card that needs it, but I'd rather not do=20
>it generically.

If this is the right place to do post for most of the devices,
then probably we can do away with initial soon-after-wakeup-post.
Right?
But, for the devices that preserve state, yes we need to avoid=20
doing this. I can see one more device-blacklist/whitelist coming=20
here :).

Thanks,
Venki


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
