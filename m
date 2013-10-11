From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/5] gpiolib / ACPI: move acpi_gpiochip_free_interrupts
 next to the request function
Date: Fri, 11 Oct 2013 12:52:30 +0200
Message-ID: <CACRpkdb8iDpXsTLJr0mXpSHeqs2DkdBw6u+=TaerxwsA37kj2g@mail.gmail.com>
References: <1380639537-23406-1-git-send-email-mika.westerberg@linux.intel.com>
	<1380639537-23406-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380639537-23406-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Grant Likely <grant.likely@secretlab.ca>, Mathias Nyman <mathias.nyman@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Rob Landley <rob@landley.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 1, 2013 at 4:58 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> It makes more sense to have these functions close to each other. No
> functional changes.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Patch applied.

Yours,
Linus Walleij
