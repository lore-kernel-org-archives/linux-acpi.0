From: Bernard Blackham <bernard@blackham.com.au>
Subject: Re: [ACPI] Re: Cause of Suspend2 resume failures on
	Toshiba laptops
Date: Tue, 8 Mar 2005 17:47:11 +0800
Message-ID: <20050308094711.GC20154@blackham.com.au>
References: <16A54BF5D6E14E4D916CE26C9AD305750155ECAA@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305750155ECAA@pdsmsx402.ccr.corp.intel.com>
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
Cc: Pavel Machek <pavel@suse.cz>, acpi-devel@lists.sourceforge.net, suspend2-devel@lists.suspend2.net
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 08, 2005 at 02:58:01PM +0800, Li, Shaohua wrote:
> >Removing the check resolves this issue (patch attached). Is this an
> >adequate fix?
> 
> Great analyzing! I guess Both S3, swsusp, and swsusp2 can't suffer from
> this bug. Sure this patch hasn't any side effect.

At least one user has reported that this patch makes the battery
status unreadable. - http://lists.suspend2.net/lurker/message/20050306.201243.cbbca9ea.en.html

I don't know why this is the case yet, but I'd hesitate to use it
until this is sorted out.

> But I wonder if it's the right fix. Maybe we should disable all
> GPEs which have been disabled on very early of resume (that is to
> restore ACPI hardware's state).

Does calling acpi_enter_sleep_state_prep through pm_ops->prepare()
disable runtime GPEs? I can only see that done in
acpi_enter_sleep_state called through pm_ops->enter(). But calling
enter() will physically enter the sleep state too which isn't what
we want at that stage.

Hence I'm still unclear on how to disable the GPEs from swsusp2
without delving into drivers/acpi/. Should runtime GPEs be disabled
in prepare() ? The ACPI spec doesn't mention what to do with runtime
GPEs on suspend, but Pavel suggested that keeping kacpid running
during suspend would be a good idea in order to respond to things
like thermal events.

Vanilla swsusp seems to call pm_ops->prepare() on resume before
restoring the atomic copy, if the platform method is used, and later
call pm_ops->finish() once resumed. Is this valid? I gather that it
means that the entire sequence goes:
 - prepare()
 - snapshot & write to disk
 - enter()
 - wakeup & boot
 - read image from disk
 - prepare()
 - restore snapshot
 - finish()

Are the two calls to prepare() intentional or safe? To me it seems
that GPEs aren't disabled until enter() is called so currently
calling prepare() on resume wouldn't synchronise the GPE states.

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
