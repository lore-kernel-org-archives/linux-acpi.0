From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI: Execute the _PTS method when system reboot
Date: Mon, 04 Jul 2016 15:00:40 +0200
Message-ID: <9816457.z8EnLU3BXB@vostro.rjw.lan>
References: <1467038724-13455-1-git-send-email-hehy1@lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58363 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753500AbcGDM4H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jul 2016 08:56:07 -0400
In-Reply-To: <1467038724-13455-1-git-send-email-hehy1@lenovo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ocean HY1 He <hehy1@lenovo.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Tanaka <dtanaka@lenovo.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, Sumeet Kochar <skochar@lenovo.com>, Nagananda Chumbalkar <nchumbalkar@lenovo.com>

On Monday, June 27, 2016 02:50:16 PM Ocean HY1 He wrote:
> The _PTS control method is defined in the section 7.4.1 of acpi 6.0
> spec. The _PTS control method is executed by the OS during the sleep
> transition process for S1, S2, S3, S4, and for orderly S5 shutdown.
> 
> The _PTS control method provides the BIOS a mechanism for performing
> some housekeeping, such as writing the sleep type value to the embedded
> controller, before entering the system sleeping state. Note that some
> Lenovo Server BIOS use this mechanism to detect reboot event and
> prompt user by popped dialog box.
> 
> According to section 7.5 of acpi 6.0 spec, _PTS should run after _TTS.
> Add a _PTS evaulation to the existing _TTS reboot notifier and change
> the notifier name to reflect the fact that it's not for _TTS only any
> more.
> 
> Signed-off-by: Ocean He <hehy1@lenovo.com>
> Signed-off-by: Nagananda Chumbalkar <nchumbalkar@lenovo.com>

Applied, thanks!

