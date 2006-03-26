From: Joschka Sulzer <joschkasulzer@aol.com>
Subject: ACPI-Problems with debian-etch & Kernel 2.6.16
Date: Sun, 26 Mar 2006 17:04:03 +0200
Message-ID: <4426AD63.8080505@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from imo-m23.mx.aol.com ([64.12.137.4]:29669 "EHLO
	imo-m23.mail.aol.com") by vger.kernel.org with ESMTP
	id S1751200AbWCZPEc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Mar 2006 10:04:32 -0500
Received: from JoschkaSulzer@aol.com
	by imo-m23.mx.aol.com (mail_out_v38_r7.3.) id x.29b.7f07cf1 (16098)
	 for <linux-acpi@vger.kernel.org>; Sun, 26 Mar 2006 10:04:30 -0500 (EST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
 
I recently installed etch on my Ac er Extensa laptop and as with sarge
, it boots only with noapic nolapic kernel-options
I can't use X and the text-terminals are full of:

ACPI:0339: *** ERROR: Looking up[Z00C] in namespace, AE_NOT_FOUND
search_node dfb855960 start node dfb85960 return_node 00000000

AND

ACPI-0508: *** ERROR: method execution failed [\_SB_.BAT1._BST] (node
dfb8680), AE_NOT_FOUND)

These messages appear every 10 seconds!
If anyone could help me please
Greetings Joschka Sulzer


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
 
iD8DBQFEJq1ifBvDFfZPfAIRAgmVAJoCEnLP14gH/4JIg/OgB/tObKVMZACZAXMZ
rJR2E5Jl13C9WbX8vUXmSjo=
=M6Uf
-----END PGP SIGNATURE-----

