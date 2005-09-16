From: Massimo Maiurana <maiurana-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: wakeup devices
Date: Fri, 16 Sep 2005 21:13:42 +0200
Message-ID: <432B1966.9070903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: Quoted-Printable
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


hi all,
my system at boot prints the following lines:

ACPI wakeup devices:
PCI0 PS2K PS2M COM1 COM2 USB0

so I thought I was able to resume from a suspend state pressing a key
or moving the mouse, but the only way to resume is pressing the power
button.
doing "echo PS2K > /proc/acpi/wakeup" toggles the state for ps2
devices from disabled to enabled, but nothing really changes.

is it a misconfiguration on my side, a missing support by a driver, or
something else?
or am I misunderstanding the meaning of those lines?

I googled around a bit with no luck, and even a search in the ml
archive didn't help (I found only messages without any reply).

TIA

--=20
         Massimo Maiurana          mailto:maiurana-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
	 http://massimo.solira.org       GPG keyID #7044D601

Articolo 11 - L'Italia ripudia la guerra come strumento di offesa alla
libert=E0  degli  altri  popoli   e  come  mezzo  di  risoluzione  delle
controversie internazionali....



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
