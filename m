From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 00/37] PNP resource_table cleanups
Date: Tue, 01 Apr 2008 12:16:10 +0200
Message-ID: <47F20B6A.1000609@keyaccess.nl>
References: <20080326171058.099442579@ldl.fc.hp.com> <200803271150.30512.bjorn.helgaas@hp.com> <47F13E13.7090608@keyaccess.nl> <200803311451.54499.bjorn.helgaas@hp.com> <47F159BE.7050201@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080600080009020902050601"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757471AbYDAKOm@vger.kernel.org>
In-Reply-To: <47F159BE.7050201@keyaccess.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080600080009020902050601
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 31-03-08 23:38, Rene Herman wrote:
> On 31-03-08 22:51, Bjorn Helgaas wrote:
> 
>> Ah, right.  Thanks for tracking that down.  I forgot to factor out
>> isapnp_to_pnpid() and pnpid32_to_pnpid() (and acpi_ex_eisa_id_to_string()
>> for that matter, though that's buried in the ACPI CA)-- they're really
>> doing the same thing and we should only need one copy (plus the CA
>> one).
> 
> I'll wait for another round then, before reviewing this further.

There's actually a hex_asc() helper in kernel.h, so before you overlook it 
as well, this is a somewhat nicer ID fix.

Rene.

--------------080600080009020902050601
Content-Type: text/plain;
 name="isapnp_to_pnpid2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isapnp_to_pnpid2.diff"

commit cfed76bc2a76f2094338bc43dae55aa814017b5f
Author: Rene Herman <rene.herman@gmail.com>
Date:   Tue Apr 1 12:03:15 2008 +0200

    [ISAPNP] fix isapnp_to_pnpid

diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index c4b95b5..9727050 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -406,11 +406,11 @@ static void isapnp_to_pnpid(unsigned short vendor, unsigned short device,
 	id[0] = 'A' + ((vendor >> 2) & 0x3f) - 1;
 	id[1] = 'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1;
 	id[2] = 'A' + ((vendor >> 8) & 0x1f) - 1;
-	id[3] = '0' + ((device >> 4) & 0x0f);
-	id[4] = '0' + (device & 0x0f);
-	id[5] = '0' + ((device >> 12) & 0x0f);
-	id[6] = '0' + ((device >> 8) & 0x0f);
-	id[7] = '\0';
+	id[3] = hex_asc((device >> 4) & 0x0f);
+	id[4] = hex_asc(device & 0x0f);
+	id[5] = hex_asc((device >> 12) & 0x0f);
+	id[6] = hex_asc((device >> 8) & 0x0f);
+	id[7] = 0;
 }
 
 /*

--------------080600080009020902050601--
