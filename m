From: Mark Stosberg <mark-WmyhgDpj2fCHT8/ATrE1yw@public.gmane.org>
Subject: remove HKEY disable functionality (triggers Ubuntu
 Karmic regression)
Date: Wed, 28 Oct 2009 21:58:38 -0900
Message-ID: <20091028215838.38b362ad@mark-x41>
References: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
	<1238819153-16004-8-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hello,

The following patch is involved in a regression for a number of Ubuntu Karmic
Koala users. There is apparently still a few bits of code in Ubuntu that
trigger this issue and will ultimately need to be updated. Ubuntu also has some
kind of tool that monitors for kernel warnings and reports them to users with a
scary warning: 

"Your system might become unstable now and might need to be restarted."

It seems I get this "kernel oops" warning at least once a day.

With the release of Karmic upon us, perhaps there a short term fix that 
can be made, like making the warning level less severe.

Here's a link to the Ubuntu bug report about it:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/430361

I appreciate your work on the related drivers and hope that you help us 
resolve this.

Thanks!

    Mark


On Sat,  4 Apr 2009 01:25:48 -0300
Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org> wrote:

> The HKEY disable functionality basically cripples the entire event
> model of the ThinkPad firmware and of the thinkpad-acpi driver.
> Remove this functionality from the driver.  HKEY must be enabled at
> all times while thinkpad-acpi is loaded, and disabled otherwise.
> 
> For sysfs, according to the sysfs ABI and the thinkpad-acpi sysfs
> rules of engagement, we will just remove the attributes.  This will be
> done in two stages: disable their function now, after two kernel
> releases, remove the attributes.
> 
> For procfs, we call WARN().  If nothing triggers it, I will simply
> remove the enable/disable commands entirely in the future along with
> the sysfs attributes.
> 
> I don't expect much, if any fallout from this.  There really isn't any
> reason to mess with hotkey_enable or with the enable/disable commands
> to /proc/acpi/ibm/hotkey, and this has been true for years...
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
> ---
>  Documentation/laptops/thinkpad-acpi.txt |   39 ++++++++++++------------
>  drivers/platform/x86/thinkpad_acpi.c    |   49 +++++++++++++++++--------------
>  2 files changed, 46 insertions(+), 42 deletions(-)
> 
> diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
> index e8f52fb..de6f14c 100644
> --- a/Documentation/laptops/thinkpad-acpi.txt
> +++ b/Documentation/laptops/thinkpad-acpi.txt
> @@ -179,17 +179,14 @@ system.  Enabling the hotkey functionality of thinkpad-acpi signals the
>  firmware that such a driver is present, and modifies how the ThinkPad
>  firmware will behave in many situations.
>  
> -The driver enables the hot key feature automatically when loaded.  The
> -feature can later be disabled and enabled back at runtime.  The driver
> -will also restore the hot key feature to its previous state and mask
> -when it is unloaded.
> +The driver enables the HKEY ("hot key") event reporting automatically
> +when loaded, and disables it when it is removed.
>  
> -When the hotkey feature is enabled and the hot key mask is set (see
> -below), the driver will report HKEY events in the following format:
> +The driver will report HKEY events in the following format:
>  
>  	ibm/hotkey HKEY 00000080 0000xxxx
>  
> -Some of these events refer to hot key presses, but not all.
> +Some of these events refer to hot key presses, but not all of them.
>  
>  The driver will generate events over the input layer for hot keys and
>  radio switches, and over the ACPI netlink layer for other events.  The
> @@ -221,13 +218,17 @@ procfs notes:
>  
>  The following commands can be written to the /proc/acpi/ibm/hotkey file:
>  
> -	echo enable > /proc/acpi/ibm/hotkey -- enable the hot keys feature
> -	echo disable > /proc/acpi/ibm/hotkey -- disable the hot keys feature
>  	echo 0xffffffff > /proc/acpi/ibm/hotkey -- enable all hot keys
>  	echo 0 > /proc/acpi/ibm/hotkey -- disable all possible hot keys
>  	... any other 8-hex-digit mask ...
>  	echo reset > /proc/acpi/ibm/hotkey -- restore the original mask
>  
> +The following commands have been deprecated and will cause the kernel
> +to log a warning:
> +
> +	echo enable > /proc/acpi/ibm/hotkey -- does nothing
> +	echo disable > /proc/acpi/ibm/hotkey -- returns an error
> +
>  The procfs interface does not support NVRAM polling control.  So as to
>  maintain maximum bug-to-bug compatibility, it does not report any masks,
>  nor does it allow one to manipulate the hot key mask when the firmware
> @@ -236,12 +237,9 @@ does not support masks at all, even if NVRAM polling is in use.
>  sysfs notes:
>  
>  	hotkey_bios_enabled:
> -		Returns the status of the hot keys feature when
> -		thinkpad-acpi was loaded.  Upon module unload, the hot
> -		key feature status will be restored to this value.
> +		DEPRECATED, WILL BE REMOVED SOON.
>  
> -		0: hot keys were disabled
> -		1: hot keys were enabled (unusual)
> +		Returns 0.
>  
>  	hotkey_bios_mask:
>  		Returns the hot keys mask when thinkpad-acpi was loaded.
> @@ -249,13 +247,10 @@ sysfs notes:
>  		to this value.
>  
>  	hotkey_enable:
> -		Enables/disables the hot keys feature in the ACPI
> -		firmware, and reports current status of the hot keys
> -		feature.  Has no effect on the NVRAM hot key polling
> -		functionality.
> +		DEPRECATED, WILL BE REMOVED SOON.
>  
> -		0: disables the hot keys feature / feature disabled
> -		1: enables the hot keys feature / feature enabled
> +		0: returns -EPERM
> +		1: does nothing
>  
>  	hotkey_mask:
>  		bit mask to enable driver-handling (and depending on
> @@ -1535,3 +1530,7 @@ Sysfs interface changelog:
>  
>  0x020200:	Add poll()/select() support to the following attributes:
>  		hotkey_radio_sw, wakeup_hotunplug_complete, wakeup_reason
> +
> +0x020300:	hotkey enable/disable support removed, attributes
> +		hotkey_bios_enabled and hotkey_enable deprecated and
> +		marked for removal.
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index badf471..ef6c963 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -22,7 +22,7 @@
>   */
>  
>  #define TPACPI_VERSION "0.22"
> -#define TPACPI_SYSFS_VERSION 0x020200
> +#define TPACPI_SYSFS_VERSION 0x020300
>  
>  /*
>   *  Changelog:
> @@ -1424,7 +1424,6 @@ static enum {	/* Reasons for waking up */
>  
>  static int hotkey_autosleep_ack;
>  
> -static int hotkey_orig_status;
>  static u32 hotkey_orig_mask;
>  static u32 hotkey_all_mask;
>  static u32 hotkey_reserved_mask;
> @@ -1571,9 +1570,9 @@ static int hotkey_status_get(int *status)
>  	return 0;
>  }
>  
> -static int hotkey_status_set(int status)
> +static int hotkey_status_set(bool enable)
>  {
> -	if (!acpi_evalf(hkey_handle, NULL, "MHKC", "vd", status))
> +	if (!acpi_evalf(hkey_handle, NULL, "MHKC", "vd", enable ? 1 : 0))
>  		return -EIO;
>  
>  	return 0;
> @@ -1889,6 +1888,9 @@ static ssize_t hotkey_enable_show(struct device *dev,
>  {
>  	int res, status;
>  
> +	printk_deprecated_attribute("hotkey_enable",
> +			"Hotkey reporting is always enabled");
> +
>  	res = hotkey_status_get(&status);
>  	if (res)
>  		return res;
> @@ -1901,14 +1903,17 @@ static ssize_t hotkey_enable_store(struct device *dev,
>  			    const char *buf, size_t count)
>  {
>  	unsigned long t;
> -	int res;
> +
> +	printk_deprecated_attribute("hotkey_enable",
> +			"Hotkeys can be disabled through hotkey_mask");
>  
>  	if (parse_strtoul(buf, 1, &t))
>  		return -EINVAL;
>  
> -	res = hotkey_status_set(t);
> +	if (t == 0)
> +		return -EPERM;
>  
> -	return (res) ? res : count;
> +	return count;
>  }
>  
>  static struct device_attribute dev_attr_hotkey_enable =
> @@ -1964,7 +1969,7 @@ static ssize_t hotkey_bios_enabled_show(struct device *dev,
>  			   struct device_attribute *attr,
>  			   char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%d\n", hotkey_orig_status);
> +	return sprintf(buf, "0\n");
>  }
>  
>  static struct device_attribute dev_attr_hotkey_bios_enabled =
> @@ -2243,7 +2248,7 @@ static void hotkey_exit(void)
>  			   "restoring original hot key mask\n");
>  		/* no short-circuit boolean operator below! */
>  		if ((hotkey_mask_set(hotkey_orig_mask) |
> -		     hotkey_status_set(hotkey_orig_status)) != 0)
> +		     hotkey_status_set(false)) != 0)
>  			printk(TPACPI_ERR
>  			       "failed to restore hot key mask "
>  			       "to BIOS defaults\n");
> @@ -2438,10 +2443,6 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>  
>  	/* hotkey_source_mask *must* be zero for
>  	 * the first hotkey_mask_get */
> -	res = hotkey_status_get(&hotkey_orig_status);
> -	if (res)
> -		goto err_exit;
> -
>  	if (tp_features.hotkey_mask) {
>  		res = hotkey_mask_get();
>  		if (res)
> @@ -2581,7 +2582,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>  	}
>  
>  	dbg_printk(TPACPI_DBG_INIT, "enabling hot key handling\n");
> -	res = hotkey_status_set(1);
> +	res = hotkey_status_set(true);
>  	if (res) {
>  		hotkey_exit();
>  		return res;
> @@ -2926,9 +2927,17 @@ static int hotkey_read(char *p)
>  	return len;
>  }
>  
> +static void hotkey_enabledisable_warn(void)
> +{
> +	tpacpi_log_usertask("procfs hotkey enable/disable");
> +	WARN(1, TPACPI_WARN
> +	     "hotkey enable/disable functionality has been "
> +	     "removed from the driver. Hotkeys are always enabled.\n");
> +}
> +
>  static int hotkey_write(char *buf)
>  {
> -	int res, status;
> +	int res;
>  	u32 mask;
>  	char *cmd;
>  
> @@ -2938,17 +2947,16 @@ static int hotkey_write(char *buf)
>  	if (mutex_lock_killable(&hotkey_mutex))
>  		return -ERESTARTSYS;
>  
> -	status = -1;
>  	mask = hotkey_mask;
>  
>  	res = 0;
>  	while ((cmd = next_cmd(&buf))) {
>  		if (strlencmp(cmd, "enable") == 0) {
> -			status = 1;
> +			hotkey_enabledisable_warn();
>  		} else if (strlencmp(cmd, "disable") == 0) {
> -			status = 0;
> +			hotkey_enabledisable_warn();
> +			res = -EPERM;
>  		} else if (strlencmp(cmd, "reset") == 0) {
> -			status = hotkey_orig_status;
>  			mask = hotkey_orig_mask;
>  		} else if (sscanf(cmd, "0x%x", &mask) == 1) {
>  			/* mask set */
> @@ -2959,9 +2967,6 @@ static int hotkey_write(char *buf)
>  			goto errexit;
>  		}
>  	}
> -	if (status != -1)
> -		res = hotkey_status_set(status);
> -
>  	if (!res && mask != hotkey_mask)
>  		res = hotkey_mask_set(mask);
>  


-- 
http://mark.stosberg.com/




------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
