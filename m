From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 0/2] Use acpi_dev_present()
Date: Thu, 11 Feb 2016 19:31:57 +0100
Message-ID: <20160211183157.GA15803@wunner.de>
References: <cover.1453060661.git.lukas@wunner.de>
 <20160119211229.GB3253@malice.jf.intel.com>
 <5367662.pAQ7mO39ru@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:44082 "EHLO
	mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbcBKSbi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2016 13:31:38 -0500
Content-Disposition: inline
In-Reply-To: <5367662.pAQ7mO39ru@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Darren Hart <dvhart@infradead.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, platform-driver-x86@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Corentin Chary <corentin.chary@gmail.com>, acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org

Hi Rafael,

thanks a lot for your patience.

On Tue, Jan 19, 2016 at 10:59:04PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, January 19, 2016 01:12:29 PM Darren Hart wrote:
> > On Sun, Jan 17, 2016 at 09:49:41PM +0100, Lukas Wunner wrote:
> > > Hi Darren,
> > > 
> > > the acpi_dev_present() API has now landed in Linus' tree.
> > > Thus, after Linus' tree gets merged back into yours,
> > > it would be possible to use the API in the pdx86 drivers
> > > as per the following patches.
> > > 
> > > I've also pushed these to GitHub in case anyone prefers
> > > perusing them in a browser:
> > > https://github.com/l1k/linux/commits/acpi_dev_present_pdx86
> > > 
> > > This is a repost of patches submitted in November, the only
> > > change is one line added to the commit messages to reference
> > > the commit which introduces the API:
> > > http://thread.gmane.org/gmane.linux.alsa.devel/147414/focus=8004
> > > http://thread.gmane.org/gmane.linux.alsa.devel/147414/focus=8005
> > 
> > Who's tree did the API make it in through? That would likely be the best tree to
> > pull these 2 patches in from.
> > 
> > Robert, Lv, Rafael? Would one of you prefer to take these 2 patches using the
> > new API?
> 
> It was my tree and I can take these patches, but in that case I'd like the
> function's name to be changed as discussed elsewhere.
> 
> Executive summary is that we have acpi_dev_present() and acpi_device_is_present()
> now and they serve different purposes which is kind of confusing.  Moreover,
> acpi_dev_present() doesn't check if the device is actually present, so
> I would like it to be renamed to acpi_device_found() or similar.

There are 4 users of acpi_dev_present in linux-next (3 in sound/soc/intel/,
1 in include/linux/apple-gmux.h). I expect 1 other user to appear in i915.

I've created a patch (based on linux-next and included below as an RFC)
to rename acpi_dev_present to acpi_dev_found in the function declaration
as well as at all call sites. I've also rebased the 2 pdx86 patches onto
this and pushed the branch to GitHub:
https://github.com/l1k/linux/commits/acpi_dev_found

My plan is currently to wait until all users are merged into 4.6,
then rebase my branch onto Linus' tree and post the resulting patches.
This will be either late during the 4.6 merge window or immediately
after it has closed. You could then either pick up the patches for
4.6 or 4.7, whichever you prefer.

If you'd prefer a different way of moving forward or would like
something changed in the patch below, please let me know and
I will be happy to adjust accordingly.

Thanks again,

Lukas

-- >8 --
Subject: [RFC] ACPI / utils: Rename acpi_dev_present()

acpi_dev_present() was originally named after pci_dev_present()
to signify the similarity of the two functions.

However Rafael J. Wysocki pointed out that the exported function
acpi_dev_present() is easily confused with the non-exported
acpi_device_is_present(). Additionally in ACPI parlance the term
"present" usually refers to the "device is present" bit returned
by the _STA control method, yet acpi_dev_present() merely checks
presence in the namespace. It does not invoke _STA at all, let
alone check the "device is present" bit.

As suggested by Rafael, rename the function to acpi_dev_found()
and adjust all existing call sites.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/acpi/utils.c                         | 6 +++---
 include/acpi/acpi_bus.h                      | 2 +-
 include/linux/apple-gmux.h                   | 2 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 2 +-
 sound/soc/intel/common/sst-match-acpi.c      | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index f2f9873..41b80ff 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -711,7 +711,7 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, int rev, u64 funcs)
 EXPORT_SYMBOL(acpi_check_dsm);
 
 /**
- * acpi_dev_present - Detect presence of a given ACPI device in the system.
+ * acpi_dev_found - Detect presence of a given ACPI device in the namespace.
  * @hid: Hardware ID of the device.
  *
  * Return %true if the device was present at the moment of invocation.
@@ -723,7 +723,7 @@ EXPORT_SYMBOL(acpi_check_dsm);
  * instead). Calling from module_init() is fine (which is synonymous
  * with device_initcall()).
  */
-bool acpi_dev_present(const char *hid)
+bool acpi_dev_found(const char *hid)
 {
 	struct acpi_device_bus_id *acpi_device_bus_id;
 	bool found = false;
@@ -738,7 +738,7 @@ bool acpi_dev_present(const char *hid)
 
 	return found;
 }
-EXPORT_SYMBOL(acpi_dev_present);
+EXPORT_SYMBOL(acpi_dev_found);
 
 /*
  * acpi_backlight= handling, this is done here rather then in video_detect.c
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 14362a8..a84fd15 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -87,7 +87,7 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const u8 *uuid, int rev, int func,
 	  .package.elements = (eles)			\
 	}
 
-bool acpi_dev_present(const char *hid);
+bool acpi_dev_found(const char *hid);
 
 #ifdef CONFIG_ACPI
 
diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
index b2d32e0..714186d 100644
--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -35,7 +35,7 @@
  */
 static inline bool apple_gmux_present(void)
 {
-	return acpi_dev_present(GMUX_ACPI_HID);
+	return acpi_dev_found(GMUX_ACPI_HID);
 }
 
 #else  /* !CONFIG_APPLE_GMUX */
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index e609f08..ac60b04 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -296,7 +296,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	if (!drv)
 		return -ENOMEM;
 
-	drv->ts3a227e_present = acpi_dev_present("104C227E");
+	drv->ts3a227e_present = acpi_dev_found("104C227E");
 	if (!drv->ts3a227e_present) {
 		/* no need probe TI jack detection chip */
 		snd_soc_card_cht.aux_dev = NULL;
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index e6cf800..edcf130 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -346,7 +346,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(snd_soc_cards); i++) {
-		if (acpi_dev_present(snd_soc_cards[i].codec_id)) {
+		if (acpi_dev_found(snd_soc_cards[i].codec_id)) {
 			dev_dbg(&pdev->dev,
 				"found codec %s\n", snd_soc_cards[i].codec_id);
 			card = snd_soc_cards[i].soc_card;
diff --git a/sound/soc/intel/common/sst-match-acpi.c b/sound/soc/intel/common/sst-match-acpi.c
index 0b8ee04..e45b278 100644
--- a/sound/soc/intel/common/sst-match-acpi.c
+++ b/sound/soc/intel/common/sst-match-acpi.c
@@ -21,7 +21,7 @@ struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines)
 	struct sst_acpi_mach *mach;
 
 	for (mach = machines; mach->id[0]; mach++)
-		if (acpi_dev_present(mach->id))
+		if (acpi_dev_found(mach->id))
 			return mach;
 
 	return NULL;
-- 
1.8.5.2 (Apple Git-48)

