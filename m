From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: register input device
Date: Sat, 26 May 2007 23:35:03 -0400
Message-ID: <200705262335.03978.dtor@insightbb.com>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <11802006651698-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:6893 "EHLO
	asav06.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbXE0De4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 May 2007 23:34:56 -0400
In-Reply-To: <11802006651698-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org

Hi,

On Saturday 26 May 2007 13:31, Henrique de Moraes Holschuh wrote:
> Register an input device to send input events to userspace.
> 
> This patch is based on a patch by Richard Hughes <hughsient@gmail.com>.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Richard Hughes <hughsient@gmail.com>

Looks OK, however I am curious why you split registration and generating
input events into 2 patches...
 
> ---
>  drivers/misc/thinkpad_acpi.c |   31 +++++++++++++++++++++++++++++--
>  drivers/misc/thinkpad_acpi.h |    3 +++
>  2 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
> index e1c84e3..c0b8155 100644
> --- a/drivers/misc/thinkpad_acpi.c
> +++ b/drivers/misc/thinkpad_acpi.c
> @@ -487,13 +487,14 @@ static char *next_cmd(char **cmds)
>  /****************************************************************************
>   ****************************************************************************
>   *
> - * Device model: hwmon and platform
> + * Device model: input, hwmon and platform
>   *
>   ****************************************************************************
>   ****************************************************************************/
>  
>  static struct platform_device *tpacpi_pdev = NULL;
>  static struct class_device *tpacpi_hwmon = NULL;
> +static struct input_dev *tpacpi_inputdev = NULL;
>  

Why do you initialize static variables?  They are guaranteed to be 0/NULL.

-- 
Dmitry
