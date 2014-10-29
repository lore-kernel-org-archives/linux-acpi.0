From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/2] Revert "ACPI / EC: Add support to disallow QR_EC to be issued before completing previous QR_EC"
Date: Wed, 29 Oct 2014 11:33:43 +0800
Message-ID: <79ca204b4d6632c596b6ff33133e99c471b3d633.1414553399.git.lv.zheng@intel.com>
References: <544CE637.7000406@odi.ch> <cover.1414553399.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1414553399.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

It is reported that the following commit breaks Samsung hardware:
 Commit: 558e4736f2e1b0e6323adf7a5e4df77ed6cfc1a4.
 Subject: ACPI / EC: Add support to disallow QR_EC to be issued before
          completing previous QR_EC

Which means the Samsung behavior conflicts with the Acer behavior.

1. Samsung may behave like:
   [ +event 1 ] SCI_EVT set
   [ +event 2 ] SCI_EVT set
                              write QR_EC
                              read event
   [ -event 1 ] SCI_EVT clear
   Without the above commit, Samsung can work:
   [ +event 1 ] SCI_EVT set
   [ +event 2 ] SCI_EVT set
                              write QR_EC
                              CAN prepare next QR_EC as SCI_EVT=3D1
                              read event
   [ -event 1 ] SCI_EVT clear
                              write QR_EC
                              read event
   [ -event 2 ] SCI_EVT clear
   With the above commit, Samsung cannot work:
   [ +event 1 ] SCI_EVT set
   [ +event 2 ] SCI_EVT set
                              write QR_EC
                              read event
   [ -event 1 ] SCI_EVT clear
                              CANNOT prepare next QR_EC as SCI_EVT=3D0
2. Acer may behave like:
   [ +event 1 ] SCI_EVT set
   [ +event 2 ]
                              write QR_EC
                              read event
   [ -event 1 ] SCI_EVT clear
   [ +event 2 ] SCI_EVT set
   Without the above commit, Acer cannot work when there is only 1 even=
t:
   [ +event 1 ] SCI_EVT set
                              write QR_EC
                              can prepared next QR_EC as SCI_EVT=3D1
                              read event
   [ -event 1 ] SCI_EVT clear
                              CANNOT write QR_EC as SCI_EVT=3D0
   With the above commit, Acer can work:
   [ +event 1 ] SCI_EVT set
   [ +event 2 ]
                              write QR_EC
                              read event
   [ -event 1 ] SCI_EVT set
                              can prepare next QR_EC because SCI_EVT=3D=
0
                              CAN write QR_EC as SCI_EVT=3D1

Since Acer can also work with only the following commit applied:
 Commit: 3afcf2ece453e1a8c2c6de19cdf06da3772a1b08
 Subject: ACPI / EC: Add support to disallow QR_EC to be issued when
          SCI_EVT isn't set
We can revert the above commit.

This reverts commit 558e4736f2e1b0e6323adf7a5e4df77ed6cfc1a4.

Conflicts:

	drivers/acpi/ec.c

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=3D44161
Reported-and-tested-by: Ortwin Gl=C2=A8=C2=B9ck <odi@odi.ch>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 3d304ff..31b699f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -334,13 +334,13 @@ static int acpi_ec_transaction_unlocked(struct ac=
pi_ec *ec,
 	pr_debug("***** Command(%s) started *****\n",
 		 acpi_ec_cmd_string(t->command));
 	start_transaction(ec);
-	spin_unlock_irqrestore(&ec->lock, tmp);
-	ret =3D ec_poll(ec);
-	spin_lock_irqsave(&ec->lock, tmp);
 	if (ec->curr->command =3D=3D ACPI_EC_COMMAND_QUERY) {
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
 		pr_debug("***** Event stopped *****\n");
 	}
+	spin_unlock_irqrestore(&ec->lock, tmp);
+	ret =3D ec_poll(ec);
+	spin_lock_irqsave(&ec->lock, tmp);
 	pr_debug("***** Command(%s) stopped *****\n",
 		 acpi_ec_cmd_string(t->command));
 	ec->curr =3D NULL;
--=20
1.7.10
