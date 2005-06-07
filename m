From: Stefan Seyfried <seife-bro8zJjCcIc@public.gmane.org>
Subject: Re: what about the sony_acpi driver?
Date: Tue, 7 Jun 2005 11:16:37 +0200
Message-ID: <20050607091637.GA2144@message-id.s3e.de>
References: <20050606110952.GA9447@message-id.gmane0305.slipkontur.de> <20050606132911.GA4633@linux.sh.intel.com> <20050606151235.GA28528@message-id.s3e.de> <20050606152829.GA5067@linux.sh.intel.com> <20050606162707.GB8555@message-id.s3e.de> <20050607080111.GA3622@linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050607080111.GA3622-qYCAlGQNbcFrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
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

On Tue, Jun 07, 2005 at 04:01:11PM +0800, Yu, Luming wrote:
 
> I went through the DSDT and SSDTs, found that there is a specific ACPI device
> : SNC whose _HID is SNY5001. In the scope of this device, there are several
> Methods defined but no callers. So, I think sony_acpi.c won't give your
> ability to control things through real hot-keys. right?

exactly, this is what i meant with "No hotkeys, this is sony cr*p", sorry for
not being more clear, but i can "echo 4 > /proc/acpi/sony/brightness" which is 
better than nothing. :-)

> If you need to use
> hotkey on keyboard to control, you have to try sonypi driver. Because I

Sonypi does not work on newer machines (something gets detected, but i get
no events or actions from it)

> didn't find any
> GPEs related to hot-key methods, which are must-have for
> acpi-generic-hotkey-driver.

Yes, there is no hotkey functionality with sony_acpi or with sonypi either.

> I prefer integrate the quirks of sony_acpi.c into
> generic hotkey driver.

I am fine with that, i just had the impression that the generic hotkey and
video drivers are a bit like "vapourware" while the specific ones exist.
I agree that having working generic drivers is best, but people need 
something to work with until they are ready ;-)

Thanks for looking into this.
-- 
Stefan Seyfried


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
