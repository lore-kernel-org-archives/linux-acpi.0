From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 3.11-rc2 [backlight] [ASUS N56VZ]
Date: Wed, 24 Jul 2013 23:23:16 +0200
Message-ID: <6051153.b6TE1dlrel@vostro.rjw.lan>
References: <BLU0-SMTP125E791F01E26C3D60D7353A6680@phx.gbl>
	<20130724210200.GY5939@phenom.ffwll.local>
	<CA+55aFxvLox_iwPAg=iJx4F9M_FpMPY3ettFtAJOUk78d4+0pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <CA+55aFxvLox_iwPAg=iJx4F9M_FpMPY3ettFtAJOUk78d4+0pw@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, * =?ISO-8859-1?Q?SAM=CD?= * <miaousami@hotmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Igor Gnatenko <i.gnatenko.brain@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, July 24, 2013 02:05:15 PM Linus Torvalds wrote:
> On Wed, Jul 24, 2013 at 2:02 PM, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >
> > I think a i915 module option should be doable, otoh people seem to have a
> > viable workaround by setting a different acpi os version already.
> 
> At least the original claim was that if you set a non-windows8 acpi os
> version, you hit other bugs..
> 
> But yeah, if we just do a plain revert, that may be the only option
> for the people for whom the current (to-be-reverted) patches made
> things work.

Well, I wonder what about the appended (untested) patch?

It should restore the previous behavior while leaving an option to use the
new stuff if need be.

Rafael


---
 drivers/gpu/drm/i915/i915_dma.c |    2 +-
 drivers/gpu/drm/i915/i915_drv.c |    5 +++++
 drivers/gpu/drm/i915/i915_drv.h |    1 +
 include/acpi/video.h            |   16 ++++++----------
 4 files changed, 13 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/gpu/drm/i915/i915_dma.c
===================================================================
--- linux-pm.orig/drivers/gpu/drm/i915/i915_dma.c
+++ linux-pm/drivers/gpu/drm/i915/i915_dma.c
@@ -1648,7 +1648,7 @@ int i915_driver_load(struct drm_device *
 	if (INTEL_INFO(dev)->num_pipes) {
 		/* Must be done after probing outputs */
 		intel_opregion_init(dev);
-		acpi_video_register_with_quirks();
+		__acpi_video_register(i915_take_over_backlight);
 	}
 
 	if (IS_GEN5(dev))
Index: linux-pm/drivers/gpu/drm/i915/i915_drv.c
===================================================================
--- linux-pm.orig/drivers/gpu/drm/i915/i915_drv.c
+++ linux-pm/drivers/gpu/drm/i915/i915_drv.c
@@ -132,6 +132,11 @@ int i915_enable_ips __read_mostly = 1;
 module_param_named(enable_ips, i915_enable_ips, int, 0600);
 MODULE_PARM_DESC(enable_ips, "Enable IPS (default: true)");
 
+bool i915_take_over_backlight __read_mostly = false;
+module_param_named(take_over_backlight, i915_take_over_backlight, bool, 0644);
+MODULE_PARM_DESC(take_over_backlight,
+		 "Prevent ACPI backlight from being used (default: false)");
+
 static struct drm_driver driver;
 extern int intel_agp_enabled;
 
Index: linux-pm/drivers/gpu/drm/i915/i915_drv.h
===================================================================
--- linux-pm.orig/drivers/gpu/drm/i915/i915_drv.h
+++ linux-pm/drivers/gpu/drm/i915/i915_drv.h
@@ -1542,6 +1542,7 @@ extern int i915_enable_ppgtt __read_most
 extern unsigned int i915_preliminary_hw_support __read_mostly;
 extern int i915_disable_power_well __read_mostly;
 extern int i915_enable_ips __read_mostly;
+extern bool i915_take_over_backlight __read_mostly;
 
 extern int i915_suspend(struct drm_device *dev, pm_message_t state);
 extern int i915_resume(struct drm_device *dev);
Index: linux-pm/include/acpi/video.h
===================================================================
--- linux-pm.orig/include/acpi/video.h
+++ linux-pm/include/acpi/video.h
@@ -18,20 +18,11 @@ struct acpi_device;
 
 #if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
 extern int __acpi_video_register(bool backlight_quirks);
-static inline int acpi_video_register(void)
-{
-	return __acpi_video_register(false);
-}
-static inline int acpi_video_register_with_quirks(void)
-{
-	return __acpi_video_register(true);
-}
 extern void acpi_video_unregister(void);
 extern int acpi_video_get_edid(struct acpi_device *device, int type,
 			       int device_id, void **edid);
 #else
-static inline int acpi_video_register(void) { return 0; }
-static inline int acpi_video_register_with_quirks(void) { return 0; }
+static inline int __acpi_video_register(bool backlight_quirks) { return 0; }
 static inline void acpi_video_unregister(void) { return; }
 static inline int acpi_video_get_edid(struct acpi_device *device, int type,
 				      int device_id, void **edid)
@@ -40,4 +31,9 @@ static inline int acpi_video_get_edid(st
 }
 #endif
 
+static inline int acpi_video_register(void)
+{
+	return __acpi_video_register(false);
+}
+
 #endif
