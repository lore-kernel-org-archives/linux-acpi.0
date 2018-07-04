From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
Date: Wed, 4 Jul 2018 12:32:21 +0300
Message-ID: <CAHp75Vef97XB-M=+xUxsGqzgPrADcUmLTLRdWE+PcVxtTQLN4g@mail.gmail.com>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
 <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com> <CABe79T7EeyzKS97zeQ5akoSaZX0=hMgHxw4XkLCQW15eRR=14Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABe79T7EeyzKS97zeQ5akoSaZX0=hMgHxw4XkLCQW15eRR=14Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>, Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Ray Jui <ray.jui@broadcom.com>, Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>, Vikram Prakash <vikram.prakash@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 4, 2018 at 6:37 AM, Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
> Hi Sudeep, Andy,
>
> Yes, This patch is to get of_device_id and then fetch data pointer.
>
> To add ACPI support in multiple drivers which are device-tree based
> and has list of of_device_ids, by using this function
> very minimal changes and can avoid acpi_device_id list in the driver.
> I will send driver changes where this function used to add ACPI
> support in following patches.
>
> Below are the changes added to add ACPI support in sdhci iproc driver
> using this function.

So, did you get an ACPI ID for it?
That's how proper ACPI support should be done.

P.S. What you are trying to do is being discussed with Nikolaus in [1].
I have to NAK your approach in any case. Sorry.

[1]:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1724366.html
(Unfortunately I don't see the original patch there by unknown reason)

-- 
With Best Regards,
Andy Shevchenko
