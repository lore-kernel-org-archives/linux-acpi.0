From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.19 and up to 2.6.20-rc2 Ethernet problems x86_64
Date: Wed, 3 Jan 2007 01:17:31 -0500
Message-ID: <200701030117.31737.lenb@kernel.org>
References: <459A7D46.5000509@blueyonder.co.uk> <200701021159.24945.lenb@kernel.org> <459AE34D.8040709@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <459AE34D.8040709@blueyonder.co.uk>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: g3vbv@blueyonder.co.uk
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


> ..same problem with 2.6.20-rc3. Last worked with 
> 2.6.19-rc6-git12, so it was 2.6.19 where it failed.


> Attaching both case1 normal, case2 acpi=noirq. With acpi=noirq ethernet 
> doesn't get configured, route -n says it's an Unsupported operation, 
> ifconfig only shows for localhost, ifconfig eth0 192.168.10.5 also 
> complains of a config error.

It seems that the "acpi=noirq" (and probably also the acpi=off) case
is simply an additional broken case, not a success case to compare to.

The thing we really want to compare is dmesg and /proc/interrupts
from 2.6.19-rc6-git12, and the broken current release.
Perhaps you can put that info in the bug report when you file it.

thanks,
-Len

