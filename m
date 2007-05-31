From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: do not use named sysfs groups
Date: Thu, 31 May 2007 13:01:35 -0400
Message-ID: <200705311301.36027.lenb@kernel.org>
References: <1180137201942-git-send-email-hmh@hmh.eng.br> <118013720199-git-send-email-hmh@hmh.eng.br> <20070530235014.GA27491@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47943 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104AbXEaRBr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 May 2007 13:01:47 -0400
In-Reply-To: <20070530235014.GA27491@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Wednesday 30 May 2007 19:50, Henrique de Moraes Holschuh wrote:
> The initial version of the thinkpad-acpi sysfs interface (not yet released
> in any stable mainline kernel) made liberal use of named sysfs groups, in
> order to get the attributes more organized.
> 
> This proved to be a really bad design decision.  Maybe if attribute groups
> were as flexible as a real directory, and if binary attributes were not
> second-class citizens, the idea of subdirs and named groups would not have
> been so bad.
> 
> This patch makes all the thinkpad-acpi sysfs groups anonymous (thus
> removing the subdirs), adds the former group names as a prefix (so that
> hotkey/enable becomes hotkey_enable for example), and updates the
> documentation.
> 
> These changes will make the thinkpad-acpi sysfs ABI a lot easier to
> maintain.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> ---
> 
>  It gets easier to apply if I actually get git to include the patch :)
>  Sorry about that!
> 
>  Documentation/thinkpad-acpi.txt |   25 +++++++++++--------------
>  drivers/misc/thinkpad_acpi.c    |   17 +++++++----------
>  drivers/misc/thinkpad_acpi.h    |    6 ------
>  3 files changed, 18 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
> index 2d48033..9e6b94f 100644
> --- a/Documentation/thinkpad-acpi.txt
> +++ b/Documentation/thinkpad-acpi.txt
> @@ -138,7 +138,7 @@ Hot keys
>  --------
>  
>  procfs: /proc/acpi/ibm/hotkey
> -sysfs device attribute: hotkey/*
> +sysfs device attribute: hotkey_*
>  
>  Without this driver, only the Fn-F4 key (sleep button) generates an
>  ACPI event. With the driver loaded, the hotkey feature enabled and the
> @@ -196,10 +196,7 @@ The following commands can be written to the /proc/acpi/ibm/hotkey file:
>  
>  sysfs notes:
>  
> -	The hot keys attributes are in a hotkey/ subdirectory off the
> -	thinkpad device.
> -
> -	bios_enabled:
> +	hotkey_bios_enabled:
>  		Returns the status of the hot keys feature when
>  		thinkpad-acpi was loaded.  Upon module unload, the hot
>  		key feature status will be restored to this value.
> @@ -207,19 +204,19 @@ sysfs notes:
>  		0: hot keys were disabled
>  		1: hot keys were enabled
>  
> -	bios_mask:
> +	hotkey_bios_mask:
>  		Returns the hot keys mask when thinkpad-acpi was loaded.
>  		Upon module unload, the hot keys mask will be restored
>  		to this value.
>  
> -	enable:
> +	hotkey_enable:
>  		Enables/disables the hot keys feature, and reports
>  		current status of the hot keys feature.
>  
>  		0: disables the hot keys feature / feature disabled
>  		1: enables the hot keys feature / feature enabled
>  
> -	mask:
> +	hotkey_mask:
>  		bit mask to enable ACPI event generation for each hot
>  		key (see above).  Returns the current status of the hot
>  		keys mask, and allows one to modify it.
> @@ -229,7 +226,7 @@ Bluetooth
>  ---------
>  
>  procfs: /proc/acpi/ibm/bluetooth
> -sysfs device attribute: bluetooth/enable
> +sysfs device attribute: bluetooth_enable
>  
>  This feature shows the presence and current state of a ThinkPad
>  Bluetooth device in the internal ThinkPad CDC slot.
> @@ -244,7 +241,7 @@ If Bluetooth is installed, the following commands can be used:
>  Sysfs notes:
>  
>  	If the Bluetooth CDC card is installed, it can be enabled /
> -	disabled through the "bluetooth/enable" thinkpad-acpi device
> +	disabled through the "bluetooth_enable" thinkpad-acpi device
>  	attribute, and its current status can also be queried.
>  
>  	enable:
> @@ -252,7 +249,7 @@ Sysfs notes:
>  		1: enables Bluetooth / Bluetooth is enabled.
>  
>  	Note: this interface will be probably be superseeded by the
> -	generic rfkill class.
> +	generic rfkill class, so it is NOT to be considered stable yet.
>  
>  Video output control -- /proc/acpi/ibm/video
>  --------------------------------------------
> @@ -898,7 +895,7 @@ EXPERIMENTAL: WAN
>  -----------------
>  
>  procfs: /proc/acpi/ibm/wan
> -sysfs device attribute: wwan/enable
> +sysfs device attribute: wwan_enable
>  
>  This feature is marked EXPERIMENTAL because the implementation
>  directly accesses hardware registers and may not work as expected. USE
> @@ -921,7 +918,7 @@ If the W-WAN card is installed, the following commands can be used:
>  Sysfs notes:
>  
>  	If the W-WAN card is installed, it can be enabled /
> -	disabled through the "wwan/enable" thinkpad-acpi device
> +	disabled through the "wwan_enable" thinkpad-acpi device
>  	attribute, and its current status can also be queried.
>  
>  	enable:
> @@ -929,7 +926,7 @@ Sysfs notes:
>  		1: enables WWAN card / WWAN card is enabled.
>  
>  	Note: this interface will be probably be superseeded by the
> -	generic rfkill class.
> +	generic rfkill class, so it is NOT to be considered stable yet.
>  
>  Multiple Commands, Module Parameters
>  ------------------------------------
> diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
> index 6c36a55..95c0b96 100644
> --- a/drivers/misc/thinkpad_acpi.c
> +++ b/drivers/misc/thinkpad_acpi.c
> @@ -740,7 +740,7 @@ static ssize_t hotkey_enable_store(struct device *dev,
>  }
>  
>  static struct device_attribute dev_attr_hotkey_enable =
> -	__ATTR(enable, S_IWUSR | S_IRUGO,
> +	__ATTR(hotkey_enable, S_IWUSR | S_IRUGO,
>  		hotkey_enable_show, hotkey_enable_store);
>  
>  /* sysfs hotkey mask --------------------------------------------------- */
> @@ -775,7 +775,7 @@ static ssize_t hotkey_mask_store(struct device *dev,
>  }
>  
>  static struct device_attribute dev_attr_hotkey_mask =
> -	__ATTR(mask, S_IWUSR | S_IRUGO,
> +	__ATTR(hotkey_mask, S_IWUSR | S_IRUGO,
>  		hotkey_mask_show, hotkey_mask_store);
>  
>  /* sysfs hotkey bios_enabled ------------------------------------------- */
> @@ -787,7 +787,7 @@ static ssize_t hotkey_bios_enabled_show(struct device *dev,
>  }
>  
>  static struct device_attribute dev_attr_hotkey_bios_enabled =
> -	__ATTR(bios_enabled, S_IRUGO, hotkey_bios_enabled_show, NULL);
> +	__ATTR(hotkey_bios_enabled, S_IRUGO, hotkey_bios_enabled_show, NULL);
>  
>  /* sysfs hotkey bios_mask ---------------------------------------------- */
>  static ssize_t hotkey_bios_mask_show(struct device *dev,
> @@ -798,7 +798,7 @@ static ssize_t hotkey_bios_mask_show(struct device *dev,
>  }
>  
>  static struct device_attribute dev_attr_hotkey_bios_mask =
> -	__ATTR(bios_mask, S_IRUGO, hotkey_bios_mask_show, NULL);
> +	__ATTR(hotkey_bios_mask, S_IRUGO, hotkey_bios_mask_show, NULL);
>  
>  /* --------------------------------------------------------------------- */
>  
> @@ -824,8 +824,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>  		str_supported(tp_features.hotkey));
>  
>  	if (tp_features.hotkey) {
> -		hotkey_dev_attributes = create_attr_set(4,
> -						TPACPI_HOTKEY_SYSFS_GROUP);
> +		hotkey_dev_attributes = create_attr_set(4, NULL);
>  		if (!hotkey_dev_attributes)
>  			return -ENOMEM;
>  		res = add_to_attr_set(hotkey_dev_attributes,
> @@ -1050,7 +1049,7 @@ static ssize_t bluetooth_enable_store(struct device *dev,
>  }
>  
>  static struct device_attribute dev_attr_bluetooth_enable =
> -	__ATTR(enable, S_IWUSR | S_IRUGO,
> +	__ATTR(bluetooth_enable, S_IWUSR | S_IRUGO,
>  		bluetooth_enable_show, bluetooth_enable_store);
>  
>  /* --------------------------------------------------------------------- */
> @@ -1061,7 +1060,6 @@ static struct attribute *bluetooth_attributes[] = {
>  };
>  
>  static const struct attribute_group bluetooth_attr_group = {
> -	.name = TPACPI_BLUETH_SYSFS_GROUP,
>  	.attrs = bluetooth_attributes,
>  };
>  
> @@ -1215,7 +1213,7 @@ static ssize_t wan_enable_store(struct device *dev,
>  }
>  
>  static struct device_attribute dev_attr_wan_enable =
> -	__ATTR(enable, S_IWUSR | S_IRUGO,
> +	__ATTR(wwan_enable, S_IWUSR | S_IRUGO,
>  		wan_enable_show, wan_enable_store);
>  
>  /* --------------------------------------------------------------------- */
> @@ -1226,7 +1224,6 @@ static struct attribute *wan_attributes[] = {
>  };
>  
>  static const struct attribute_group wan_attr_group = {
> -	.name = TPACPI_WAN_SYSFS_GROUP,
>  	.attrs = wan_attributes,
>  };
>  
> diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
> index 440145a..72d62f2 100644
> --- a/drivers/misc/thinkpad_acpi.h
> +++ b/drivers/misc/thinkpad_acpi.h
> @@ -278,8 +278,6 @@ static int beep_write(char *buf);
>   * Bluetooth subdriver
>   */
>  
> -#define TPACPI_BLUETH_SYSFS_GROUP "bluetooth"
> -
>  enum {
>  	/* ACPI GBDC/SBDC bits */
>  	TP_ACPI_BLUETOOTH_HWPRESENT	= 0x01,	/* Bluetooth hw available */
> @@ -416,8 +414,6 @@ static int fan_write_cmd_watchdog(const char *cmd, int *rc);
>   * Hotkey subdriver
>   */
>  
> -#define TPACPI_HOTKEY_SYSFS_GROUP "hotkey"
> -
>  static int hotkey_orig_status;
>  static int hotkey_orig_mask;
>  
> @@ -553,8 +549,6 @@ static int volume_write(char *buf);
>   * Wan subdriver
>   */
>  
> -#define TPACPI_WAN_SYSFS_GROUP "wwan"
> -
>  enum {
>  	/* ACPI GWAN/SWAN bits */
>  	TP_ACPI_WANCARD_HWPRESENT	= 0x01,	/* Wan hw available */
> -- 
> 1.5.1.6
> 
