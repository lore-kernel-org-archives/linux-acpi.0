From: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Ipw2100-devel] [ipw2200]Confirmation of power management problem
Date: Wed, 13 Oct 2004 13:08:46 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200410131308.47014.shawn.starr@rogers.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3001AD09EA@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3001AD09EA-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, George Socker <george.socker-H+0wwilmMs3R7s880joybQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

yes, nolapic in 2.6.9-rc3-bk8 works. I will bump my kernel and apply this 
patch unless its merged into -rc4? If not apply manually.

Len, great work on getting ibm-acpi into -mm. us ThinkPad users appreciate it!

This also solves the ipw2200 being stuck on during power off.

Shawn.

On October 13, 2004 12:48, Brown, Len wrote:
> Re: poweroff
>
> Until last week, Linux forced the LAPIC to
> be enabled on systems who's BIOS had it disabled.
> You can observe it is enabled or disabled by
> looking if "LOC" is non-zero on /proc/interrupts.
> (non-zero means you're getting local APIC timer interrupts)
>
> But this caused a number of machines to power-off
> incorrectly.  The workaround was to boot with "nolapic".
> This is fixed in the latest 2.6.9 tree, and the patch is here:
> http://linux.bkbits.net:8080/linux-2.6/cset@41696f84CrEcJrCzRqhBpHrjqxy1
> 1w?nav=index.html|ChangeSet@-7d
> Now Linux believes what the BIOS says, and you can force
> the LAPIC to be enabled against the BIOS' wishes with "lapic"
> if you like.
>
> If your system still doesn't poweroff when using this patch,
> or if a manual "nolapic" is still necessary to poweroff
> your machine, please let me know cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>
> thanks,
> -Len
>
> ps. Re: ibm-acpi is in -mm
>
> Yes it is, but it isn't in Linus's tree yet.
> I'm expecting an updated version of this patch soon and
> we'll push it into 2.6.10 as EXPERIMENTAL, which it is.
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> ipw2100-devel mailing list
> ipw2100-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/ipw2100-devel


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
