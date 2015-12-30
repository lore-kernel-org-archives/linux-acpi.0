From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] device property: add spaces to
 PROPERTY_ENTRY_STRING macro
Date: Tue, 29 Dec 2015 17:44:48 -0800
Message-ID: <20151229174448.dba9a7ab.akpm@linux-foundation.org>
References: <1450877684-76316-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1627434.AfSeGfofYv@vostro.rjw.lan>
	<20151229172453.b8bf71ef.akpm@linux-foundation.org>
	<1850926.j60LlceTNY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:48646 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbbL3BpB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Dec 2015 20:45:01 -0500
In-Reply-To: <1850926.j60LlceTNY@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com, linux-acpi@vger.kernel.org

On Wed, 30 Dec 2015 03:06:23 +0100 "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> I'll apply it to my tree if you don't mind with the Andy's [1/3] on top
> so we have all of that in one place.

That version needed a fix.  Here's the one to apply:


From: Andrew Morton <akpm@linux-foundation.org>
Subject: include/linux/property.h: fix build issues with gcc-4.4.4

gcc-4.4.4 has problems with initialization of anonymous unions:

drivers/mfd/intel-lpss-acpi.c:30: error: unknown field 'value' specified in initializer

work around this by crafting the initializers in a manner which the
compiler can handle.

Cc: Kevin Fenzi <kevin@scrye.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/property.h |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff -puN include/linux/property.h~include-linux-propertyh-fix-build-issues-with-gcc-444 include/linux/property.h
--- a/include/linux/property.h~include-linux-propertyh-fix-build-issues-with-gcc-444
+++ a/include/linux/property.h
@@ -175,12 +175,19 @@ struct property_entry {
 	};
 };
 
+/*
+ * Note: the below four initializers for the anonymous union are carefully
+ * crafted to avoid gcc-4.4.4's problems with initialization of anon unions
+ * and structs.
+ */
+
 #define PROPERTY_ENTRY_INTEGER_ARRAY(_name_, _type_, _val_)	\
 {								\
 	.name = _name_,						\
 	.length = ARRAY_SIZE(_val_) * sizeof(_type_),		\
 	.is_array = true,					\
-	.pointer._type_##_data = _val_,				\
+	.is_string = false,					\
+	{ .pointer = { _type_##_data = _val_ } },		\
 }
 
 #define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)			\
@@ -198,14 +205,15 @@ struct property_entry {
 	.length = ARRAY_SIZE(_val_) * sizeof(const char *),	\
 	.is_array = true,					\
 	.is_string = true,					\
-	.pointer.str = _val_,					\
+	{ .pointer = { .str = _val_ } },			\
 }
 
 #define PROPERTY_ENTRY_INTEGER(_name_, _type_, _val_)	\
 {							\
 	.name = _name_,					\
 	.length = sizeof(_type_),			\
-	.value._type_##_data = _val_,			\
+	.is_string = false,				\
+	{ .value = { ._type_##_data = _val_ } },	\
 }
 
 #define PROPERTY_ENTRY_U8(_name_, _val_)		\
@@ -222,7 +230,7 @@ struct property_entry {
 	.name = _name_,					\
 	.length = sizeof(_val_),			\
 	.is_string = true,				\
-	.value.str = _val_,				\
+	{ .value = {.str = _val_} },			\
 }
 
 #define PROPERTY_ENTRY_BOOL(_name_)		\
_

