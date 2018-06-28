From: James Morse <james.morse@arm.com>
Subject: [RFC/RFT PATCH 1/2] efi: Add helper to retrieve runtime version number
Date: Thu, 28 Jun 2018 11:06:55 +0100
Message-ID: <20180628100656.10692-2-james.morse@arm.com>
References: <20180628100656.10692-1-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180628100656.10692-1-james.morse@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-acpi@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Geoff Levand <geoff@infradead.org>, Riku Voipio <riku.voipio@linaro.org>, Mark Salter <msalter@redhat.com>, James Morse <james.morse@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Some RAS errors are related to an invalid hardware access that was
made by software. Sometimes this happens before the kernel runs.

For example, HPE's ProLiant m400 Server (aka moonshot) trips the
platforms RAS mechanism during ExitBootServices. Once the kernel
probes the RAS error descriptor regions, it finds a stale 'fatal
error', and hits the deck.

Quirking this platform based on the DMI data doesn't capture that
the bug lies in the platforms UEFI firmware. Expose the runtime
version, originally retrieved from the EFI system table's header
revision field, so that any future or unaffected platform firmware
isn't swept up too.

Signed-off-by: James Morse <james.morse@arm.com>
---
 include/linux/efi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 56add823f190..42ddf8399814 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -966,6 +966,11 @@ extern struct efi {
 	unsigned long flags;
 } efi;
 
+static inline unsigned int efi_get_runtime_version(void)
+{
+	return efi.runtime_version;
+}
+
 extern struct mm_struct efi_mm;
 
 static inline int
-- 
2.17.1
