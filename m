From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [patch 0/5] dev_printk() conversions
Date: Wed, 25 Jun 2008 16:07:01 -0700
Message-ID: <200806251607.01904.jbarnes@virtuousgeek.org>
References: <20080613165209.507694130@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20080613165209.507694130@ldl.fc.hp.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, June 13, 2008 9:52 am Bjorn Helgaas wrote:
> These convert some printks to dev_printks.  They are completely
> independent of each other; I'm just posting them together because
> it probably makes sense to review them together.
>
> It'd be nice if a PCI person looked at pci_request_region().  To
> me, it looks like it prints the wrong BAR number (it prints "bar + 1").

Thanks Bjorn, I applied 2-4 to my linux-next tree.  The x86 bits didn't apply 
for me, probably because my tree is slightly out of date, but those changes 
can come through Ingo & co.

Jesse
