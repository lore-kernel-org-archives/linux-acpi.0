From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 01/13] ACPI: thinkpad-acpi: BIOS backlight mode helper
 (v2)
Date: Fri, 11 Apr 2008 17:26:38 -0700
Message-ID: <20080411172638.96d5a947.randy.dunlap@oracle.com>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
	<1207799585-10112-2-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:11125 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758537AbYDLA2L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Apr 2008 20:28:11 -0400
In-Reply-To: <1207799585-10112-2-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>

On Thu, 10 Apr 2008 00:52:53 -0300 Henrique de Moraes Holschuh wrote:

>  Documentation/laptops/thinkpad-acpi.txt |   49 +++++++
>  drivers/misc/thinkpad_acpi.c            |  238 +++++++++++++++++--------------
>  2 files changed, 182 insertions(+), 105 deletions(-)
> 
> diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
> index 76cb428..bbc8275 100644
> --- a/Documentation/laptops/thinkpad-acpi.txt
> +++ b/Documentation/laptops/thinkpad-acpi.txt
> @@ -571,6 +571,46 @@ netlink interface and the input layer interface, and don't bother at all
>  with hotkey_report_mode.
>  
>  
> +Brightness hotkey notes:
> +
> +These are the current sane choices for brightness key mapping in
> +thinkpad-acpi:
> +
> +For IBM and Lenovo models *without* ACPI backlight control (the ones on
> +which thinkpad-acpi will autoload its backlight interface by default,
> +and on which ACPI video does not export a backlight interface):
> +
> +1. Don't enable or map the brightness hotkeys in thinkpad-acpi, as
> +   these older firmware versions unfortunately won't respect the hotkey
> +   mask for brightness keys anyway, and always reacts to them.  This
> +   usually work fine, unless X.org is doing something to block the BIOS.

X.org is an organization AFAIK.  Please use something like
"X.org drivers" or "X.org video drivers" when that it what is meant.

> +   In that case, use (3) below.  This is the default mode of operation.
> +
> +2. Enable the hotkeys, but map them to something else that is NOT
> +   KEY_BRIGHTNESS_UP/DOWN or any other keycode that would cause
> +   userspace to try to change the backlight level, and use that as an
> +   on-screen-display hint.
> +
> +3. IF AND ONLY IF X.org finds a way to block the firmware from

ditto

> +   automatically changing the brightness, enable the hotkeys and map
> +   them to KEY_BRIGHTNESS_UP and KEY_BRIGHTNESS_DOWN, and feed that to
> +   something that calls xbacklight.  thinkpad-acpi will not be able to
> +   change brightness in that case either, so you should disable its
> +   backlight interface.


---
~Randy
