From: "Cintia B. Margi" <cintia-Emgmuai4XwL2fBVCVOL8/A@public.gmane.org>
Subject: question about ACPI & Smart Batteries
Date: Thu, 12 Aug 2004 15:02:06 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040812220206.GC30862@miramar.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


Hello,

I am trying to understand the information flow between a Smart Battery and =
the values
I can see at /proc/acpi/battery/BAT0/state. I lookedt at ACPI standard, and=
 it says
that if the battery supports "smart battery", it is responsible by providin=
g the battery
related values (please correct me if I am wrong). Than I took a look at "Sm=
art Battery"
data standard and it specifies the parameters. It also says that this param=
eters should
be polled by the SMBus Host.

What I really want to know is how often /proc/acpi/battery/BAT0/state is up=
dated when
a battery is discharging/charging.=20

I do not have acpid installed, and I running Debian kernel 2.6.6, with acpi=
 version
20040326.=20
=20
Thanks!

Cintia



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
