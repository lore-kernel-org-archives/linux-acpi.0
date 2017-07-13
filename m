From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 7/7] device property: Constify fwnode property API
Date: Thu, 13 Jul 2017 10:07:56 -0500
Message-ID: <CAL_JsqLUjW3UUA9_DO-PY7DSf+_bpphp=YEcL3YK-kQSKcw2CA@mail.gmail.com>
References: <1499952427-16130-1-git-send-email-sakari.ailus@linux.intel.com> <1499952427-16130-8-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751339AbdGMPIS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Jul 2017 11:08:18 -0400
In-Reply-To: <1499952427-16130-8-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>, Frank Rowand <frowand.list@gmail.com>

On Thu, Jul 13, 2017 at 8:27 AM, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> Make fwnode arguments to the fwnode property API const.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c  | 52 +++++++++++++++++++++++----------------
>  drivers/base/property.c  | 64 ++++++++++++++++++++++++++----------------------
>  drivers/of/property.c    | 34 +++++++++++++------------
>  include/linux/acpi.h     | 20 ++++++++-------
>  include/linux/fwnode.h   | 26 +++++++++++---------
>  include/linux/property.h | 63 ++++++++++++++++++++++++-----------------------
>  6 files changed, 142 insertions(+), 117 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
