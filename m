From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] ACPI / i915: Update the condition to ignore
 firmware backlight change request
Date: Fri, 26 Sep 2014 10:30:08 +0800
Message-ID: <5424CFB0.4080102@intel.com>
References: <201409232206.02819@pali> <201409242021.10107@pali>
 <542388D7.1010008@intel.com> <201409251623.45636@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <201409251623.45636@pali>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: =?windows-1252?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-acpi@vger.kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Some of the Thinkpads' firmware will issue a backlight change request
through i915 operation region unconditionally on AC plug/unplug, the
backlight level used is arbitrary and thus should be ignored. This is
handled by commit 0b9f7d93ca61 (ACPI / i915: ignore firmware requests
for backlight change). Then there is a Dell laptop whose vendor backlight
interface also makes use of operation region to change backlight level
and with the above commit, that interface no long works. The condition
used to ignore the backlight change request from firmware is thus
changed to: if the vendor backlight interface is not in use and the ACPI
backlight interface is broken, we ignore the requests; oterwise, we keep
processing them.

Reference: https://lkml.org/lkml/2014/9/23/854
Reported-and-tested-by: Pali Roh=E1r <pali.rohar@gmail.com>
Cc: <stable@vger.kernel.org> # v3.16 and later
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/gpu/drm/i915/intel_opregion.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_opregion.c b/drivers/gpu/drm/i915/i=
ntel_opregion.c
index ca52ad2ae7d1..d8de1d5140a7 100644
--- a/drivers/gpu/drm/i915/intel_opregion.c
+++ b/drivers/gpu/drm/i915/intel_opregion.c
@@ -396,6 +396,16 @@ int intel_opregion_notify_adapter(struct drm_device *d=
ev, pci_power_t state)
 	return -EINVAL;
 }
 =

+/*
+ * If the vendor backlight interface is not in use and ACPI backlight inte=
rface
+ * is broken, do not bother processing backlight change requests from firm=
ware.
+ */
+static bool should_ignore_backlight_request(void)
+{
+	return acpi_video_backlight_support() &&
+	       !acpi_video_verify_backlight_support();
+}
+
 static u32 asle_set_backlight(struct drm_device *dev, u32 bclp)
 {
 	struct drm_i915_private *dev_priv =3D dev->dev_private;
@@ -404,11 +414,7 @@ static u32 asle_set_backlight(struct drm_device *dev, =
u32 bclp)
 =

 	DRM_DEBUG_DRIVER("bclp =3D 0x%08x\n", bclp);
 =

-	/*
-	 * If the acpi_video interface is not supposed to be used, don't
-	 * bother processing backlight level change requests from firmware.
-	 */
-	if (!acpi_video_verify_backlight_support()) {
+	if (should_ignore_backlight_request()) {
 		DRM_DEBUG_KMS("opregion backlight request ignored\n");
 		return 0;
 	}
-- =

1.9.3
