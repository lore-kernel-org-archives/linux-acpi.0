From: Alex Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH] gpio / ACPI: return -ENOENT when no mapping exists
Date: Tue, 10 Dec 2013 20:11:59 +0900
Message-ID: <52A6F6FF.7020103@nvidia.com>
References: <1386669627-31365-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1386669627-31365-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/10/2013 07:00 PM, Mika Westerberg wrote:
> Doing this allows drivers to distinguish between a real error case (if
> there was an error when we tried to resolve the GPIO) and when the optional
> GPIO line was not available.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!

Acked-by: Alexandre Courbot <acourbot@nvidia.com>

