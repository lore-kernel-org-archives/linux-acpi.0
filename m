From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 3/4] gpio / ACPI: get rid of acpi_gpio.h
Date: Wed, 8 Jan 2014 12:56:15 +0100
Message-ID: <CACRpkdbvpJN9FaUF9HQtaA0Kjn9FbCYVTyQegOW9DM-rKVq9ag@mail.gmail.com>
References: <1389177657-29266-1-git-send-email-mika.westerberg@linux.intel.com>
	<1389177657-29266-4-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33768 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850AbaAHL4Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jan 2014 06:56:16 -0500
Received: by mail-ob0-f178.google.com with SMTP id uz6so1564213obc.37
        for <linux-acpi@vger.kernel.org>; Wed, 08 Jan 2014 03:56:16 -0800 (PST)
In-Reply-To: <1389177657-29266-4-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Rhyland Klein <rklein@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Rob Landley <rob@landley.net>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jan 8, 2014 at 11:40 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> Now that all users of acpi_gpio.h have been moved to use either the GPIO
> descriptor interface or to the internal gpiolib.h we can get rid of
> acpi_gpio.h entirely.
>
> Once this is done the only interface to get GPIOs to drivers enumerated
> from ACPI namespace is the descriptor based interface.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Patch applied.

Yours,
Linus Walleij
