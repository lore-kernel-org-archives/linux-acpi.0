From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI: thinkpad-acpi: make the input event mode the default
Date: Sat, 14 Jul 2007 23:33:15 +0100
Message-ID: <20070714223315.GB25782@srcf.ucam.org>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <11844223341511-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:41730 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbXGNW4p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Jul 2007 18:56:45 -0400
Content-Disposition: inline
In-Reply-To: <11844223341511-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Richard Hughes <hughsient@gmail.com>

On Sat, Jul 14, 2007 at 11:12:00AM -0300, Henrique de Moraes Holschuh wrote:
> -	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> -	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> -	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> +	KEY_FN_F1,	KEY_FN_F2,	KEY_FN_F3,	KEY_SLEEP,
> +	KEY_FN_F5,	KEY_FN_F6,	KEY_FN_F7,	KEY_FN_F8,
> +	KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_SUSPEND,

Again, we have keycodes for most of these and we have the ability to 
make the driver choose the correct one by default. Why make things more 
difficult?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
