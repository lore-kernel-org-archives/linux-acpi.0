From: Russell Neches <russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org>
Subject: networking half-working after S3 resume
Date: Sat, 14 Aug 2004 21:34:57 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092533697.1841.78.camel@localhost>
Reply-To: russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bm0RV66xzevQGgqGypA7"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-Devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-bm0RV66xzevQGgqGypA7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey there!

After an S3 resume, my laptop comes back to life perfectly, with the
exception of networking. I had originally blamed this on the card
drivers until I noticed that my wireless card can still get a link. So,
I tried playing around a bit, and I discovered the following:

* The wireless card correctly detects my AP (SSID, speed, link power, et
cetera)

* I can see DHCP requests coming from the laptop's wired interface, but
the responses from my DHCP server are ignored.

* If I manually configure the wired interface on my laptop and attempt
to ping my desktop, I can see ARP requests coming from the laptop's IP
looking for my desktop.=20

* If I run "arp -s <desktop_IP> <desktop_ETHER>" on my laptop to
manually create an ARP table entry for my desktop, and then attempt to
ping my desktop, I can see ICMP Echo requests coming from my laptop. My
desktop acknowledges them, but my laptop still gets 100% packet loss.

* dmesg reports transmit timeouts, despite the fact the the packets are,
in fact, reaching my switch:

  NETDEV WATCHDOG: eth0: transmit timed out
  eth0: Transmit timeout, status 0c 0005 c07f media 10.
  eth0: Tx queue start entry 4  dirty entry 0.
  eth0:  Tx descriptor 0 is 0008a03c. (queue head)
  eth0:  Tx descriptor 1 is 0008a03c.
  eth0:  Tx descriptor 2 is 0008a03c.
  eth0:  Tx descriptor 3 is 0008a03c.
  eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

So, networking is *half* working; I can send packets, I just can't
receive any (the watchdog warnings notwithstanding). It's affecting two
different cards, and persists after removing and reloading modules for
each of them. Both cards seem to retain most basic link layer
functionality. Could this be a bug higher up in the networking stack?
(As opposed to a bug in the drivers.) I've never had an issue with any
kernel networking code above the link layer. Is there a way to prod,
smack or otherwise reload it?

Russell

-- Hardware --
	Host: Toshiba Libretto L5
	Wired Ethernet: Realtek RTL-8139/8139C/8139C+
	Wireless: A MiniPCI thing of some kind (uses orinoco_cs)
-- Software --
	Kernel: Plain-vanilla 2.6.7=20
		built with gcc 3.3.4 (Debian 1:3.3.4-7)
	Drivers: 8139too, orinoco_cs, assorted ACPI modules

--=-bm0RV66xzevQGgqGypA7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBHr3BHeAQ1TJNf5IRAv5YAKCXyN0sAqsNBmEIeqRDKKkvO0SE6wCeIvBm
G8G/tPcujP3QAM0zHHO8RME=
=JO+l
-----END PGP SIGNATURE-----

--=-bm0RV66xzevQGgqGypA7--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
