From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 1/2] Revert "ACPI / button: Remove lid_init_state=method
 mode"
Date: Thu, 11 May 2017 00:58:33 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CEA1260@SHSMSX101.ccr.corp.intel.com>
References: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
 <20170510161240.13229-2-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55771 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751633AbdEKA6h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 May 2017 20:58:37 -0400
In-Reply-To: <20170510161240.13229-2-benjamin.tissoires@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Jiri Eischmann <jeischma@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Benjiamin

> From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> Sent: Thursday, May 11, 2017 12:13 AM
> To: Rafael J . Wysocki <rjw@rjwysocki.net>; Zheng, Lv <lv.zheng@intel.com>
> Cc: Jiri Eischmann <jeischma@redhat.com>; linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 1/2] Revert "ACPI / button: Remove lid_init_state=method mode"
> 
> This reverts commit ecb10b694b72ca5ea51b3c90a71ff2a11963425a.
> 
> Even if the method can be buggy some times, it's still a need
> when you boot a laptop with a lid closed and an external monitor
> connected (typical situation when using a docking station)
> 
> Note: this option has been removed without being deprecated, which
> is terrible in term of distribution handling. The new default "open"
> is plain wrong and we don't even have the chance to keep the current
> default option because it's not there anymore.

I have reverted this:
https://patchwork.kernel.org/patch/9717109/

Also I noticed one thing:
https://patchwork.kernel.org/patch/9717111/

After I changed kernel lid notification to always send lid return value to other drivers.
In order to find out a single driver mode (without platform quirks) to handle both cases.
I failed.
I should still send close init state to the user space program to work around the external monitor issues.

So as you know, we need to send "open" init state to the user space program to work around suspend/resume loop issue.

Then for such platforms, how can ACPI button driver automatically detect if an external monitor is there?
Unless we fix the BIOS code to make lid return value work as user space's expectation.
OK, then this creates an endless business in ACPI community to "re-develop" BIOS tables if they cannot meat user space's expectation.
That sucks.

It sound the best way is the user space program equipped with hwdb quirks who knows everything to alter acpi button driver mode from user space to work around this.
For example:

If hwdb is hit, and there is no external monitor, then
 Echo "open" > /sys/module/button/parameters/lid_init_state
If hwdb is not hit or there is an external monitor, then
If hwdb is hit, and there is no external monitor, then
 Echo "close" > /sys/module/button/parameters/lid_init_state

So PATCH 2 is not useful.
Reverting that can trigger a regression loop we surely do not want to handle.

Thanks and best regards
Lv

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  Documentation/acpi/acpi-lid.txt | 16 ++++++++++++----
>  drivers/acpi/button.c           |  9 +++++++++
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.txt
> index 22cb309..effe7af 100644
> --- a/Documentation/acpi/acpi-lid.txt
> +++ b/Documentation/acpi/acpi-lid.txt
> @@ -59,20 +59,28 @@ button driver uses the following 3 modes in order not to trigger issues.
>  If the userspace hasn't been prepared to ignore the unreliable "opened"
>  events and the unreliable initial state notification, Linux users can use
>  the following kernel parameters to handle the possible issues:
> -A. button.lid_init_state=open:
> +A. button.lid_init_state=method:
> +   When this option is specified, the ACPI button driver reports the
> +   initial lid state using the returning value of the _LID control method
> +   and whether the "opened"/"closed" events are paired fully relies on the
> +   firmware implementation.
> +   This option can be used to fix some platforms where the returning value
> +   of the _LID control method is reliable but the initial lid state
> +   notification is missing.
> +   This option is the default behavior during the period the userspace
> +   isn't ready to handle the buggy AML tables.
> +B. button.lid_init_state=open:
>     When this option is specified, the ACPI button driver always reports the
>     initial lid state as "opened" and whether the "opened"/"closed" events
>     are paired fully relies on the firmware implementation.
>     This may fix some platforms where the returning value of the _LID
>     control method is not reliable and the initial lid state notification is
>     missing.
> -   This option is the default behavior during the period the userspace
> -   isn't ready to handle the buggy AML tables.
> 
>  If the userspace has been prepared to ignore the unreliable "opened" events
>  and the unreliable initial state notification, Linux users should always
>  use the following kernel parameter:
> -B. button.lid_init_state=ignore:
> +C. button.lid_init_state=ignore:
>     When this option is specified, the ACPI button driver never reports the
>     initial lid state and there is a compensation mechanism implemented to
>     ensure that the reliable "closed" notifications can always be delievered
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 668137e..6d5a8c1 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -57,6 +57,7 @@
> 
>  #define ACPI_BUTTON_LID_INIT_IGNORE	0x00
>  #define ACPI_BUTTON_LID_INIT_OPEN	0x01
> +#define ACPI_BUTTON_LID_INIT_METHOD	0x02
> 
>  #define _COMPONENT		ACPI_BUTTON_COMPONENT
>  ACPI_MODULE_NAME("button");
> @@ -376,6 +377,9 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
>  	case ACPI_BUTTON_LID_INIT_OPEN:
>  		(void)acpi_lid_notify_state(device, 1);
>  		break;
> +	case ACPI_BUTTON_LID_INIT_METHOD:
> +		(void)acpi_lid_update_state(device);
> +		break;
>  	case ACPI_BUTTON_LID_INIT_IGNORE:
>  	default:
>  		break;
> @@ -559,6 +563,9 @@ static int param_set_lid_init_state(const char *val, struct kernel_param *kp)
>  	if (!strncmp(val, "open", sizeof("open") - 1)) {
>  		lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
>  		pr_info("Notify initial lid state as open\n");
> +	} else if (!strncmp(val, "method", sizeof("method") - 1)) {
> +		lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
> +		pr_info("Notify initial lid state with _LID return value\n");
>  	} else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
>  		lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
>  		pr_info("Do not notify initial lid state\n");
> @@ -572,6 +579,8 @@ static int param_get_lid_init_state(char *buffer, struct kernel_param *kp)
>  	switch (lid_init_state) {
>  	case ACPI_BUTTON_LID_INIT_OPEN:
>  		return sprintf(buffer, "open");
> +	case ACPI_BUTTON_LID_INIT_METHOD:
> +		return sprintf(buffer, "method");
>  	case ACPI_BUTTON_LID_INIT_IGNORE:
>  		return sprintf(buffer, "ignore");
>  	default:
> --
> 2.9.3

