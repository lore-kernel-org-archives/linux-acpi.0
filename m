From: Olivier Berger <oberger@ouvaton.org>
Subject: Re: Incorrect ACPI blacklisting of ASUS P4B266 ?
Date: Sun, 17 May 2009 09:38:46 +0200
Message-ID: <87ws8gfabd.fsf@olivierberger.com>
References: <87k5691x3y.fsf@olivierberger.com>
	<200904281339.15689.trenn@suse.de> <877i14aed8.fsf@olivierberger.com>
	<200904281956.50640.trenn@suse.de>
	<alpine.LFD.2.00.0905141307300.24833@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:60319 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbZEQHi5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 May 2009 03:38:57 -0400
In-Reply-To: <alpine.LFD.2.00.0905141307300.24833@localhost.localdomain> (Len Brown's message of "Thu\, 14 May 2009 13\:14\:29 -0400 \(EDT\)")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org

--=-=-=

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

Len Brown <lenb@kernel.org> writes:

> The P4B266 DMI entry went into ./arch/i386/kernel/dmi_scan.c
> back in Aug-2003.

Wow, I understand why it was hard to track it back to the time it was
included ;-)

>
> That was when I was just starting to maintain ACPI,
> and I took a bunch of blacklist entries from SuSE
> because they were already shipping with ACPI enabled.
>
> In the short term, it may have been the right thing to do,
> but in the long term it was a mistake and I regret doing it.
>
> Blacklist entries paper-over real bugs, and unless we are lucky
> enough that somebody like you, Oliver, steps forward,
> blacklist entries are nearly impossible to ever remove.
>
> So I'm inclined to apply your original patch to delete
> the blacklist entry entirely.  If somebody with one of
> those boxes has a regression, we'll go fix their box --
> which we may have acutally fixed years ago and not known it...
>

OK, as a maintainer you'll be the one to blame ;) And as a user, I'll be
glad to see my system fully using ACPI, I guess :-)


Len Brown <lenb@kernel.org> writes:

> Olivier,
> If you can send me a properly formatted patch
> to remove the dmi entry,
> (Documentation/SubmittingPatches)
> including your signed-off, i'll apply it.

Here's it in attachment. I'm not really experienced with git so I hope
it suits your needs.

>
> thanks,
> Len Brown, Intel Open Source Technology Center
>
>

Best regards,


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-Removing-ACPI-blacklisting-for-P4B266-mainboards.patch

>From 6f304fa7c0e0c5bac86fb47c53354889017fceb8 Mon Sep 17 00:00:00 2001
From: olivier <olivier@olivierberger.com>
Date: Sat, 16 May 2009 15:47:18 +0200
Subject: [PATCH] Removing ACPI blacklisting for P4B266 mainboards.
 See http://marc.info/?l=linux-acpi&m=124068823904429&w=2 for discussion

Signed-off-by: Olivier Berger <oberger@ouvaton.org>
---
 arch/x86/kernel/acpi/boot.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 723989d..065b3fa 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1569,14 +1569,6 @@ static struct dmi_system_id __initdata acpi_dmi_table[] = {
 	 },
 	{
 	 .callback = force_acpi_ht,
-	 .ident = "ASUS P4B266",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-		     DMI_MATCH(DMI_BOARD_NAME, "P4B266"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
 	 .ident = "ASUS P2B-DS",
 	 .matches = {
 		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-- 
1.6.2.4


--=-=-=


- -- 
Olivier BERGER 
(OpenPGP: 1024D/B4C5F37F)
http://www.olivierberger.com/weblog/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8+ <http://mailcrypt.sourceforge.net/>

iD8DBQFKD77rLBigKrTF838RAthrAKDerhUKv8JZTvtJ5SrlooeFZofU0wCgyJ8L
8z1I6OP9wSsS7JQn7vm1UIc=
=AQyP
-----END PGP SIGNATURE-----

--=-=-=--
