From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: Tue, 30 Mar 2004 13:56:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1080651370.25228.1.camel@dhcp23.swansea.linux.org.uk>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
	 <1080535754.16221.188.camel@dhcppc4>
	 <20040329052238.GD1276@alpha.home.local>  <1080598062.983.3.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1080598062.983.3.camel@dhcppc4>
To: Len Brown <len.brown@intel.com>
Cc: Willy Tarreau <willy@w.ods.org>, Arkadiusz Miskiewicz <arekm@pld-linux.org>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Llu, 2004-03-29 at 23:07, Len Brown wrote:
> Linux uses this locking mechanism to coordinate shared access
> to hardware registers with embedded controllers,
> which is true also on uniprocessors too.

If the ACPI layer simply refuses to run on a CPU without cmpxchg
then I can't see there being a problem, there don't appear to be
any 386 processors with ACPI
