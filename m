From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 0/10] Fixes and API additions for firmware nodes
Date: Tue, 30 Jun 2015 17:32:56 +0200
Message-ID: <1941489.kUW5F8q9QD@vostro.rjw.lan>
References: <1435676108-20590-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59209 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752134AbbF3PGk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jun 2015 11:06:40 -0400
In-Reply-To: <1435676108-20590-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, devel@acpica.org

On Tuesday, June 30, 2015 04:54:58 PM Tomeu Vizoso wrote:
> Hi,
> 
> this series makes it possible to extract device dependencies from firmware data
> with fwnode, thus not depending on the particular format of that data.
> 
> The first patches are about making sure that we can reach the fwnode
> handle of the firmware data associated with a given device, and the rest
> add API that makes dependency extraction possible.

It would really help if you sent the whole series to linux-acpi.  People on
that list would see the entire context then.

Thanks,
Rafael

