From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/1] ACPI / scan: Create platform device for BSG2150 ACPI nodes
Date: Tue, 5 Feb 2019 17:55:08 +0200
Message-ID: <CAHp75Vczx8+-Ut0mzB_weT3W6OWYKvd8L2wT+9TXZ-wSxSGToA@mail.gmail.com>
References: <20181220143451.25962-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181220143451.25962-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 20, 2018 at 4:35 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> This patch adds support for another ACPI HID which describes multiple
> i2c-clients in a single node. As such this applies on top of the recent
> patch from Andy making a similar change for INT3515 nodes:
>
> Commit a3dd034a1707 ("ACPI / scan: Create platform device for INT3515
> ACPI nodes"), which is in the platform-drivers-x86-v4.21-1 tag.
>
> As such I believe it would be best to merge this tree through the
> linux-platform-drivers-x86 tree, as was done for the INT3515 patch.
>
> Rafael, may we have your ack for merging the single line drivers/acpi
> change through the linux-platform-drivers-x86 tree?
>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko
