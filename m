From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/1] ACPI / scan: Create platform device for INT33FE ACPI nodes
Date: Wed, 17 Oct 2018 14:39:54 +0300
Message-ID: <CAHp75VcxnGzKbOwEDu_MSKQ1D28=pESTVm+YSHQTjrMXUaKMoA@mail.gmail.com>
References: <20181017085928.13406-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017085928.13406-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 17, 2018 at 11:59 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael, Andy,
>
> For the why and what of this patch see the (somewhat long) commit message.
>
> The single patch in this set both touches drivers/acpi/scan.c and
> drivers/platform/x86/intel_cht_int33fe.c, this is done this way to avoid
> regressions when bisecting.
>
> The main change here really is to ACPI change and intel_cht_int33fe.c is
> modified to follow suit. Also I do not expect intel_cht_int33fe.c to see
> much changes this cycle. As such I believe it would be best to merge this
> patch through Rafael's tree (after review).
>
> Andy is that ok with you and we have your ack for this?

I love this patch!

Definitely,
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!

>
> Regards,
>
> Hans
>


-- 
With Best Regards,
Andy Shevchenko
