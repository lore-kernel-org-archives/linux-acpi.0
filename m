From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: RE: [ACPI] Re: Cause of Suspend2 resume failures
	on Toshiba laptops
Date: Tue, 08 Mar 2005 17:55:46 +1100
Message-ID: <1110264946.32064.115.camel@desktop.cunningham.myip.net.au>
References: <16A54BF5D6E14E4D916CE26C9AD305750155EABF@pdsmsx402.ccr.corp.intel.com>
	<1110259708.32064.87.camel@desktop.cunningham.myip.net.au>
	<1110262343.8943.9.camel@sli10-desk.sh.intel.com>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110262343.8943.9.camel@sli10-desk.sh.intel.com>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Li Shaohua <shaohua.li@intel.com>
Cc: Bernard Blackham <bernard@blackham.com.au>, ACPI List <acpi-devel@lists.sourceforge.net>, Suspend2 Development <suspend2-devel@lists.suspend2.net>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Tue, 2005-03-08 at 17:12, Li Shaohua wrote:
> ACPI also disables all non-wakeup GPEs in S5. I guess the problem is we
> probably disable the GPEs too lately in swsusp2. swsusp writes image
> after GPEs are disabled, but swsusp2 isn't (Sorry, I'm not familiar with
> swsusp2, but it looks like this according to the steps you write down).

Okay. Bernard is just changing this at the moment.

> > Looking at the code, I can see that we could probably rework our support
> > a little as we're calling the prepare method immediately before powering
> > down rather than at the start of the process.
> > 
> > One question though: do you see any issues with calling prepare() and
> > finish() with the PM_DISK_PLATFORM parameter (as if entering S4 sleep)
> > when we're actually going to do an S5 powerdown? If this will allow the
> > wake events to fire (as they would for S4), it could be good for
> > machines where S4 isn't working properly..
> This possibly can't work. We must give the BIOS a correct sleep state (4
> or 5).

Ok. Since S5 enabled the GPEs, we can do what we ought to anyway :>

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de
