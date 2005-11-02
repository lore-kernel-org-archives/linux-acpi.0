From: Enrico Teotti <agenteo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: asus l3000d
Date: Wed, 2 Nov 2005 10:06:03 +0100
Message-ID: <37c051a00511020106g29f0db8fi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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
I'm the owner of a Asus L3000d with some ACPI problems... I'm posting
here hoping to get some help. Sorry about my bad english.
When I turn on acpi in the bootloader, sometimes, randomly the laptop
hangs and also sometimes it's as hot as in hell (no I haven't been
there yet).
Giving (acpi=3Don and the acpid running):
acpi -V
I get:
No support for device type: battery
No support for device type: thermal
No support for device type: ac_adapter

uname -r
2.6.12-gentoo-r10
the kernel is coming from the gentoo portage.

tailed to the mail you'll find the ACPI stuff I've got in the kernel.

I've googled and looked around, and I've found a thread on a Gentoo forum:
http://forums.gentoo.org/viewtopic.php?t=3D122145

I need some suggestions about witch way to take. Do I really need to
follow the thread DSDT editing way? Or is my solution already out
there?

Just in case the answer is the first one, I'll post the stuff I've done.

Thanks in advance,
Enrico

# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=3Dy
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
# CONFIG_ACPI_SLEEP is not set
CONFIG_ACPI_AC=3Dm
CONFIG_ACPI_BATTERY=3Dm
CONFIG_ACPI_BUTTON=3Dm
CONFIG_ACPI_VIDEO=3Dm
CONFIG_ACPI_FAN=3Dm
CONFIG_ACPI_PROCESSOR=3Dm
CONFIG_ACPI_THERMAL=3Dm
CONFIG_ACPI_ASUS=3Dm
CONFIG_ACPI_IBM=3Dm
CONFIG_ACPI_TOSHIBA=3Dm
CONFIG_ACPI_BLACKLIST_YEAR=3D0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_ACPI_CONTAINER=3Dm
CONFIG_X86_ACPI_CPUFREQ=3Dm
CONFIG_X86_POWERNOW_K7_ACPI=3Dy
CONFIG_X86_POWERNOW_K8_ACPI=3Dy
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=3Dy
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_PNPACPI=3Dy
CONFIG_SERIAL_8250_ACPI=3Dy


--
"The only thing necessary for the triumph of evil
is for good men to do nothing"
 Edmund Burke


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
