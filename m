From: Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: Tue, 30 Mar 2004 11:42:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <4069A359.7040908@nortelnetworks.com>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com> <1080535754.16221.188.camel@dhcppc4> <20040329052238.GD1276@alpha.home.local> <1080598062.983.3.camel@dhcppc4> <1080651370.25228.1.camel@dhcp23.swansea.linux.org.uk> <Pine.LNX.4.53.0403300814350.5311@chaos> <20040330142215.GA21931@alpha.home.local> <Pine.LNX.4.53.0403300943520.6151@chaos> <20040330150949.GA22073@alpha.home.local> <Pine.LNX.4.53.0403301019570.6451@chaos> <20040330161431.GA22272@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040330161431.GA22272@alpha.home.local>
To: Willy Tarreau <willy@w.ods.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Len Brown <len.brown@intel.com>, Arkadiusz Miskiewicz <arekm@pld-linux.org>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Willy Tarreau wrote:

> In what I described, a 386 target would be compiled with -march=i386,
> but the cmpxchg() FUNCTION will still reference the cmpxchg op-code
> in the __asm__ statement, and this is perfectly valid. In this case,
> only callers of the cmpxchg() FUNCTION will have a chance to use it.
> And at the moment, the only client seems to be ACPI.

Will the assembler even let you compile the cmpxchg asm instruction if 
you're building for i386?

Chris
