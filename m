From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: question about ACPI & Smart Batteries
Date: Thu, 12 Aug 2004 15:10:51 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470726AFF5@orsmsx401.amr.corp.intel.com>
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
To: "Cintia B. Margi" <cintia-Emgmuai4XwL2fBVCVOL8/A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> I am trying to understand the information flow between a=20
> Smart Battery and the values
> I can see at /proc/acpi/battery/BAT0/state. I lookedt at ACPI=20
> standard, and it says
> that if the battery supports "smart battery", it is=20
> responsible by providing the battery
> related values (please correct me if I am wrong). Than I took=20
> a look at "Smart Battery"
> data standard and it specifies the parameters. It also says=20
> that this parameters should
> be polled by the SMBus Host.
>=20
> What I really want to know is how often=20
> /proc/acpi/battery/BAT0/state is updated when
> a battery is discharging/charging.=20
>=20
> I do not have acpid installed, and I running Debian kernel=20
> 2.6.6, with acpi version
> 20040326.=20

Unless you have a Fujitsu Uva, you do not have a smart battery, you have
a control method battery.

For a CM battery, the OS can poll the battery state by calling _BST, or
set a trip point (via _BTP) and the OS will get an interrupt when the
battery crosses that trip.

Regards -- Andy


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
