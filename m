From: =?ISO-8859-15?Q?Jean-Fran=E7ois_Rameau?= <jframeau-JRzDBA0BuDZiLUuM0BA3LQ@public.gmane.org>
Subject: Help wanted: ACPI and serial ports
Date: Fri, 18 Feb 2005 10:45:13 +0100
Message-ID: <4215B929.5010004@cyberdeck.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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


Hi everybody,

I'm facing a weird problem with a motheboard from=20
http://www.flytech.com/product-18.html / B79 model.

I'm using a 2.4.22 kernel.

The PC must power off once a day and then restarts some hours after=20
using the RTC Power On bios feature.
Problem: if RTC Power On is up, PC never stops (it reboots immediately=20
after the power off call). If I turn off RTC power on feature, the PC=20
stops and power is off.
Looking at dmesg, I see ACPI: Interpreter disabled.

So I tried to set acpi=3Dforce on kernel's command line: curiously, the=20
kernel loads a asus_acpi module.
Problem: if asus_acpi is loaded, and RTC Power On is up, the PC never=20
stops. If a remove the module, that's OK: the PC stops and power is off.

Seeems to be OK, no ?

The PC uses 4 serial ports: if I set acpi=3Dforce, I can't use serial por=
t=20
3 and 4 anymore, even using setserial call.

Is there something I can do to track the problem ?

Regards,

jean-fran=E7ois


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
