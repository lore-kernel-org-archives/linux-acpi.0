From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
Date: Tue, 3 Jul 2018 20:41:00 +0300
Message-ID: <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Ray Jui <ray.jui@broadcom.com>, vladimir.olovyannikov@broadcom.com, vikram.prakash@broadcom.com, scott.branden@broadcom.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 3, 2018 at 12:22 PM, Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
> This patch provides a function, to get of_device_id after
> matching with ACPI device _DSD object compatible property
> in the case driver does not contain acpi_device_id list
> and driver probe called for ACPI device ID PRP0001 with
> compatible property match with of_device_id compatible.

I don't see any usefulness of this function. Care to provide a real use case?

-- 
With Best Regards,
Andy Shevchenko
