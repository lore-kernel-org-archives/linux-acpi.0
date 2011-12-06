From: Baptiste Jonglez <baptiste@jonglez.org>
Subject: Re: [Dual-LVDS Acer Iconia laptop] i915/DRM issue: one screen stays
 off [3.2-rc4+]
Date: Tue, 6 Dec 2011 22:51:37 +0100
Message-ID: <20111206215137.GA20907@archminux>
References: <20111204160728.GA27292@archminux>
 <1323054041.6046.79.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323054041.6046.79.camel@linux-s257.site>
Sender: platform-driver-x86-owner@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Baptiste Jonglez <baptiste@jonglez.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Chris Wilson <chris@chris-wilson.co.uk>, intel-gfx@lists.freedesktop.org
List-Id: linux-acpi@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Dec 05, 2011 at 11:00:41AM +0800, joeyli wrote:
> Add Cc. to platform-driver-x86 and linux-acpi
> 
> Hi Baptiste
> 
> 於 日，2011-12-04 於 17:07 +0100，Baptiste Jonglez 提到：
> > Hi,
> > 
> > I've got a lot of troubles with a dual-LVDS Acer laptop (it doesn't
> > have a keyboard, but two displays with touchscreens)
> > 
> > The Intel GPU is integrated into the Core i5-480M CPU: it's a bit
> > older than Sandybridge, as it seems to be based on the Arrandale
> > micro-architecture.
> > 
> > In the BIOS, both displays work fine; but as soon as the kernel boots
> > up, the second display (i.e. the one where you usually find a
> > keyboard) is turned off. The main display works as expected.
> > 
> > xrandr reports two LVDS displays: LVDS1, which is connected, and
> > LVDS2, which is marked as "disconnected". No matter what I tried, I
> > can't bring that second display up.
> > 
> > During the boot, just after the drm is set up, the following message
> > shows up:
> > 
> >   [drm:intel_dsm_pci_probe] *ERROR* failed to get supported _DSM functions
> > 
> > (attached is the relevant part of dmesg [1])

The second screen works fine with the attached patch. It actually is
6 months old but seems to have been lost in the wild...

Thanks Benjamin!

There is still the issue of unhandled acer-wmi events, but it's far
less incapacitating. I wonder what's the best way to report events to
userspace, though (e.g. for the "keyboard" button, userspace might
want to know when it is pressed in order to display a virtual keyboard
or any other fancy stuff)

Joey, if you need more logs for acer-wmi, I'll be happy to provide.


Baptiste

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=iconia-patch-lvds-lkml

Original patch by Chris Wilson [1], here slightly adapted for the latest tree.

[1] https://bugs.freedesktop.org/attachment.cgi?id=49069


We were checking whether the supplied edid matched the connector it was
read from. We do this in case a DDC read returns an EDID for another
device on a multifunction or otherwise interesting card. However, we
failed to include LVDS as a digital device and so rejecting an otherwise
valid EDID.

Fixes the detection of the secondary SDVO LVDS panel on the Libretto
W105.

diff --git a/drivers/gpu/drm/i915/intel_sdvo.c b/drivers/gpu/drm/i915/intel_sdvo.c
index 3003fb2..ac322fb 100644
--- a/drivers/gpu/drm/i915/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/intel_sdvo.c
@@ -50,6 +50,7 @@
 #define IS_TMDS(c)	(c->output_flag & SDVO_TMDS_MASK)
 #define IS_LVDS(c)	(c->output_flag & SDVO_LVDS_MASK)
 #define IS_TV_OR_LVDS(c) (c->output_flag & (SDVO_TV_MASK | SDVO_LVDS_MASK))
+#define IS_DIGITAL(c) (c->output_flag & (SDVO_TMDS_MASK | SDVO_LVDS_MASK))
 
 
 static const char *tv_format_names[] = {
@@ -1314,6 +1315,18 @@ intel_sdvo_tmds_sink_detect(struct drm_connector *connector)
 	return status;
 }
 
+static bool
+intel_sdvo_connector_matches_edid(struct intel_sdvo_connector *sdvo,
+				struct edid *edid)
+{
+	bool monitor_is_digital = !!(edid->input & DRM_EDID_INPUT_DIGITAL);
+	bool connector_is_digital = !!IS_DIGITAL(sdvo);
+
+	DRM_DEBUG_KMS("connector_is_digital? %d, monitor_is_digital? %d\n",
+			connector_is_digital, monitor_is_digital);
+	return connector_is_digital == monitor_is_digital;
+}
+
 static enum drm_connector_status
 intel_sdvo_detect(struct drm_connector *connector, bool force)
 {
@@ -1358,10 +1371,11 @@ intel_sdvo_detect(struct drm_connector *connector, bool force)
 		if (edid == NULL)
 			edid = intel_sdvo_get_analog_edid(connector);
 		if (edid != NULL) {
-			if (edid->input & DRM_EDID_INPUT_DIGITAL)
-				ret = connector_status_disconnected;
-			else
+			if (intel_sdvo_connector_matches_edid(intel_sdvo_connector,
+								edid))
 				ret = connector_status_connected;
+			else
+				ret = connector_status_disconnected;
 			connector->display_info.raw_edid = NULL;
 			kfree(edid);
 		} else
@@ -1402,11 +1416,8 @@ static void intel_sdvo_get_ddc_modes(struct drm_connector *connector)
 		edid = intel_sdvo_get_analog_edid(connector);
 
 	if (edid != NULL) {
-		struct intel_sdvo_connector *intel_sdvo_connector = to_intel_sdvo_connector(connector);
-		bool monitor_is_digital = !!(edid->input & DRM_EDID_INPUT_DIGITAL);
-		bool connector_is_digital = !!IS_TMDS(intel_sdvo_connector);
-
-		if (connector_is_digital == monitor_is_digital) {
+		if (intel_sdvo_connector_matches_edid(to_intel_sdvo_connector(connector),
+							edid)) {
 			drm_mode_connector_update_edid_property(connector, edid);
 			drm_add_edid_modes(connector, edid);
 		}

--2fHTh5uZTiUOsy+g--
