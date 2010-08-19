From: Ike Panhc <ike.pan@canonical.com>
Subject: Re: [PATCH 3/8] ideapad: make sure we bind on the correct device
Date: Thu, 19 Aug 2010 10:51:34 +0800
Message-ID: <4C6C9C36.7080904@canonical.com>
References: <1282120564-11324-1-git-send-email-ike.pan@canonical.com> <1282120653-11434-1-git-send-email-ike.pan@canonical.com> <20100818132722.GA12709@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20100818132722.GA12709@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Corentin Chary <corentincj@iksaif.net>, David Woodhouse <David.Woodhouse@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 08/18/2010 09:27 PM, Matthew Garrett wrote:
> On Wed, Aug 18, 2010 at 04:37:33PM +0800, Ike Panhc wrote:
>> By reading from method _STA and _CFG to make sure we bind on the correct
>> VPC2004 device.
> 
> I know some other drivers check _STA themselves, but it's unnecessary - 
> if _STA didn't evaluate appropriately, the bus driver won't create the 
> pnp object and there won't be anything for you to bind to in the first 
> place.
> 
yes, you are right. when add, acpi_bus will check for it and tell if the
device exist or not from its bits.
