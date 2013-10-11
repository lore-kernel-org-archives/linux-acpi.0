From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/5] gpiolib / ACPI: move acpi_gpiochip_free_interrupts
 next to the request function
Date: Fri, 11 Oct 2013 13:00:22 +0200
Message-ID: <CACRpkdZgP9VnVSpBN2Wg4ihL4ryZXeP=ASwr6BCP=u79eg6s6g@mail.gmail.com>
References: <1381392071-21407-1-git-send-email-mika.westerberg@linux.intel.com>
	<1381392071-21407-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381392071-21407-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Grant Likely <grant.likely@secretlab.ca>, Mathias Nyman <mathias.nyman@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Rob Landley <rob@landley.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Oct 10, 2013 at 10:01 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> It makes more sense to have these functions close to each other. No
> functional changes.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

So I've applied this first patch, and I'm just waiting for Alexandre's
ACK on the remaining patches concerning gpiod so we get this
100% right.

Yours,
Linus Walleij
