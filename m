From: "Yu, Ling L" <ling.l.yu@intel.com>
Subject: RE: acpi function test suite 0.1 and test results
Date: Wed, 19 Apr 2006 10:19:40 +0800
Message-ID: <D352FD896397D04482B87731BD4DBE7F411893@bjsmsx401>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:63834 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750720AbWDSCTw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2006 22:19:52 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Garry T. Williams" <gtwilliams@gmail.com>
Cc: linux-acpi@vger.kernel.org, "Zhang, Kexin" <kexin.zhang@intel.com>, "Luo, Zhenlin" <zhenlin.luo@intel.com>

>Well, I decided to try to capture some information on this failure.  So
>I shut down all my applications and tried again as root.  This time
>there was no hang -- the tests ran to completion.  I did run an update
>from Fedora update repositories before trying again.  This installed
>several updates to GNOME.  Probably not related, but who knows?
><shrug>
>
>Anyway, here's the output of the abat tests.
Thanks, I tried to use non-root to run, failed too, it seems some
commands invoked by test case need root privilege. 

>I now note that the tests apparently left my machine in a throttled
>state.  Everything was running slower than usual. 
This seems a test case bug, the throttling state need to be recovered to
normal after the test finishes.

Thanks
- Ling
