From: vidyut karan <kvidyut2000-/E1597aS9LQxFYw1CcD5bw@public.gmane.org>
Subject: Re: native vs acpi support
Date: Sat, 24 Sep 2005 03:10:44 +0100 (BST)
Message-ID: <20050924021044.61508.qmail@web35415.mail.mud.yahoo.com>
References: <20050912110025.A15668@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1313400353-1127527844=:59414"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050912110025.A15668-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-hotplug-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--0-1313400353-1127527844=:59414
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,
=20
Section [6.7.8] of pci express specs related to OSHP says that

"Some systems that include Hot-Plug capable Root Ports and Switches that =
are released before ACPI-compliant operating systems with native Hot-Plug=
 support are available, can use ACPI firmware for propagating Hot-Plug ev=
ents. Firmware control of the Hot-Plug registers must be disabled if an o=
perating system with native support is used. Platforms that provide ACPI =
firmware to propagate Hot-Plug events must also provide a control method =
to transfer control to the operating system."

=20

I could not understand the above properly.Please help me understand this.=
 If a OS is not ACPI compliant will it still be able to use the OSHP meth=
od provided by ACPI. Or does it mean that ACPI will disable the firmware =
taking control of Hot plug so that OS can take care of that.

=20

Also in the native hotpluggin on PCI-Express how the control flows for AC=
PI and non-ACPI case. For e.g. in linux 2.6.=20

=20

Regards,

Karan

=20


Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
On Mon, Sep 12, 2005 at 08:16:49AM +0100, vidyut karan wrote:
>=20
> What is the difference betwwen an
>=20
> OS with an "native hot plug support"
>=20
An OS that has hotplug support as described in the PCI Express
specification. This is supported by the pciehp driver.

> and controlling the hot-plug by using ACPI.
>=20
An OS that has hotplug support as described in the ACPI
specification. This is supported by the acpiphp driver.

Native pcie hotplug is newer and better, since it describes a
usage model (e.g. attention buttons, indicators etc.) and
standardizes the programming interface to the hotplug
hardware.=20

>=20
> If my query sounds idiotic, give me some pointers so that i can move
> on the right track.
>=20
See the PCI hotplug specification and PCI Express specification
from the PCI SIG, and the ACPI specification from=20
http://www.acpi.info/.

Rajesh

Send instant messages to your online friends http://in.messenger.yahoo.co=
m=20
--0-1313400353-1127527844=:59414
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Section [6.7.8] of pci express specs related to OSHP says that</DIV>
<DIV><FONT face=3DGaramond>
<P align=3Dleft><EM>"Some systems that include Hot-Plug capable Root Port=
s and Switches that are released before ACPI-compliant operating systems =
with native Hot-Plug support are available, can use ACPI </EM></FONT><FON=
T face=3DGaramond><EM>firmware for propagating Hot-Plug events. Firmware =
control of the Hot-Plug registers must be disabled if an operating system=
 with native support is used. Platforms that provide ACPI firmware to pro=
pagate Hot-Plug events must also provide a control method to transfer con=
trol to the operating system."</EM></FONT></P>
<P align=3Dleft><FONT face=3DGaramond><EM></EM></FONT>&nbsp;</P>
<P align=3Dleft><FONT face=3DGaramond>I could not understand the above pr=
operly.Please help me understand this. If a OS is not ACPI compliant will=
 it still be able to use the OSHP method provided by ACPI. Or does it mea=
n that ACPI will disable the firmware taking control of Hot plug so that =
OS can take care of that.</FONT></P>
<P align=3Dleft><FONT face=3DGaramond></FONT>&nbsp;</P>
<P align=3Dleft><FONT face=3DGaramond>Also in the native hotpluggin on PC=
I-Express how the control flows for ACPI and non-ACPI case. For e.g. in l=
inux 2.6.&nbsp;</FONT></P>
<P align=3Dleft><FONT face=3DGaramond></FONT>&nbsp;</P>
<P align=3Dleft><FONT face=3DGaramond>Regards,</FONT></P>
<P align=3Dleft><FONT face=3DGaramond>Karan</FONT></P>
<P align=3Dleft><FONT face=3DGaramond><EM></EM>&nbsp;</P></FONT><BR><BR><=
B><I>Rajesh Shah &lt;rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=3Dreplbq style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #1010ff 2px solid">On Mon, Sep 12, 2005 at 08:16:49AM +0100,=
 vidyut karan wrote:<BR>&gt; <BR>&gt; What is the difference betwwen an<B=
R>&gt; <BR>&gt; OS with an "native hot plug support"<BR>&gt; <BR>An OS th=
at has hotplug support as described in the PCI Express<BR>specification. =
This is supported by the pciehp driver.<BR><BR>&gt; and controlling the h=
ot-plug by using ACPI.<BR>&gt; <BR>An OS that has hotplug support as desc=
ribed in the ACPI<BR>specification. This is supported by the acpiphp driv=
er.<BR><BR>Native pcie hotplug is newer and better, since it describes a<=
BR>usage model (e.g. attention buttons, indicators etc.) and<BR>standardi=
zes the programming interface to the hotplug<BR>hardware. <BR><BR>&gt; <B=
R>&gt; If my query sounds idiotic, give me some pointers so that i can mo=
ve<BR>&gt; on the right track.<BR>&gt; <BR>See the PCI hotplug specificat=
ion and PCI Express specification<BR>from the PCI
 SIG, and the ACPI specification from <BR>http://www.acpi.info/.<BR><BR>R=
ajesh<BR></BLOCKQUOTE><p>Send instant messages to your online friends htt=
p://in.messenger.yahoo.com=20
--0-1313400353-1127527844=:59414--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
