From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI hotplug
Date: Tue, 18 Jan 2005 14:53:15 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057501006CA1@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Shah, Rajesh" <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
Docking station generally includes a PCI bridge, some PCI devices and/or
some PNP devices. Support docking station hotplug isn't so easy. You
must support PCI bridge hotplug (acpiphp possibly can do something, but
it doesn't support bridge hotplug. In addition, the docking bridge in
Thinkpad is very special, it's a transparent bridge. Normal PCI hotplug
can't support it.) and support PNP device hotplug (PNPACPI is designed
to do it, but now it doesn't support hotplug). IBM_ACPI just can do
eject and dock, but can't enumerate devices under the dock.

Thanks,
Shaohua

>> I do have an IBM Thinkpad, and I am using IBM_ACPI
>> module. But this module is limited in functionality
>
>OK.
>
>> If I boot docked in, I have more ACPI devices than if
>> I boot undocked, and that info is not possible for
>> ACPI to get dynamically when I plug the laptop in
>
>I see. Can you please send the dmesg output after enabling
>debug messages in acpiphp (acpiphp supports a "debug"
>module param)?  I'd like to see if acpiphp is even
>installing a notify handler and triggering at dock.
>
>Also, can you send the lspci -vv output with the
>laptop docked at boot time?


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
