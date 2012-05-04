From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [Resend PATCH V2 1/7] ACPI: Add _PLD support
Date: Fri, 4 May 2012 08:18:28 +0200
Message-ID: <201205040818.28909.oneukum@suse.de>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com> <1336100803-28353-2-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43288 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859Ab2EDGqi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 May 2012 02:46:38 -0400
In-Reply-To: <1336100803-28353-2-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com, Matthew Garrett <mjg@redhat.com>

Am Freitag, 4. Mai 2012, 05:06:37 schrieb Lan Tianyu:

> +struct acpi_pld {
> +	unsigned int revision:7; /* 0 */
> +	unsigned int ignore_colour:1; /* 7 */
> +	unsigned int colour:24; /* 8 */
> +	unsigned int width:16; /* 32 */
> +	unsigned int height:16; /* 48 */
> +	unsigned int user_visible:1; /* 64 */
> +	unsigned int dock:1; /* 65 */
> +	unsigned int lid:1; /* 66 */
> +	unsigned int panel:3; /* 67 */
> +	unsigned int vertical_pos:2; /* 70 */
> +	unsigned int horizontal_pos:2; /* 72 */
> +	unsigned int shape:4; /* 74 */
> +	unsigned int group_orientation:1; /* 78 */
> +	unsigned int group_token:8; /* 79 */
> +	unsigned int group_position:8; /* 87 */
> +	unsigned int bay:1; /* 95 */
> +	unsigned int ejectable:1; /* 96 */
> +	unsigned int ospm_eject_required:1; /* 97 */
> +	unsigned int cabinet_number:8; /* 98 */
> +	unsigned int card_cage_number:8; /* 106 */
> +	unsigned int reference:1; /* 114 */
> +	unsigned int rotation:4; /* 115 */
> +	unsigned int order:5; /* 119 */
> +	unsigned int reserved:4; /* 124 */
> +	unsigned int vertical_offset:16; /* 128 */
> +	unsigned int horizontal_offset:16; /* 144 */
> +};

Doesn't this require a __packed__ attribute?

	Regards
		Oliver
