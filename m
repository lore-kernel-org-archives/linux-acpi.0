From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [patch] ACPI video driver output switch sysfs support
Date: Wed, 25 Apr 2007 08:31:11 -0700
Message-ID: <20070425083111.e8c24bd4.rdunlap@xenotime.net>
References: <3877989d0703122231v7bb04f03ydf4c1de03040085f@mail.gmail.com>
	<Pine.LNX.4.58.0703122231580.22327@shark.he.net>
	<3877989d0704250706x57084249nc26ace98033c22d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:44353 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031092AbXDYP1m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Apr 2007 11:27:42 -0400
Received: from midway.site ([71.245.96.31]) by xenotime.net for <linux-acpi@vger.kernel.org>; Wed, 25 Apr 2007 08:27:35 -0700
In-Reply-To: <3877989d0704250706x57084249nc26ace98033c22d0@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Wed, 25 Apr 2007 22:06:56 +0800 Luming Yu wrote:

> The update patch:
> 
> Add output switch sysfs class support for ACPI video driver.
> 
> signed-off-by: Luming Yu <Luming.yu@intel.com>
> ---
>  acpi/Kconfig   |    2 +-
>  acpi/video.c   |   40 ++++++++++++++++++++++++++++++++++++++++
>  video/Kconfig  |    7 +++++++
>  video/Makefile |    3 +++
>  4 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 8372ace..8f2c02b 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -6,6 +6,13 @@ menu "Graphics support"
> 
>  source "drivers/video/backlight/Kconfig"
> 
> +config VIDEO_OUTPUT_CONTROL
> +	tristate "Lowlevel video output switch controls"
> +	default m
> +	help
> +	This framework adds support for low-level control of the video
> +	output switch.

Please indent the 2 lines of help text (only)
with <tab><space><space>.

>From Documentation/CodingStyle:
Help text is indented with 2 spaces.

(meaning 2 spaces more than the word "help" :)

> +
>  config FB
>  	tristate "Support for frame buffer devices"
>  	---help---


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
