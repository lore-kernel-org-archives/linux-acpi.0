From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS,
	...)
Date: Fri, 22 Oct 2004 08:35:52 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098405352.28250.2.camel@sli10-desk.sh.intel.com>
References: <4176FCB8.3060103@root.org>
	 <1098323602.6132.51.camel@sli10-desk.sh.intel.com>
	 <20041021103729.GA1088@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041021103729.GA1088-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-10-21 at 18:37, Pavel Machek wrote:
> Hi!
> 
> > > > :-). Well for some other people it powers up when they unplug AC
> > > > power, and *that* is nasty. I'd like my machine to stay powered down
> > > > when I tell it so.
> > > 
> > > This is likely a similar GPE problem.  The GPE for the EC fires even
> > > in 
> > > S5.  I think the EC GPE should be disabled in the suspend method.
> > It could be the wakeup GPE issue, but must note Pavel's system suffer
> > the problem even with acpi=off. Could you please try boot your system
> > with acpi=off, and then reboot with acpi=off, what's the result? I
> > expected the wakeup GPE is disabled by the BIOS in this case.
> > Anyway, the DSDT can tell us the wakeup GPE info.
> 
> You want me to boot with acpi=off twice and see if machine powers down
> okay in second case?
Yes, indeed.
> 
> Compressed DSDT is attached.
The dmesg shows your system can be waked up by Lid from S4 but not S5.
But there is another device (looks like the LPC bridge) can wakeup your
system from S5.

Thanks,
Shaohua



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
