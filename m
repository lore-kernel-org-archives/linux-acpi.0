From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/6] ACPI/EC: Enhance the checks to apply to QR_EC transactions.
Date: Mon,  3 Nov 2014 13:16:20 +0800
Message-ID: <8f69ee1f6184cfd9ec9273bb034d8c2822c230f4.1414988981.git.lv.zheng@intel.com>
References: <cover.1414988981.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1414988981.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Currently a check is applied to new transactions, but QR_EC transaction=
s
are not included. This patch merges the code path to make the check als=
o
applying to the QR_EC transactions.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Ortwin Gl=C3=BCck <odi@odi.ch>
---
 drivers/acpi/ec.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 192cd11..9a51f7a 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -336,6 +336,10 @@ static int acpi_ec_transaction_unlocked(struct acp=
i_ec *ec,
 		udelay(ACPI_EC_MSI_UDELAY);
 	/* start transaction */
 	spin_lock_irqsave(&ec->lock, tmp);
+	if (!acpi_ec_started(ec)) {
+		ret =3D -EINVAL;
+		goto unlock;
+	}
 	/* following two actions should be kept atomic */
 	ec->curr =3D t;
 	pr_debug("***** Command(%s) started *****\n",
@@ -351,6 +355,7 @@ static int acpi_ec_transaction_unlocked(struct acpi=
_ec *ec,
 	pr_debug("***** Command(%s) stopped *****\n",
 		 acpi_ec_cmd_string(t->command));
 	ec->curr =3D NULL;
+unlock:
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	return ret;
 }
@@ -365,10 +370,6 @@ static int acpi_ec_transaction(struct acpi_ec *ec,=
 struct transaction *t)
 	if (t->rdata)
 		memset(t->rdata, 0, t->rlen);
 	mutex_lock(&ec->mutex);
-	if (!acpi_ec_started(ec)) {
-		status =3D -EINVAL;
-		goto unlock;
-	}
 	if (ec->global_lock) {
 		status =3D acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status)) {
--=20
1.7.10
