From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Re: Samsung P35 and S3 suspend
Date: Mon, 27 Dec 2004 12:51:10 +0100
Message-ID: <200412271251.11513.stefandoesinger@gmx.at>
References: <16A54BF5D6E14E4D916CE26C9AD30575D823DC@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575D823DC-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


> And also please try this one (in kernel/power/main.c):
> static void suspend_finish(suspend_state_t state)
> {
> - device_resume();
>  if (pm_ops && pm_ops->finish)
>   pm_ops->finish(state);
> + device_resume();
>  thaw_processes();
>  pm_restore_console();
> }
> According to ACPI spec, device resume should be after _WAK method (in
> acpi_leave_sleep_state)
This is the first thing I've done, it also works(See the archives), but 
Luca<kronos@pe...> told me that it's not correct:

>  Well, it may work but it"s not correct. ->finish is meant to be called
> to finalize the wakeup procedure *after* devices are waked up.
 
> ACPI finish calls acpi_leave_sleep_state() and restore the waking
> vectore. I"m not an ACPI guru but my guess is that what you need is
> in acpi_leave_sleep_state().
 
> If that"s the case we may want to split the finish callback (say
> prepare_wake and finish_wake).
This is what I did.

Stefan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
