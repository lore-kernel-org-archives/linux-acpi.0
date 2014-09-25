From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: ACPI/i915: Cannot configure display brightness on
 Dell Latitude E6440
Date: Thu, 25 Sep 2014 11:15:35 +0800
Message-ID: <542388D7.1010008@intel.com>
References: <201409232206.02819@pali> <201409241453.46756@pali>
 <5422D66D.6090903@redhat.com> <201409242021.10107@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <201409242021.10107@pali>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: =?windows-1252?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Hans,

Thanks for following up and explaining the situation to Pali.

On 09/25/2014 02:21 AM, Pali Roh=E1r wrote:
> On Wednesday 24 September 2014 16:34:21 Hans de Goede wrote:
>> Ok, so the dell-laptop interface is just an obsolete wrapper
>> around the i915 opregion code, which shows that the right
>> interface to use is the i915 one, which we do if you don't
>> specify any kernel commandline parameters, case closed.
>>
>> Regards,
>>
>> Hans
> =

> Nope, its not closed.
> =

> Still i915 interface has problem with setting backlight. It =

> exports lot of levels which turning display off. Which breaking =

> exiting applications for configuring display brightness. This is =

> still big regression as black screen is not want people want to =

> see.
> =

> Driver dell-laptop has exported only few - not thousands level =

> (which is insane) and only usefull levels (not lot of levels =

> which turn display off).
> =

> So for this reason using i915 backlight interface is not possible =

> and also Dell (for E6440) set kernel param acpi_backlight=3Dvendor =

> to use dell_laptop module for controlling brightness.
> =

> On my laptop E6440 is better for using dell-laptop and not acpi =

> or i915.

Hi Pali,

Please test this patch:

diff --git a/drivers/gpu/drm/i915/intel_opregion.c b/drivers/gpu/drm/i915/i=
ntel_opregion.c
index ca52ad2ae7d1..15534345bd57 100644
--- a/drivers/gpu/drm/i915/intel_opregion.c
+++ b/drivers/gpu/drm/i915/intel_opregion.c
@@ -396,6 +396,24 @@ int intel_opregion_notify_adapter(struct drm_device *d=
ev, pci_power_t state)
 	return -EINVAL;
 }
 =

+/*
+ * Some of the Thinkpads' firmware will issue a backlight change operation
+ * region request unconditionally on AC plug/unplug, this is undesirable a=
nd
+ * should be ignored. Then there is a Dell laptop whose vendor backlight
+ * interface also makes use of operation region request to change backlight
+ * level and we have to keep it work. The rule used here is: if the vendor
+ * backlight interface is not in use and the ACPI backlight interface is
+ * broken, we ignore the requests; oterwise, we keep processing them.
+ */
+static bool should_ignore_backlight_request(void)
+{
+	if (acpi_video_backlight_support() &&
+	    !acpi_video_verify_backlight_support())
+		return true;
+
+	return false;
+}
+
 static u32 asle_set_backlight(struct drm_device *dev, u32 bclp)
 {
 	struct drm_i915_private *dev_priv =3D dev->dev_private;
@@ -404,11 +422,7 @@ static u32 asle_set_backlight(struct drm_device *dev, =
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
