From: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Ipw2100-devel] [ipw2200]Confirmation of power management problem
Date: Mon, 11 Oct 2004 02:38:44 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200410110238.44421.shawn.starr@rogers.com>
References: <200410101932.12431.shawn.starr@rogers.com> <200410102023.50379.shawn.starr@rogers.com> <2894.194.77.192.95.1097474839.squirrel@www.mocka.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <2894.194.77.192.95.1097474839.squirrel-Iw/ES6IqVGAuZeo0DBJMuQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ipw2100-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Interesting, I believe the IBM ACPI has been merged into ACPI proper as latest 
-mm shows ACPI ThinkPad IBM source files.

On October 11, 2004 02:07, Joris Mocka wrote:
> Hi Shawn,
>
> Shawn Starr sagte:
> > The problem is, there is power going to the adapter even if I don't
> > load the  driver.
>
> ...before I load the module on my T42 there is no power on wlan, if I
> indicate it on the wlan-led!
>
> > I can confirm this because when you shut it off, there is a distinct
> > buzzing  coming from the ipw2200 device (right underneath the Sympatics
> > touchpad).
>
> ...I will try to hear for it in the evening!
>
> > If I use Linux to shut down the system w/ ACPI, then I have to
> > physically cut  power by removing battery then it is totally off.
>
> ...I did asking for the same couple of days ago but nobaody had any hints
> for me. Unloading the driver didn't work, led was still on an powering off
> didn't work. There was a hint to switch off apic:
> http://mailman.linux-thinkpad.org/pipermail/linux-thinkpad/2004-September/0
>19992.html but it didn't worked for me. I have to test it without loading
> the ipw2200 module, maybe then it will work!? But for powering off you just
> have to press the power button maybe 30 to 50 seconds. Then it will power
> off without removing battery.
>
> > This does not happen when booted into XP...something is fishy, I do
> > know ACPI  *IS* broken with the T42 as this was confirmed @ OLS this
> > year.
>
> ...but it's working much better than apm. Using apm will freeze the T42
> totally. The only thing that didn't work is power off, rest is fine:
> Buttons, Sleep in state 3, powering off hd's and so on.
> Regards
> Joris


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
