From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] lpc_ich: Fix a 3.5 kernel regression for iTCO_wdt driver
Date: Thu, 23 Aug 2012 19:13:15 +0200
Message-ID: <20120823171315.GD9889@sortiz-mobl>
References: <1344959772-23018-1-git-send-email-feng.tang@intel.com>
 <20120822195512.GI27604@spo001.leaseweb.com>
 <20120822215543.GA1954@srcf.ucam.org>
 <20120823130814.6ba359e9@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120823130814.6ba359e9@feng-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Wim Van Sebroeck <wim@iguana.be>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Aaron Sierra <asierra@xes-inc.com>, Bob Moore <robert.moore@intel.com>, Guenter Roeck <linux@roeck-us.net>, rui.zhang@intel.com
List-Id: linux-acpi@vger.kernel.org

Hi Feng,

On Thu, Aug 23, 2012 at 01:08:14PM +0800, Feng Tang wrote:
> On Wed, 22 Aug 2012 22:55:43 +0100
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> 
> > On Wed, Aug 22, 2012 at 09:55:12PM +0200, Wim Van Sebroeck wrote:
> > 
> > > Any idea why the acpi_check_resource_conflict() check gives a conflict?
> > 
> > Because the resource range is declared in ACPI and we assume that that 
> > means the firmware wants to scribble on it. We'd need the output of 
> > acpidump to work out whether that's safe or not.
> 
> Good point, I checked the conflict for iTCO_wdt, the conflict exists on
> almost all the machines I have.
> 
> According to ICH (7/8/9 etc)spec, the TCO watchdog has a 32 bytes long IO 
> space resource, and the bit 9 of TCO1_STS register is "DMISCI_STS", which
>  indicates whether a SCI happens, and will be cleared by writing 1
> to it. Most of DSDT table will claim a TCO op region only for one bit:
> "DMISCI_STS" , as some method may need to access that bit. 
> 
> I think there is some risk, but it's quite safe as the DMISCI_STS bit has
> nothing to do with TCO driver itself, and TCO driver never access it, also
> this TCO driver has been there for years, and this resource conflict also
> exists for many generations hardware. 
Makes sense to me.
I'm queueing this one to my for-linus branch, I'll send a pull request soon.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
