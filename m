From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2 2/3] dell-wmi: Support new hotkeys on the XPS 13 9350
 (Skylake)
Date: Fri, 4 Dec 2015 10:03:46 +0100
Message-ID: <20151204090346.GO10982@pali>
References: <cover.1448931589.git.luto@kernel.org>
 <d9ff5adc7e496b7714202785f8279af313bbcc59.1448931589.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35553 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335AbbLDJDt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2015 04:03:49 -0500
Content-Disposition: inline
In-Reply-To: <d9ff5adc7e496b7714202785f8279af313bbcc59.1448931589.git.luto@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>

On Monday 30 November 2015 17:02:00 Andy Lutomirski wrote:
> +		/*
> +		 * Check if we've already found this scancode.  This takes
> +		 * quadratic time, but it doesn't matter unless the list
> +		 * of extra keys gets very long.
> +		 */
> +		for (j =3D 0; j < num_bios_keys; j++)
> +			if (keymap[j].code =3D=3D dell_wmi_extra_keymap[i].code)
> +				goto skip;
> +

Still, my comment about moving this loop into function is valid...

> +		keymap[pos] =3D dell_wmi_extra_keymap[i];
> +		pos++;
> +
> +skip:
> +		;
>  	}

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
