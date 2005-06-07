From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: what about the sony_acpi driver?
Date: Tue, 7 Jun 2005 16:01:11 +0800
Message-ID: <20050607080111.GA3622@linux.sh.intel.com>
References: <20050606110952.GA9447@message-id.gmane0305.slipkontur.de> <20050606132911.GA4633@linux.sh.intel.com> <20050606151235.GA28528@message-id.s3e.de> <20050606152829.GA5067@linux.sh.intel.com> <20050606162707.GB8555@message-id.s3e.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050606162707.GB8555-l0tNAEGuAhiXoBlonBaIS7NAH6kLmebB@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 2005.06.07 00:27:07 +0800, Stefan Seyfried wrote:
> 
>    On Mon, Jun 06, 2005 at 11:28:29PM +0800, Yu, Luming wrote:
>    > I admit the so-called generic-acpi-hotkey-driver is hard to use. :-(
>    > And I'm trying to make it easy to use.
>    Ok, i will try it out on a hotkey-enabled machine (asus)
>    > Please try tool: acpidm. And send it to me unless you got zero.
>    attached
>    > > yes, but those specific drivers work. Today. And they do even more
>    than
>    > > hotkeys (which are non-existent on this machine), e.g. adjusting
>    LCD backlight
>    > > or switching the ASUS custom LEDs.
>    > Believe me, generic-hotkey-driver and acpi-video-driver can handle
>    these, if this is a acpi system.
>    Ok. I tried the video driver and got lots of (mostly irritating)
>    information,
>    could not do anything with it. After compiling and insmod'ing
>    sony_acpi, i
>    could immediately adjust my brightness ;-)

I went through the DSDT and SSDTs, found that there is a specific ACPI device
: SNC whose _HID is SNY5001. In the scope of this device, there are several
Methods defined but no callers. So, I think sony_acpi.c won't give your ability to control things through real hot-keys. right? If you need to use hotkey on
keyboard to control, you have to try sonypi driver. Because I didn't find any
GPEs related to hot-key methods, which are must-have for acpi-generic-hotkey-driver. I prefer integrate the quirks of sony_acpi.c into generic hotkey driver.


>    I am willing to try out all kinds of stuff.
>    --
>    Stefan Seyfried




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
