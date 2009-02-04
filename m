From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH] PCI/ACPI: move _OSC code to pci_root.c
Date: Tue, 3 Feb 2009 17:33:20 -0700
Message-ID: <20090204003320.GC23309@ldl.fc.hp.com>
References: <4987DCAC.3010009@jp.fujitsu.com> <1233703252.14203.161.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1233703252.14203.161.camel@localhost>
Sender: linux-pci-owner@vger.kernel.org
To: Andrew Patterson <andrew.patterson@hp.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>
List-Id: linux-acpi@vger.kernel.org

* Andrew Patterson <andrew.patterson@hp.com>:
> On Tue, 2009-02-03 at 14:57 +0900, Kenji Kaneshige wrote:
> > +	/* Need to ignore the bit0 in result code */
> > +	errors = *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
> > +	if (errors) {
> > +		if (errors & OSC_REQUEST_ERROR)
> > +			printk(KERN_DEBUG "_OSC request fails\n");
> > +		if (errors & OSC_INVALID_UUID_ERROR)
> > +			printk(KERN_DEBUG "_OSC invalid UUID\n");
> > +		if (errors & OSC_INVALID_REVISION_ERROR)
> > +			printk(KERN_DEBUG "_OSC invalid revision\n");
> > +		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
> > +			if (capbuf[OSC_QUERY_TYPE] & OSC_QUERY_ENABLE)
> > +				goto out_success;
> > +			printk(KERN_DEBUG "_OSC FW not grant req. control\n");
> 
> Can this be worded better? Perhaps "Firmware would not grant requested
> _OSC control"? I know this is not your code, but maybe we can fix this
> now.

Trying not to bike shed, but if you're going to change the
wording, I'd prefer to see "Firmware did not..." vs "Firmware
would not..."

Thanks.

/ac
