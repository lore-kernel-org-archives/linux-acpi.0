From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI/ACPI: Change dev_info() to dev_dbg() in the acpi_pci_set_power_state()
Date: Wed, 31 Jul 2013 01:31:33 +0200
Message-ID: <3509301.e8ST4r5R4A@vostro.rjw.lan>
References: <1375151550-28632-1-git-send-email-tianyu.lan@intel.com> <8048720.q4LxpIqNkE@vostro.rjw.lan> <CAErSpo7XGa+t0g3Zp+4tXwS8JdAa5UonN7rt6dSZpEmDZuXP7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:48055 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758277Ab3G3XVY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Jul 2013 19:21:24 -0400
In-Reply-To: <CAErSpo7XGa+t0g3Zp+4tXwS8JdAa5UonN7rt6dSZpEmDZuXP7w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "lan,Tianyu" <tianyu.lan@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

On Tuesday, July 30, 2013 09:40:18 AM Bjorn Helgaas wrote:
> On Tue, Jul 30, 2013 at 7:59 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday, July 30, 2013 10:32:30 AM tianyu.lan@intel.com wrote:
> >> From: Lan Tianyu <tianyu.lan@intel.com>
> >>
> >> acpi_pci_set_power_state() produces log of device power state changing.
> >> Now the log is produced by dev_info(). This seems make no sense when user
> >> doesn't open debug option. So change it to dev_dbg() and prevent kernel
> >> log from being.
> >>
> >> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=60636
> >> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> >> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> >
> > Bjorn, what do you think about this?
> 
> It's fine with me.  For information that I want in the dmesg log all
> the time, with no special action from the user, I personally avoid
> dev_dbg() because I can never figure out whether it's enabled or not.
> But I don't use the information from this printk, so it's completely
> up to you.  Just let me know what you want.  If you have other pending
> changes to this file, you can take it, or I can put it in my tree.

Yes, I have one change to this file in my queue for 3.12, so I can take this
patch.

Thanks,
Rafael


> >> ---
> >>  drivers/pci/pci-acpi.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> >> index c78cc43..fb3522957 100644
> >> --- a/drivers/pci/pci-acpi.c
> >> +++ b/drivers/pci/pci-acpi.c
> >> @@ -210,7 +210,7 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> >>       }
> >>
> >>       if (!error)
> >> -             dev_info(&dev->dev, "power state changed by ACPI to %s\n",
> >> +             dev_dbg(&dev->dev, "power state changed by ACPI to %s\n",
> >>                        acpi_power_state_string(state_conv[state]));
> >>
> >>       return error;
> >>
> > --
> > I speak only for myself.
> > Rafael J. Wysocki, Intel Open Source Technology Center.
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
