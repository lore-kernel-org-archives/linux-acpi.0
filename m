From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: generic hotkey driver
Date: Tue, 7 Sep 2004 16:14:17 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F84056B57EE@pdsmsx403>
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
To: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>
>I think hotkey drivers are  so differ that it is enough to decide
>event format. ie) 'ibm KEY 00001 00001' or 'hotkey/pcc HKEY=20
>000003 000001'
>

We don't need to care about the format of event. Since it is
configurable,
we just need to understand the internal meaning. So maybe we
need to define the internal event number, which stands for a
special purpose. such as:

	001	turn off display
	002	inc brightness
	003	dec brightness
	004	s3
	......

>Lcd brightness control is defined in ACPI spec apendix.
>I'm starting implement that.
>

Be careful, there has a video extension driver=20
filed at http://bugzilla.kernel.org/show_bug.cgi?id=3D1944

>I want to make generic lcd driver that is configurable for=20
>each extra drivers.
>
>Bluetooth, dock, and other device settings are not common.
>So these may be implement in each extra drivers. eg)=20
>ibm_acpi.c has these functions.
>

But , it is still meaningful to standardize the event format.

Thanks,
Luming


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
