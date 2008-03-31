From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 00/37] PNP resource_table cleanups
Date: Mon, 31 Mar 2008 21:40:03 +0200
Message-ID: <47F13E13.7090608@keyaccess.nl>
References: <20080326171058.099442579@ldl.fc.hp.com> <200803261713.03248.bjorn.helgaas@hp.com> <47EAEA98.7010500@keyaccess.nl> <200803271150.30512.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070404000105080104060607"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:44200 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbYCaTid (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Mar 2008 15:38:33 -0400
In-Reply-To: <200803271150.30512.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This is a multi-part message in MIME format.
--------------070404000105080104060607
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 27-03-08 18:50, Bjorn Helgaas wrote:

> Are any ISAPNP devices at all found?

Yes, but at most 100 * 10^4 / 2^16 percent of them. Trouble is in 04/37:

http://lkml.org/lkml/2008/3/26/273

The numeric part of the ID is a 4-digit hexadecimal value, not just decimal, 
so '0'+ don't work. Unfortunately, that one has a few dependents, so you'll 
probably want to restructure things yourself. If I just place the attached 
on top, the card's found again.

Not too much avail unfortunately, as I then get a resource assignment 
problem with your patches:

pnp: the driver 'cs4236_isapnp' has been registered
cs4236_isapnp 01:01.00: driver attached
cs4236_isapnp 01:01.02: driver attached
cs4236_isapnp 01:01.03: driver attached
cs4236_isapnp 01:01.00: unable to assign resources
CS4236+ WSS PnP configure failed for WSS (out of resources?)
isapnp detection failed and probing for CS4236+ is not supported

(and exact same thing for snd-es18xx) which I'll try to look at next, but 
this ID thing will certainly need a fix first.

Rene.

--------------070404000105080104060607
Content-Type: text/plain;
 name="isapnp_to_pnpid.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isapnp_to_pnpid.diff"

diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index c4b95b5..0a41e05 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -403,14 +403,12 @@ static void __init isapnp_skip_bytes(int count)
 static void isapnp_to_pnpid(unsigned short vendor, unsigned short device,
 			    char *id)
 {
-	id[0] = 'A' + ((vendor >> 2) & 0x3f) - 1;
-	id[1] = 'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1;
-	id[2] = 'A' + ((vendor >> 8) & 0x1f) - 1;
-	id[3] = '0' + ((device >> 4) & 0x0f);
-	id[4] = '0' + (device & 0x0f);
-	id[5] = '0' + ((device >> 12) & 0x0f);
-	id[6] = '0' + ((device >> 8) & 0x0f);
-	id[7] = '\0';
+	sprintf(id, "%c%c%c%x%x%x%x",
+		'A' + ((vendor >> 2) & 0x3f) - 1,
+		'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,
+		'A' + ((vendor >> 8) & 0x1f) - 1,
+		(device >> 4) & 0x0f, device & 0x0f,
+		(device >> 12) & 0x0f, (device >> 8) & 0x0f);
 }
 
 /*

--------------070404000105080104060607--
