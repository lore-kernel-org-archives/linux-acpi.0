From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [RFC PATCH] x86: create drivers/x86/ from drivers/misc/
Date: Sun, 30 Nov 2008 20:49:00 -0800
Message-ID: <49336CBC.5090706@oracle.com>
References: <20081128213620.2ec593d4.sfr@canb.auug.org.au> <4930307C.30106@oracle.com> <20081129083550.3c23af37.sfr@canb.auug.org.au> <alpine.LFD.2.00.0811281649001.24773@localhost.localdomain> <alpine.LFD.2.00.0811281702570.24773@localhost.localdomain> <alpine.LFD.2.00.0811281706540.24773@localhost.localdomain> <20081128223533.GA5175@uranus.ravnborg.org> <alpine.LFD.2.00.0811281819070.24773@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0811281819070.24773@localhost.localdomain>
Sender: linux-next-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <len.brown@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, x86@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Len Brown wrote:
> 
>> You move 12 files but delete 11 lines.
> 
> obj-$(CONFIG_TC1100_WMI)        += tc1100-wmi.o
> 
> was left behind by mistake.

Yes, that caused the build error that was the original posting
for this thread.

~Randy
