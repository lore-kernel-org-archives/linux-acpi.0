From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V4] ACPI / GED: unregister interrupts during shutdown
Date: Tue, 19 Dec 2017 02:42:52 +0100
Message-ID: <CAJZ5v0g0yULEwWwWooF=5qwjEmmVUoR=uFDm-WsmJd+DDtswiA@mail.gmail.com>
References: <1513125448-6509-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1513125448-6509-1-git-send-email-okaya@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 13, 2017 at 1:37 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Some GED interrupts could be pending by the time we are doing a reboot.
>
> Even though GED driver uses devm_request_irq() to register the interrupt
> handler, the handler is not being freed on time during a shutdown since
> the driver is missing a shutdown callback.
>
> If the ACPI handler is no longer available, this causes an interrupt
> storm and delays shutdown.
>
> 1. Don't use devm family of functions for IRQ registration/free
> 2. Keep track of the events since free_irq() requires the dev_id parameter
> passed into the request_irq() function.
> 3. Call free_irq() on both remove and shutdown explicitly.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Applied, thanks!
