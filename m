From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] MAINTAINERS: Add James Morse to the list of APEI reviewers
Date: Tue, 5 Feb 2019 13:23:23 +0100
Message-ID: <20190205122323.GL21801@zn.tnic>
References: <20190205083836.21641-1-bp@alien8.de>
 <22141238.CtQSfXrvFH@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <22141238.CtQSfXrvFH@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 05, 2019 at 12:08:00PM +0100, Rafael J. Wysocki wrote:
> OK, but care to resend and CC linux-acpi too?

Here you go:

---
From: Borislav Petkov <bp@suse.de>

Add James to the list of reviewers of the firmware-assisted RAS glue.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: James Morse <james.morse@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20190205083836.21641-1-bp@alien8.de
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd5f8ea1e08b..a7e9263a208b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -331,6 +331,7 @@ ACPI APEI
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:	Len Brown <lenb@kernel.org>
 L:	linux-acpi@vger.kernel.org
+R:	James Morse <james.morse@arm.com>
 R:	Tony Luck <tony.luck@intel.com>
 R:	Borislav Petkov <bp@alien8.de>
 F:	drivers/acpi/apei/
-- 
2.19.1

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
