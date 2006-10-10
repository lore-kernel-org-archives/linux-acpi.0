From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the
	sony_acpi driver
Date: Tue, 10 Oct 2006 16:22:10 +0100
Message-ID: <1160493730.19004.1.camel@hughsie-laptop>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com>
	 <20061001171912.b7aac1d8.akpm@osdl.org>
	 <20061002132549.9d164061.alessandro.guido@gmail.com>
	 <200610102317.24310.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:5715 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750876AbWJJPWN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 11:22:13 -0400
Received: by ug-out-1314.google.com with SMTP id o38so765816ugd
        for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2006 08:22:12 -0700 (PDT)
In-Reply-To: <200610102317.24310.luming.yu@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yu Luming <luming.yu@gmail.com>
Cc: Alessandro Guido <alessandro.guido@gmail.com>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr

On Tue, 2006-10-10 at 23:17 +0800, Yu Luming wrote:
> It should be mapped to KEY_BRIGHTNESSDOWN/UP (linux/input.h)

Completely agree. Then userspace (like gnome-power-manager or
powersaved) can change the brightness based on policy and user-lockdown.

Richard.


