From: Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH] leds: leds-gpio: Convert gpio_blink_set() to use GPIO
 descriptors
Date: Tue, 4 Nov 2014 12:10:41 +0900
Message-ID: <545843B1.3020101@nvidia.com>
References: <1414755658-96293-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12311 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbaKDDLE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2014 22:11:04 -0500
In-Reply-To: <1414755658-96293-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 10/31/2014 08:40 PM, Mika Westerberg wrote:
> Commit 21f2aae91e902aad ("leds: leds-gpio: Add support for GPIO
> descriptors") already converted most of the driver to use GPIO descriptors.
> What is still missing is the platform specific hook gpio_blink_set() and
> board files which pass legacy GPIO numbers to this driver in platform data.
>
> In this patch we handle the former and convert gpio_blink_set() to take
> GPIO descriptor instead. In order to do this we convert the existing four
> users to accept GPIO descriptor and translate it to legacy GPIO number in
> the platform code. This effectively "pushes" legacy GPIO number usage from
> the driver to platforms.
>
> Also add comment to the remaining block describing that it is legacy code
> path and we are getting rid of it eventually.
>
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
