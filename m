From: Felix Domke <tmbinc-J6wMscjeMKTk1uMJSBkQmQ@public.gmane.org>
Subject: Who else is writing to the EC? (Sony Vaio S3XP / PCG-6E1M)
Date: Wed, 30 Mar 2005 16:16:30 +0200
Message-ID: <424AB4BE.1010009@elitedvb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

I'm a bit annoyed of the way the fan behaves in my Sony Vaio S3XP /
PCG-6E1M. Basically it's totally disabled until ~55=B0C, then switches on
and gets faster with higher temperature. However the system tends to
oscillate with a ~1min period, which is very annoying. I would rather
like the fan to be active at a slow speed all the time.

I noticed that there's no FAN-Resource in the DSDT.
There's no active cooling entry in the thermal zone, only a passive one
at 50=B0C. A quick overview over the thermal zone in the DSDT didn't show
any stuff where the fan is controlled.

Now there's a FAN0 entry in the embedded controller, at offset 0x93. I
made a small hacking by making a kernel module which directly writes to
the EC, and it works, i can set the fan speed between 0 and 0xFF.

However, about one second or so after i write the value, the fan speed
gets reset to the original value. reading from the EC show that the
value there gets reset, too.

I could not find any references inside the DSDT to the FAN0 resource in
the EC, i searched for both 0x93 (the offset) and "FAN0".

Even when i remove the "thermal" module, the fan behaves exactly like
before.

Who controls the fan when there's no thermal module active? Is there any
way i can override the fan control on this machine?

the dsdt: http://tmb.elitedvb.net/dsdt
and the disassembled version: http://tmb.elitedvb.net/dsdt.dsl

thanks,
Felix


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
