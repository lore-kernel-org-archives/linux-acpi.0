From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: ACPI hotplug
Date: Thu, 13 Jan 2005 15:02:37 +0100
Message-ID: <pan.2005.01.13.14.02.37.561980@yahoo.com>
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

Hi,

I just read that 2.6.11-rc1 does support ACPI hotplug.
What does this really mean ?
I found some new files in /sys/firmware:
find /sys/firmware/ | grep eject
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/USB7/URTH/UPDK/eject
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/USB0/URTH/UPDK/eject
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDE0/SCND/MSTR/eject
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/LPC/EC/BAT1/eject
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/LPC/FDC/FDD0/eject

But what can I do with them, and what else is there for hotplug ?
Does it support docking stations ?

Thanks,
Paul



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
