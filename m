From: Mirco Jeske <mjeske-RKxZfb59NXU@public.gmane.org>
Subject: Problems with ASUS A3G
Date: Fri, 25 Mar 2005 17:19:27 +0100
Message-ID: <42443A0F.1090601@foni.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi,

I'm new to that list, so thank you for reading this.

I have an ASUS A3843GLP  driving with a 2.9.11 kernel. I patched the=20
kernel as mentioned on http://acpi.sourceforge.net/download.html
Problems are:
- fan almost always running on lowest level
- speed step control fails when using kpowerd (no speed step, CPU runs=20
on 1700 MHz all the time, but acpi -V reports that the CPU runs on 50%)
- writing different temperature levels to the thermalzone is accepted=20
but ignored. Fan still runs even if temperature of CPU is below 50=B0C

For testing I installed Windows and got the fan deactivated using=20
SpeedswitchXP (Power4Gear didn't make it for me). Since I had no=20
experience with ASUS notenooks I now know that it is possible to=20
throttle down the CPU to 600 MHz and having the fan NOT working. So, is=20
there a way to configure acpi that this is also possible with Linux?

thanx for help,
Mirco




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
