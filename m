From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] pci: fix unavailable irq number 255 reported by BIOS
Date: Mon, 25 Jan 2016 20:05:25 -0800
Message-ID: <20160126040525.GA15074@roeck-us.net>
References: <1453705178-27389-1-git-send-email-chen.fan.fnst@cn.fujitsu.com>
 <20160125205803.GA10272@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160125205803.GA10272@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chen Fan <chen.fan.fnst@cn.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, izumi.taku@jp.fujitsu.com, wency@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, ddaney.cavm@gmail.com, okaya@codeaurora.org, bhelgaas@google.com, jiang.liu@linux.int
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 25, 2016 at 02:58:04PM -0600, Bjorn Helgaas wrote:
> [+cc Thomas]
> 
[ ... ]

> 
> I don't like the x86 ifdef.  I'd prefer:
> 
>   static inline bool irq_valid(unsigned int irq)
>   {
>     if (irq < NR_IRQS)
>       return true;
>     return false;
>   }
> 

Or:

static inline bool irq_valid(unsigned int irq)
{
	return irq < NR_IRQS;
}

Guenter
