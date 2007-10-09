From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [PATCH 2/4] ACPI: thinkpad-acpi: support
	16	levels of brightness (v2)
Date: Tue, 9 Oct 2007 08:45:50 -0300
Message-ID: <20071009114550.GC24946@khazad-dum.debian.net>
References: <1191849179-24087-1-git-send-email-hmh@hmh.eng.br>
	<1191849179-24087-3-git-send-email-hmh@hmh.eng.br>
	<1191907013.9847.69.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1191907013.9847.69.camel-X8wR35IVlAxolqkO4TVVkw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 09 Oct 2007, Thomas Renninger wrote:
> On Mon, 2007-10-08 at 10:12 -0300, Henrique de Moraes Holschuh wrote:
> > Lenovo ThinkPads with ACPI Video brightness control often have 16
> > brightness levels in EC, and not just eight levels like older ThinkPads.
> > 
> > We detect the number of brightness levels by the presence of a _BCL method
> > with 18 entries (16 levels plus the on-battery and on-ac recommended
> > levels).  If _BCL is not there, we assume eight levels (T60, for example).
> > Otherwise we assume sixteen levels (T61, X61, etc).
> This is broken by design, pls don't add this to a mainline kernel.

The thinkpad design does not expose the number of levels anywhere else.  It
is either _BCL, or worse (BCLL, a package used by _BLC/_BCM/_BQC in
thinkpads).

> Correct is: If there is _BCL (and other video functions) don't touch any
> video or brightness functionality.

There is a later patch that does just that.  Why is it not enough?

> Thinkpad_acpi should try to register for the acpi device with the
> LNXVIDEO HID. If the probe/add function there is invoked, it can be sure
> that video module tries to load and is handling the stuff in a defined
> way and thinkpad_acpi should get its hands off.

Far more complicated, and in the *specific* case of thinkpad-acpi, where I
know exactly what to poke in 100% of the problem space ("thinkpads where
thinkpad-acpi would handle backlight"), it is probably not the best way to
go about it.

> -----------------------------------------------------------
> ThinkPad has implemented _BCL/_BCM/_BQC method for Vista. 
> These brightness control methods are not used on Windows XP. 

"and Linux did all sort of unspeakable evil things through them not so long
ago"...

And still does even with the latest kernel, I suppose, anywhere people is
feeding back brightness events into thinkpad-acpi's backlight control
through userspace (something that is *not* recommended, and *not* the right
thing to do in *any* thinkpad model IMO).

Granted, some thinkpad models probably require BIOS updates *and* one of the
latest kernels (or a video.c backport), to have proper backlight control.

> Now, I don't understand which point the brightness control is broken. 
> Does Suse call _BCM , but not handle Notify (video, 0x86/0x87)
> (Increase/Decrease Brightness) ?

I am not sure it is broken anymore, actually.  And I don't have the hardware
to test it.

> The BIOSs/Machine Type/Model/Support are too complicated. 
> Why don't you use assume BIOS supports _BCL/_BCM/_BQC if these methods
> are found in ACPI name space ?

That's exactly what I do :p

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
