From: Herman Sheremetyev <herman-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
Subject: Re: what about the sony_acpi driver?
Date: Mon, 06 Jun 2005 14:59:07 -0400
Message-ID: <1118084347.4736.8.camel@camel>
References: <20050606110952.GA9447@message-id.gmane0305.slipkontur.de>
	 <20050606132911.GA4633@linux.sh.intel.com>
	 <20050606151235.GA28528@message-id.s3e.de>
	 <20050606152829.GA5067@linux.sh.intel.com>
	 <20050606162707.GB8555@message-id.s3e.de>
Reply-To: herman-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Have you tried spicctrl and the sonypi driver?  I was able to get LCD
brightness controls on an older Vaio with those.

-Herman

On Mon, 2005-06-06 at 18:27 +0200, Stefan Seyfried wrote:
> On Mon, Jun 06, 2005 at 11:28:29PM +0800, Yu, Luming wrote:
> 
> > I admit the so-called generic-acpi-hotkey-driver is hard to use. :-(
> > And I'm trying to make it easy to use. 
> 
> Ok, i will try it out on a hotkey-enabled machine (asus)
> 
> > Please try tool: acpidm. And send it to me unless you got zero.
> 
> attached
> 
> > > yes, but those specific drivers work. Today. And they do even more than
> > > hotkeys (which are non-existent on this machine), e.g. adjusting LCD backlight
> > > or switching the ASUS custom LEDs.
> > Believe me, generic-hotkey-driver and acpi-video-driver can handle these, if this is a acpi system.
> 
> Ok. I tried the video driver and got lots of (mostly irritating) information,
> could not do anything with it. After compiling and insmod'ing sony_acpi, i
> could immediately adjust my brightness ;-)
> 
> I am willing to try out all kinds of stuff.
-- 
Herman Sheremetyev <herman-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
n/a



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
