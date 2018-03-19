From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/3] ACPI: SPCR: Add support for AMD CT/SZ
Date: Mon, 19 Mar 2018 11:31:45 +0100
Message-ID: <2444014.2lujvRhnvI@aspire.rjw.lan>
References: <20180314214439.27806-1-djkurtz@chromium.org> <20180314214439.27806-3-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314214439.27806-3-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, adurbin@chromium.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, March 14, 2018 10:44:37 PM CET Daniel Kurtz wrote:
> AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a special
> earlycon setup handler to configure its input clock in order to compute
> baud rate divisor registers.
> Detect them by examining the OEMID field in the SPCR header, and pass
> then pass uart type amdcz to earlycon.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Can you possibly send the entire series again and CC all patches to linux-acpi
and fix the kbuild warnings if the are relevant for that matter?

Thanks!
