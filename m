From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v8 14/22] ACPI: update ej_event interface to take acpi_device
Date: Wed, 16 Jan 2013 22:48:03 +0100
Message-ID: <2332793.JffINKpypu@vostro.rjw.lan>
References: <1357944049-29620-1-git-send-email-yinghai@kernel.org> <2146678.ZYzAqhqxN1@vostro.rjw.lan> <CAE9FiQW8bNs3_nV1QbDMFwxCwEy2a-1x2vi=FQ9raCYpbmnu4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQW8bNs3_nV1QbDMFwxCwEy2a-1x2vi=FQ9raCYpbmnu4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, January 16, 2013 11:37:40 AM Yinghai Lu wrote:
> On Wed, Jan 16, 2013 at 6:05 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> > acpi_power_transition() has to check if the device is power-manageable, since
> > otherwise the power resources lists will not be initialized.  It should be
> > fixed now.
> 
> yes, it works now with pm/linux-next.

Cool, thanks for testing!

> will resend updated patchset after new acpi-scan get into pci/next.

I'll put the new patches into acpi-scan tomorrow.  After that it's up to Bjorn
to decide when to pull them.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
