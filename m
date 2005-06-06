From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: what about the sony_acpi driver?
Date: Mon, 6 Jun 2005 17:12:35 +0200
Message-ID: <20050606151235.GA28528@message-id.s3e.de>
References: <20050606110952.GA9447@message-id.gmane0305.slipkontur.de> <20050606132911.GA4633@linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050606132911.GA4633-qYCAlGQNbcFrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 06, 2005 at 09:29:11PM +0800, Yu, Luming wrote:

> The generic hotkey driver has been in mm tree for a while. But you need to configure it for your laptop. 

Ok, so i did not look hard enough or i was blinded by the super-bright
backlight ;-)

> > My problem is: i am now plagued with a SONY (yeah, i was naughty, so i
> > got the machine nobody wanted ;-) VGN-FS115B which has a _really_ bright
> > backlight. It is in fact so bright that i fear for my retinas, so i have
> > to turn it down (this also brings the battery life from less than 2 hours
> > to about 3 1/2 hours :-). To do this, i need the sony_acpi driver, or boot
> > Windows.
> Please send me output of acpidmp, and let me see how to configure generic hotkeydriver for your model?

There are no ACPI hotkeys on this machine. It is SONY cr*p :-( Do you still
want the acpidmp output?

> > So the question is: will the sony_acpi driver be included (when?) or will
> > the omnipotent generic driver work soon?

> It is hard to manage if each brand or model has a specific hotkey driver in kernel.

yes, but those specific drivers work. Today. And they do even more than
hotkeys (which are non-existent on this machine), e.g. adjusting LCD backlight
or switching the ASUS custom LEDs.
-- 
Stefan Seyfried


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
