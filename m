From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: Suspend 2 ram gone with latest bk-acpi patch
Date: Tue, 22 Mar 2005 13:09:45 +0100
Message-ID: <20050322120945.GB5917@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
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

Hi ACPI developers!

I am using suspend to ram successfully wiht 2.6.11-mm4 and prior
incarnations, but since 2.6.12-rc1-mm1 the laptop does not wake up after
suspend to ram. With 2.6.11-mm4 it is still working with exactely the
same setup.

I unload the whole usb stuff (otherwise 2.6.11-mm4 won't work) and do
exactely the same.

The differences in the kernel config files are trivial:

new stuff I answered with yes:
+CONFIG_ACPI_HOTKEY=3Dy
+CONFIG_PCMCIA_IOCTL=3Dy
+CONFIG_AOE_PARTITIONS=3D16

stuff that has automatically changed (changed Kconfig I suppose)
-CONFIG_FW_LOADER=3Dm
+CONFIG_FW_LOADER=3Dy

and some modules I compiled but not use/load.

With 2.6.12-rc1-mm1 the system starts, then nothing, black screen, no
CapsLock light, no Sysrq, no sync hard disk led activity, just plane
frozen.

I suspect that this is related to the big changes in ACPI code (I am
also seeing a lot of new messages while booting from the ACPI subsystem
like:
ACPI: Can't get handler for 0000:00:00.0
ACPI: No ACPI bus support for 00:01
ACPI: No ACPI bus support for 1-0:1.0
etc

Can you confirm that this may be the cause of the recent problems, and
what kind of tests can I make to confirm it?

Thanks a lot and all the best

Norbert

-------------------------------------------------------------------------=
------
Norbert Preining <preining AT logic DOT at>                 Universit=E0 =
di Siena
sip:preining-5G14tY4QmKiDqU6vP1vexV6hYfS7NtTn@public.gmane.org                             +43 (0) 59966-=
690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C=
5 B094
-------------------------------------------------------------------------=
------
ULLAPOOL (n.)
The spittle which builds up on the floor of the Royal Opera House.
			--- Douglas Adams, The Meaning of Liff


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
