From: Stefan Seyfried <seife@suse.de>
Subject: Re: Allow userspace do something special on overtemp
Date: Thu, 12 Aug 2004 17:50:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <411B91B9.6020200@suse.de>
References: <20040811085326.GA11765@elf.ucw.cz>	<1092323945.5028.177.camel@dhcppc4> <20040812081634.532e3fc7.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268596AbUHLPxA@vger.kernel.org>
In-Reply-To: <20040812081634.532e3fc7.rddunlap@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Randy.Dunlap wrote:
> On 12 Aug 2004 11:19:05 -0400 Len Brown wrote:
> 
> | Simpler to delete the usermode call and rely on the (flexible)
> | acpid event, yes?
> | 
> |  thermal.c |   29 +----------------------------
> |  1 files changed, 1 insertion(+), 28 deletions(-)
> 
> a.  Yes, it should be more flexible than just 'overtemp'.
> 
> b.  For userspace, there are:
> 
> acpid -  http://sourceforge.net/projects/acpid/
> 
> acpi tools, like ospmd (by Andy Grover) - in CVS at
>   http://sourceforge.net/projects/acpi/
> 
> What others are there?

powersaved - http://forge.novell.com/modules/xfmod/project/?powersave
handles APM, ACPI and cpufreq
-- 
seife

"Any ideas, John?"
"Well, surrounding thems out."
