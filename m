From: Jeremy Moles <jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org>
Subject: Re: Battery alarm ->  was General Questions:
Date: Fri, 04 Feb 2005 13:14:23 -0500
Message-ID: <1107540863.6153.18.camel@localhost>
References: <B774920D825C2D4880A3C1B0D6EF9418034150B4@ssdmx.ssd.fsi.com>
	 <4203D10A.3090306@bartol.udel.edu>
Reply-To: jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4203D10A.3090306-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'm not trying to hijack or anything, but since I posted "part" of whats
being pinged, I thought I might try and jump in on the good offers!

I have two _BPT, one per battery. This is the Method:

Method (_BTP, 1, NotSerialized) {
  SX10 ()
  SX30 (0x03)
  SX30 (0x01)
  SX32 (Arg0)
  SX11 ()
  SX12 ()
  Sleep (0xFA)
}

I have the spec PDF, I just haven't had time to really read through it.
Can anyone tell offhand what is wrong w/ mine that would cause it to not
generate noise when the battery is low? :)

I'm sure I'll get around to eventually, though. I plan on printing the
spec PDF this weekend, 4 pages per page, double sided. :)

> Rockefeller, Harry wrote:
> 
> <snip>
> 
> > 
> > My notebook, Uniwill N351S1, is - supposedly - both APM and ACPI 2.0
> > supported.  Would something as important as battery alarm simply not
> > be implemented in ACPI?
> 
> Certainly. Many manufacturers have broken ACPI implementations; as far 
> as they're concerned, if it works with Windows, then it "works". It's 
> probably the case that Windows polls the battery, rather than relying on 
> the alarm, so that broken implementations will still function.
> 
> > FWIW, /proc/acpi/battery/BAT0/info gives both design capacity warning
> > and low data.
> 
> These are fixed (non-settable) quantities, that have little to do with 
> the alarm.
> 
> > 
> > A 'grep BTP dsdt.dsl' turns up:      BTP0,     16,
> 
> But no _BTP, which means no alarm.
> 
> > 
> > Can I modify dsdt.dsl to add this ACPI function myself?
> 
> In principle, yes. If you like, I can have a look at your DSDT to see 
> how easy it would be to add in _BTP.
> 
> cheers,
> 
> Rich
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
Jeremy L. Moles
EmperorLinux
1-888-651-66
www.EmperorLinux.com
jeremy-LdSqz1EEwCk7YuNMryXyOw@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
