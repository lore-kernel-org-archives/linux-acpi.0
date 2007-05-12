From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [announce] Intel announces the PowerTOP utility for Linux
Date: Sat, 12 May 2007 22:12:43 +0100
Message-ID: <200705122212.43653.s0348365@sms.ed.ac.uk>
References: <4644F726.1050806@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758020AbXELVM6@vger.kernel.org>
In-Reply-To: <4644F726.1050806@linux.intel.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Saturday 12 May 2007 00:07:18 Arjan van de Ven wrote:
> What's eating the battery life of my laptop? Why isn't it many more
> hours? Which software component causes the most power to be burned?
> These are important questions without a good answer... until now.

This is a really great tool and presents a very intuitive alternative to the 
timer stats file..

On a Core 2 Duo Macbook, Linux always gets around 3.2h battery, OS X about 
4.2h. This tool has identified that uhci_hcd is where 75% of the ticks are 
going when X is not loaded. Unloading uhci_hcd drops the battery life back to 
around 4.2h, but I lose the keyboard.

Is there any way to find out what USB driver is causing usb_uhci to be this 
busy?

(BTW, the link to Keith's patch for dhcdbd seems to be broken on your 
homepage.)

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
