From: Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>
Subject: Re: Linux ACPI processor driver patch: user-definable power state limit
Date: Sun, 10 Oct 2004 16:36:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200410101636.35383.jos.delbar@ugent.be>
References: <200408071959.10529.jos.delbar@ugent.be> <1097301120.16784.2.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1097301120.16784.2.camel@d845pe>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

As Dominik Brodowski pointed out, the module parameter currently exported in 
this patch should be sufficient. I have the ACPI processor module compiled 
into my kernel, yet I can still use "processor.acpi_cstate_limit" on the boot 
line.

Do you require a new version of the patch without the "acpi_" prefix?

On Saturday 09 October 2004 07:52, you wrote:
> Jos,
> Can you modify this patch to use a kernel boot parameter
> rather than a module load parameter?  Some folks don't
> load this driver as a module.  Also, it gives you the
> chance to add a couple of lines to Documentation/kernel-parameters.txt
>
> thanks,
> -Len

-- 

Jos Delbar
jos.delbar-Cru1EgDzd7c@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
