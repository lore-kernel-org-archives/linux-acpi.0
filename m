From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC, PATCH] sysdev suspend/resume order?
Date: Tue, 17 Aug 2004 10:05:36 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F039564CA@pdsmsx401.ccr.corp.intel.com>
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
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pallipadi, Venkatesh wrote:
>To: Li, Shaohua; 'Patrick Mochel'; Pavel Machek
>Cc: 'acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'; Brown, Len
>Subject: [RFC, PATCH] sysdev suspend/resume order?
>
>One solution to this problem:
>Call the sysdev_registers during the actual device
>initialization. Say, i8259 sysdev_register should be
>called when i8259 device is getting registered and
>not with a device_initcall 'sometime' later.
>
>With this, we will be able to save the original
>device initialization order (bootup order), and call
>the resume methods in the same order.
>
>Attached are the couple of sample patches that does
>this in particular files.
>
>Questions:
>Is this solution proper?
>Is there any better solution to this problem? Say
>introducing some sort of levels in device_initcall.
>If the above soultion is proper, is it
>practical/feasible to audit all usages of
>sysdev_register()
I think we should check 'sysdev_class_register', when sysdev_register is
called doesn't affect sysdev's order. But maybe my previous email
misleads you.

>and try to move it to the
>device initialization function?
I have the same concern as Nathan: does this cause some data corrupt?
sysdev_class_register must be called after device driver core is
initialized (after 'driver_init', which is invoked at 'do_basic_setup').
Some sysdev are initialized before that.

Thanks,
Shaohua


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
