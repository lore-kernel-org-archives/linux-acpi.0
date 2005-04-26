From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Why do I have to set pci=noacpi for network card to work?
Date: Tue, 26 Apr 2005 17:00:58 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057501C8AD2D@pdsmsx402.ccr.corp.intel.com>
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
To: Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>In order for the network card to work I need to load the tg3 module or
the
>bcm5700 module. It is manufactured by broadcom.
>When either of these two modules were loaded, dmesg would show a couple
of
>messages about the network card, but the last message would be that NIC
is
>down. When I would plug the cable, the lights would start flashing, but
the
>command "/etc/init.d/net.eth0 start" could not get the IP.
>
>After doing some search, I found that I need to add the pci=3Dnoacpi in
the
>grub.conf. It seems to me that somehow ACPI was shutting down the nic
card,
>and now that ACPI is disabled, the nic card is working fine.
>
>Is this normal? Is this due to a bug in the ACPI code? Is this due to a
>faulty
>device/motherboard?
>What am I missing now that the ACPI is disabled?
pci=3Dnoacpi disallow ACPI doing IRQ routing and PCI bus scan. Did
acpi=3Dnoirq help the system? If yes, it maybe an interrupt issue.

Thanks,
Shaohua


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
