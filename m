From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI: thinkpad-acpi: add input device support to hotkey subdriver
Date: Sat, 14 Jul 2007 23:31:45 +0100
Message-ID: <20070714223144.GA25782@srcf.ucam.org>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <11844223334107-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:41159 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbXGNWup (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Jul 2007 18:50:45 -0400
Content-Disposition: inline
In-Reply-To: <11844223334107-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Richard Hughes <hughsient@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Sat, Jul 14, 2007 at 11:11:59AM -0300, Henrique de Moraes Holschuh wrote:

> +static u16 hotkey_keycode_map[] = {
> +	/* Scan Codes 0x00 to 0x0B: ACPI HKEY FN+F1..F12 */
> +	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> +	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> +	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> +	/* Scan codes 0x0C to 0x0F: Other ACPI HKEY hot keys */
> +	KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
> +	KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
> +	KEY_UNKNOWN,	/* 0x0E: FN+DELETE */
> +	KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */

KEY_BRIGHTNESSUP

> +	/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
> +	KEY_RESERVED,	/* 0x10: FN+END (brightness down) */

KEY_BRIGHTNESSDOWN

> +	KEY_RESERVED,	/* 0x11: FN+PGUP (thinklight toggle) */
> +	KEY_UNKNOWN,	/* 0x12: FN+PGDOWN */
> +	KEY_ZOOM,	/* 0x13: FN+SPACE (zoom) */
> +	KEY_RESERVED,	/* 0x14: VOLUME UP */

KEY_VOLUMEUP

> +	KEY_RESERVED,	/* 0x15: VOLUME DOWN */

KEY_VOLUMEDOWN

> +	KEY_RESERVED,	/* 0x16: MUTE */

KEY_MUTE

Why aren't we setting these sensibly?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
