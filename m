From: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Subject: Re: ACPI S3 resume only reboots
Date: Thu, 14 Oct 2004 10:29:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041014102928.5bd2cbc5.albeclemit@yahoo.it>
References: <88056F38E9E48644A0F562A38C64FB600318A0CF@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB600318A0CF-exJ48ZlmiLpQxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 13 Oct 2004 06:39:26 -0700
"Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> >> I suspected 'pushl $0' cause reboot a little. I can't find 
> >any fault in
> >> the line. Is it the precise line to cause reboot?
> >
> >Yes, i tryed placing an infinite loop immediately before and 
> >after that line, and that line causes reboot.
> >
> 
> From the comment in those lines, push and pop are not required for all
> platforms. Can you just comment out that push and pop and see how far
> you can go.

With those lines commented out it doesn't reboot, but hangs during the wakeup :(
To spot the line where it hangs, could i insert some reboot statement in the code? How should this statement be?
This way i could narrow down to the new problem (provided that the pushl and popfl lines weren't needed)

Thanks,
Alberto


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
