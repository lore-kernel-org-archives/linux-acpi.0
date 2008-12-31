From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] video: always update the brightness when poking "brightness"
Date: Wed, 31 Dec 2008 02:01:46 +0000
Message-ID: <20081231020146.GA24861@srcf.ucam.org>
References: <1230088058.562.219.camel@rzhang-dt> <1230633250.5328.8.camel@dax.rpnet.com> <1230687781.562.249.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56467 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbYLaCBw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Dec 2008 21:01:52 -0500
Content-Disposition: inline
In-Reply-To: <1230687781.562.249.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, Dec 31, 2008 at 09:43:01AM +0800, Zhang Rui wrote:

> then how about this case:
> =EF=BB=BF1. set the brightness level to 5 via sysfs I/F
> 2. set the backlight to another level via HOTKEYS.
> 3. setting it back to 5 doesn't work because bd->props.brightness
> is still 5.

If they're using the ACPI interface then video.c should update=20
props.brightness itself.

> IMO, the real problem is that bd->props.brightness doesn't reflect th=
e
> actual brightness.

If you want the actual brightness, why aren't you reading=20
actual_brightness?

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
