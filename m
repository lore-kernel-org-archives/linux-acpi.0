From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH][tentative] PCI / ACPI: Rework PCI host bridge removal to
 avoid sysfs warnings
Date: Wed, 8 Jan 2014 15:41:52 -0800
Message-ID: <CAE9FiQXYskZcfccVO6OacYchfA=cd0Ns9EF1CbwERS7MR05bUA@mail.gmail.com>
References: <37552283.kG1L4S8Daa@vostro.rjw.lan>
	<2459491.HIKjAnF27k@vostro.rjw.lan>
	<CAE9FiQV1tui+nHMFF419dpTOKt_x4US6R=3uPhDvUDJ0zoMrEg@mail.gmail.com>
	<4679785.iPCX7mECEL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4679785.iPCX7mECEL@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 6, 2014 at 12:41 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

>> Not sure how that could happen.
>>
>> If it would really happen, we could set dev->match_driver to 0 in pci_stop_dev.
>
> Simply, run "modprobe -r driver && modprobe driver" in a loop and
> remove the PCI host bridge the given device is on in parallel to that.  Chances
> are, you'll see some nice breakage.

I would suggest using match_driver prevent driver from attaching again.

---
 drivers/pci/remove.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/pci/remove.c
===================================================================
--- linux-2.6.orig/drivers/pci/remove.c
+++ linux-2.6/drivers/pci/remove.c
@@ -11,6 +11,7 @@ static void pci_stop_dev(struct pci_dev
         pci_proc_detach_device(dev);
         pci_remove_sysfs_dev_files(dev);
         device_release_driver(&dev->dev);
+        dev->match_driver = false;
         dev->is_added = 0;
     }


>
> Also what happens if somebody uses the "remove" sysfs attribute on a device
> needed by ioapic/dmar?

Good question, we will have problem in that case.
To make it simple, we may hide the "remove" in sysfs for ioapic pci device ?

Thanks

Yinghai
