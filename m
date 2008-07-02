From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH -next] acpi utmisc: use WARN_ON() instead of warn_on_slowpath()
Date: Wed, 02 Jul 2008 22:11:06 +0200
Message-ID: <486BE0DA.2090108@firstfloor.org>
References: <20080701103339.b5acc1f3.randy.dunlap@oracle.com>	<20080701131714.5093fa49.akpm@linux-foundation.org>	<23433248.1214943818230.JavaMail.oracle@acsmt302.oracle.com>	<20080701133535.f92a673c.akpm@linux-foundation.org>	<20080702112852.05f30950.randy.dunlap@oracle.com>	<486BCDDC.1000709@firstfloor.org>	<20080702121424.a3451eae.akpm@linux-foundation.org>	<486BD785.5050207@firstfloor.org> <20080702124316.61cc76e9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080709070401000505060102"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080702124316.61cc76e9.akpm@linux-foundation.org>
Sender: linux-next-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: randy.dunlap@oracle.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080709070401000505060102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


>
> Oh.  I don't care much.

Thanks for the encouraging words.

> But acpi is presently causing build errors and
> is abusing core kernel internals.  Please fix it.
>
> One way would be via printk() and dump_stack().

Here's a patch. Can you use that one instead of Randy's please?

-Andi






--------------080709070401000505060102
Content-Type: text/plain;
 name="bug-fallback"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bug-fallback"

Supply warn_on_slow_path() even for the !CONFIG_BUG case

Fix build problem with ACPI for !CONFIG_BUG. Noted by Randy Dunlap.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 2632328..d0d83b7 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -63,6 +63,9 @@ extern void warn_on_slowpath(const char *file, const int line);
 	unlikely(__ret_warn_on);					\
 })
 #endif
+
+static inline void warn_on_slowpath(const char *file, const int line) {}
+
 #endif
 
 #define WARN_ON_ONCE(condition)	({				\

--------------080709070401000505060102--
