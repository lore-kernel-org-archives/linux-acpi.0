From: mhf@berlios.de
Subject: Re: Cause of Suspend2 resume failures on Toshiba  
	laptops
Date: Sun, 06 Mar 2005 22:28:02 +0100
Message-ID: <422B75E2.nailMW11WULN@berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: swsusp-devel@lnx.ro
Cc: acpi-devel@lists.sourceforge.net, suspend2-devel@lists.suspend2.net
List-Id: linux-acpi@vger.kernel.org

On Sunday 06 March 2005 18:34, Dumitru Ciobarcianu wrote:
> =C3=8En data de Du, 06-03-2005 la 17:46 +0100, mhf@berlios.de a=20
scris:
> > I am afraid the only effect of the patch on my Toshiba
> > L2 is that the RTC stops working, thus the rtc.ko
> > module can not be inserted (no such device).
>
> Please revert the first patch and use the second and the
> 3rd. toshiba-acpi-hack-2.diff and
> toshiba-acpi-hack-3.diff. (if you already did that i'll
> just shut up and sit in a corner :)

With 2.6.11 and swsusp-2.1.8:

I have tried a patch Bernard sent me and which improves
the situation considerably. I am now able to resume in
my test setup which is root on tempfs linked to suspended=20
reiser partition. However running of the same reiser=20
partition directly (the normal way) does hang after=20
copying kernel back, but now _without_ the GPE message.=20
Suppose it is a driver issue.  I'll figure it out and=20
report back=20

Am optimistic that the GPE issue is actually fixed :-)

The RTC problem (in the test setup) was related to a messed
up/unhandled udev installation and was _not_  due to the=20
first version of the patch. RTC OK with devfs and after
cleanup of dev directory. Got to work on testing with
udev...

OT: does 2.6 toshiba ACPI driver still require a patch to=20
work with toshset-1.66 (I had also to patch 2.4.29 so it
looks like it)

	Regards
	Michael
