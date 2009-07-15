From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/8] fix a build error when including linux/async.h in
	another header file
Date: Wed, 15 Jul 2009 15:38:35 +0800
Message-ID: <1247643515.26272.76.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753071AbZGOHht@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org


include/linux/async.h:16: error: redefinition of typedef =E2=80=98async=
_cookie_t=E2=80=99
include/linux/async.h:16: error: previous declaration of =E2=80=98async=
_cookie_t=E2=80=99 was here
include/linux/async.h:17: error: redefinition of typedef =E2=80=98async=
_func_ptr=E2=80=99
include/linux/async.h:17: error: previous declaration of =E2=80=98async=
_func_ptr=E2=80=99 was here

fix a problem that include/linux/async.h can not be included in another=
 header file

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 include/linux/async.h |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/include/linux/async.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/include/linux/async.h
+++ linux-2.6/include/linux/async.h
@@ -9,6 +9,8 @@
  * as published by the Free Software Foundation; version 2
  * of the License.
  */
+#ifndef _ASYNC_H_
+#define _ASYNC_H_
=20
 #include <linux/types.h>
 #include <linux/list.h>
@@ -25,3 +27,4 @@ extern void async_synchronize_cookie(asy
 extern void async_synchronize_cookie_domain(async_cookie_t cookie,
 					    struct list_head *list);
=20
+#endif /* _ASYNC_H_ */
