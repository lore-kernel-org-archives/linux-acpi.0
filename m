From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [ACPI] Problems with Swsusp2
Date: Mon, 07 Mar 2005 19:39:49 +1100
Message-ID: <1110184789.23356.4.camel@desktop.cunningham.myip.net.au>
References: <422B75E2.nailMW11WULN@berlios.de>
	<200503070804.21841.timo.a.vuorela@tut.fi>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200503070804.21841.timo.a.vuorela@tut.fi>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-users>,
	<mailto:suspend2-users-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-users.html>
List-Post: <mailto:suspend2-users@lists.suspend2.net>
List-Help: <mailto:suspend2-users-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-users>,
	<mailto:suspend2-users-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-users-bounces@lists.suspend2.net
Errors-To: suspend2-users-bounces@lists.suspend2.net
To: Timo Vuorela <timo.a.vuorela@tut.fi>
Cc: Suspend2 Users <suspend2-users@lists.suspend2.net>, ACPI List <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi Timo.

The correctly list for Suspend2 is suspend2-users@lists.suspend2.net.
You might like to subscribe and remove the ACPI list from any reply.

On Mon, 2005-03-07 at 17:04, Timo Vuorela wrote: 
> Hi,
> 
> I have succesfully been able to suspend but sometimes something goes terribly 
> wrong: when I boot my it runs some checks on my harddisk and doesn't boot, 
> says I have to run reiserfschk --rebuild-tree to correct errors. What I'm 
> doing wrong? Has it anything to do with booting sometimes with noresume2 
> option if I don't want to continue my resumed session?

This may happen if you suspend, then boot with another kernel, and
resume with the original one. Unfortunately there's no way for us to
warn you when this happens - we just have to wait for more distributions
to include suspend-to-disk support.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de
