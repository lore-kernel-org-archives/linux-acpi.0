From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [Proposal]Another way to save/restore PCI config space
	for suspend/resume
Date: Tue, 26 Oct 2004 10:57:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098784674.3996.85.camel@tyrosine>
References: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
	 <20041026051100.GA5844@wotan.suse.de>  <417DEA8D.4080307@intel.com>
	 <1098780150.2789.19.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1098780150.2789.19.camel-PDvaWZGbcxh0dKo7RnIATNi2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-10-26 at 10:42 +0200, Arjan van de Ven wrote:
> On Tue, 2004-10-26 at 02:11 -0400, Len Brown wrote:
> > What this comes down to is that extended config space is device-specific.
> > Generic solutions will fail.  Only device drivers will work.
> > 
> > If there are no drivers for PCI bridges to properly save/restore
> > their config space, then should create them, even if this is all the 
> > drivers do.
> 
> note that by default, if there is no driver, the first 64 bytes of
> config space are saved/restored.

On one of my machines, doing this causes the cardbus bridge to explode
on resume (every other character of printks suddenly starts getting left
out, and then the machine hangs). This happens even if I've never loaded
the yenta driver. The naive approach certainly doesn't seem to be safe
on all hardware.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
