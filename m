From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: 2.6.25-rc2 System no longer powers off after
	suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 12:09:03 -0800
Message-ID: <200802201209.03807.jesse.barnes@intel.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<b6a2187b0802201110k6e6c458dg6f48c586fff6187a@mail.gmail.com>
	<200802201118.08468.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200802201118.08468.jesse.barnes@intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, February 20, 2008 11:18 am Jesse Barnes wrote:
> On Wednesday, February 20, 2008 11:10 am Jeff Chua wrote:
> > On Feb 21, 2008 2:53 AM, Jesse Barnes <jesse.barnes@intel.com> wrote:
> > > > So, next I'll try "shutdown" to see if it work. I was using
> > > > "platform".
> > >
> > > Ok, that would be good to try.
> >
> > "shutdown" does power down properly. But still green on resume.
>
> Ok, so Linus' theory about something later in the resume path trying to
> touch video is looking good.
>
> Rafael, is there anyway to prevent the device shutdown in the hibernate
> path?

Given the way the PM core works, do we need to set a flag like this?  I really 
hope there's a better way of doing this...

Thanks,
Jesse

diff --git a/drivers/char/drm/i915_drv.c b/drivers/char/drm/i915_drv.c
index 4048f39..a2d6242 100644
--- a/drivers/char/drm/i915_drv.c
+++ b/drivers/char/drm/i915_drv.c
@@ -238,6 +238,13 @@ static void i915_restore_vga(struct drm_device *dev)
 
 }
 
+/*
+ * If we're doing a suspend to disk, we don't want to power off the device.
+ * Unfortunately, the PM core doesn't tell us if we're headed for a regular
+ * S3 state or that it's about to shut down the machine, so we use this flag.
+ */
+static int i915_hibernate;
+
 static int i915_suspend(struct drm_device *dev, pm_message_t state)
 {
 	struct drm_i915_private *dev_priv = dev->dev_private;
@@ -252,6 +259,9 @@ static int i915_suspend(struct drm_device *dev, 
pm_message_t state)
 	if (state.event == PM_EVENT_PRETHAW)
 		return 0;
 
+	if (state.event == PM_EVENT_FREEZE)
+		i915_hibernate = 1;
+
 	pci_save_state(dev->pdev);
 	pci_read_config_byte(dev->pdev, LBB, &dev_priv->saveLBB);
 
@@ -366,7 +376,7 @@ static int i915_suspend(struct drm_device *dev, 
pm_message_t state)
 
 	i915_save_vga(dev);
 
-	if (state.event == PM_EVENT_SUSPEND) {
+	if (!i915_hibernate) {
 		/* Shut down the device */
 		pci_disable_device(dev->pdev);
 		pci_set_power_state(dev->pdev, PCI_D3hot);
@@ -385,6 +395,8 @@ static int i915_resume(struct drm_device *dev)
 	if (pci_enable_device(dev->pdev))
 		return -1;
 
+	i915_hibernate = 0;
+
 	pci_write_config_byte(dev->pdev, LBB, dev_priv->saveLBB);
 
 	/* Pipe & plane A info */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
