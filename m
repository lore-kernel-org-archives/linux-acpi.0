From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: generic hotkey driver
Date: Wed, 1 Sep 2004 18:32:53 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F84055D6C10@pdsmsx403>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

   I'm thinking if we need a generic hotkey driver that is configurable
to any specific machine.=20
There already have two specific hotkey driver: asus_acpi.c and
toshiba_acpi.c. And there=20
are two upcoming driver : ibm_acpi.c and panasonic_acpi.c.  I don't know
how many
hotkey driver will be invented in the future. But I know it will mess up
the code structure.
  So, I'm considering a generic hotkey driver that will export
configurable interface to=20
accommodate the difference.

 a. Configure interface:
	1. register mapping of event number to internal hotkey number.
	2. register expected acpi_handle which is needed to install
notify handler, which will generate event for acpid.
	3. register the AML methods that should be executed , with
respect to  the hotkey get pressed.
 b. Expose interface:
	1. Expose the event action interface through /proc/acpi/action,
the interface will receive argument which
		will be passed into AML method, as well as AML method
should be executed.
 c. Use interface:
	1. When user space acpid get a event, it can call related AML
methods related to this hotkey.

Thanks,
Luming
=09

 =20


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
