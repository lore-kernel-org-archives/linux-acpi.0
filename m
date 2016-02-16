From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 1/2] ACPI: introduce a function to find the first physical device
Date: Tue, 16 Feb 2016 20:20:32 +0100
Message-ID: <2136886.lSJtFgotV7@vostro.rjw.lan>
References: <2019009.4Y5n3ZF6bK@vostro.rjw.lan> <1455627160-10299-1-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61010 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755485AbcBPTTL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2016 14:19:11 -0500
In-Reply-To: <1455627160-10299-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shannon Zhao <shannon.zhao@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Len Brown <lenb@kernel.org>

On Tuesday, February 16, 2016 03:52:38 PM Aleksey Makarov wrote:
> Factor out the code that finds the first physical device
> of a given ACPI device.  It is used in several places.
> 
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>

OK, I've queued up this one and the [2/2] for v4.6.

Thanks,
Rafael

