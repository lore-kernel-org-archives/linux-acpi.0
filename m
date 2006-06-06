From: Ryan Lortie <desrt@desrt.ca>
Subject: ACPI on Macbook
Date: Tue, 06 Jun 2006 02:45:47 -0400
Message-ID: <1149576347.660.9.camel@moonpix.desrt.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gDMn9jAwWIek6fj97yP2"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1b.mountaincable.net ([24.215.0.11]:54673 "EHLO
	ns1.mountaincable.net") by vger.kernel.org with ESMTP
	id S1751123AbWFFGpy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Jun 2006 02:45:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>


--=-gDMn9jAwWIek6fj97yP2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello.

I have been working on getting my new Macbook working with Ubuntu dapper
for suspend.

Initially, the machine would crash on wake up.  I created a fix to the
PCI drivers for that and now it doesn't crash (fix is now in the Ubuntu
kernel repository).

After this fix I noticed that ACPI was non-functional after reboot.
This is because the irq9 handler gets disabled with the "nobody cared"
message.

This happens because when the machine comes up, irq9 is high
(level-triggered) but the ACPI code doesn't think it has anything to do.
It therefore returns IRQ_NONE instead of IRQ_HANDLED and the kernel
starts ignoring irq9 (preventing ACPI from working).

I found that the cause of this problem is that when the laptop returns
from sleep the SCI_EN bit has been cleared.  Actually, the entire PM1
register has been cleared (from inspecting the ports with a userspace
app).  On the ICH7 you can directly set this bit by 'or'ing the contents
of the PM1 port (0x404) with the value 0x01.

Currently in my custom-patched kernel I have a quick outw(1, 0x404); as
soon as the system comes back from sleep (before re-enabling interrupts,
even).  This fixes the problem and no spurious irq9's are issued.

This works smashingly well for me but unfortunately it's a gigantic ugly
hack.  I've been talking to Matthew Garrett (mjg59) about this problem
and he suggested that it might be at least a tiny bit cleaner to put a
call to acpi_enable() there instead (set SCI_EN indirectly since the
ACPI spec says it might not be correct to set it directly).
Unfortunately, when I do this the machine locks on resume.

So I'm writing this list to ask a couple of things:

1) Why do y'all think SCI_EN is being cleared when the machine goes to
sleep and wakes up again?

2) What is the best way of dealing with this problem in a non-hackish
way?

I'm not on the list so please reply-to-all.

Cheers

--=-gDMn9jAwWIek6fj97yP2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQG5AwUARIUkm596IjKvqm/2AQJWSw0gqgH0zDP7fx67wlnGZyyJIOGYLOQnoWCQ
/NJgFVvlVYZ2UYCeRZ1Y4rEGMlmcjcsmF6IaZiFmsJ/RMq3Kkc5ktripnb0oCJ87
u5Xs1FJq1gZsP2IzHBV0k/hGeWvk4C4tCHf+qY0IJEHdZzQH2mPGFYNGJYdSAXEV
k7HVoX3/WLKXRlrFGFCVJFgOJ44D3xyZiYkG5ZUB2zcdkaxbATV/eihPgQzlJiJz
hIIPNki0Xeqx6S0pp1jsexfPF+oqFbQshBVe+ZvqxrGVCWUbyZTLyEBiJh5nwLdm
fbWBZAugx0VpRhbcwIaxkZNW+Kjf+6NUBgSMGOrtAA2gtpGveMuSwieE1KZ0yBWw
xnmo8GA32rec9ig0chpv3KczvPtoAcjp1kc6xdH+xdFdRS2UVgqWWgBT6Aac82bU
JAV6T/YPgD50Wy6VUPlZlKnq60SSmLna2Y16PRDqw/+ScKA9TnD9Ij/OWSu7o0W7
4af51fHdOM985xMTL4kk5x1dipw4qqBHgGhZyr+WxGUxd5IBF13QFqaW6qyHf8GU
K01ncBqFHLbXRR3Y
=xDLN
-----END PGP SIGNATURE-----

--=-gDMn9jAwWIek6fj97yP2--

