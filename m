From: Simeon Penev <simeon_penev@web.de>
Subject: 2.6.18 - A6T model detected, unsupported..DSDT
Date: Mon, 23 Oct 2006 16:52:04 +0200
Message-ID: <917600514@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate09.web.de ([217.72.192.184]:7869 "EHLO
	fmmailgate09.web.de") by vger.kernel.org with ESMTP id S964905AbWJWOwG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Oct 2006 10:52:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi acpi-userlist,

i'm running FC5 on an Asus A6T-AP005H (dual Turion 64bit) laptop. For a=
 month now i'm trying
to solve a problem with the kernel, which at the end led me to the
assumption it could be something with the acpi. For dmesg and other mob=
o
info see the bug i posted on the fedora list:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D205672

I saw the following message in the dmesg:

Asus Laptop ACPI Extras version 0.29
  Error calling BSTS
  A6T model detected, unsupported, trying default values, supply the
developers with your DSDT

Howerver when i try to send the DSDT via this userlist, my mails get bl=
ocked. Is there some other way i can send you the DSDT?

dmesg also says:

PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post=
 a
report

=2E.but with this option my system freezes. The only way i can run the
system for now is using the noapic kernel param. acpi=3Doff works too, =
but then all acpi features are gone. :(

Best regards,
simeon

_______________________________________________________________________
Viren-Scan f=FCr Ihren PC! Jetzt f=FCr jeden. Sofort, online und kosten=
los.
Gleich testen! http://www.pc-sicherheit.web.de/freescan/?mc=3D022222

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
