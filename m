From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: RE: [ACPI] Re: Cause of Suspend2 resume failures
	on Toshiba laptops
Date: Tue, 08 Mar 2005 16:28:28 +1100
Message-ID: <1110259708.32064.87.camel@desktop.cunningham.myip.net.au>
References: <16A54BF5D6E14E4D916CE26C9AD305750155EABF@pdsmsx402.ccr.corp.intel.com>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305750155EABF@pdsmsx402.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: Bernard Blackham <bernard@blackham.com.au>, ACPI List <acpi-devel@lists.sourceforge.net>, Suspend2 Development <suspend2-devel@lists.suspend2.net>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Tue, 2005-03-08 at 14:25, Li, Shaohua wrote:
> >Ahh, d'oh. Try this patch instead.
> >
> >After more investigation, it seems that the issue is the GPE is
> >fired but not serviced because kacpid is frozen. This in itself
> >would be okay, however, the GPE isn't being disabled before the
> >method executes (despite there being code there to do so), and hence
> >fires continuously.
> >
> >The attached patch makes kacpid NOFREEZE so the GPE does get
> >serviced (eventually), but probably still isn't the correct
> >solution. (A better solution being making sure the GPE gets disabled
> >in the first place ... still looking into this).
> Hi,
> Did you guys try the suspend method 'platform'? In this case, ACPI will
> disable all non-wakeup GPEs.

Suspend2 supports entering S3, S4 or S5 once the image has been written.
For S3 or S4, we use the platform method, but when entering S5, we don't
and neither does Pavel.

Looking at the code, I can see that we could probably rework our support
a little as we're calling the prepare method immediately before powering
down rather than at the start of the process.

One question though: do you see any issues with calling prepare() and
finish() with the PM_DISK_PLATFORM parameter (as if entering S4 sleep)
when we're actually going to do an S5 powerdown? If this will allow the
wake events to fire (as they would for S4), it could be good for
machines where S4 isn't working properly..

The general flow of events for Suspend2 goes
1. Initial preparation
2. Freeze processes.
3. Write LRU pages.
4. Do & write atomic copy of remainder of memory.
5. Powerdown as requested, including the pm_ops->prepare() & enter().

Looking at 2.6.11, I see that Pavel does:
1. Initial preparation
2. Freeze processes.
3. pm_ops->prepare().
4. Do & write atomic copy.
5. pm_ops->enter() (PM_DISK_PLATFORM only, otherwise machine_power_off
or restart).
(Probably post resume)
6. Cleanup, including pm_ops->finish()

-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de
