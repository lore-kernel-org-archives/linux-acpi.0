From: Erik Tews <erik-KVSZC2aA8+zw/snApU8qRLNAH6kLmebB@public.gmane.org>
Subject: Re: Re: Re: ibm-acpi-0.1
Date: Wed, 11 Aug 2004 14:16:06 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092226566.3156.3.camel@localhost.localdomain>
References: <20040810080826.GD28939@aero.ensim.com>
	 <pan.2004.08.11.01.01.25.610270@yahoo.com>
	 <1092188650.3156.0.camel@localhost.localdomain>
	 <pan.2004.08.11.09.38.47.140647@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <pan.2004.08.11.09.38.47.140647-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
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

Am Mi, den 11.08.2004 schrieb Paul Ionescu um 11:38:
> Even now, without proper ACPI support, you don't have to reboot your
> thinkpad to do that.
> If you are using an ACPI enabled kernel, then you can just 
> "idectl 1 off"
> pull out your cdrom
> insert your battery
> use the battery
> eject the battery
> insert the cdrom
> "idectl 1 on" or "idectl 1 rescan"
> use the cdrom

Cool, this works.

> however the DMA on the cdrom will not work because of this bug:
>  http://bugme.osdl.org/show_bug.cgi?id=2261

Yes, same thing here, running 2.6.8-rc3 with acpi-patch.



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
