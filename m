From: Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>
Subject: Re: 2.6.9 S4: clock not updated after resume
Date: Sat, 23 Oct 2004 15:03:16 +0000 (UTC)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <loom.20041023T170041-953@post.gmane.org>
References: <4177A9DC.7060503@pca.it> <20041021202051.GA21624@elf.ucw.cz> <4178C072.1020905@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Luca Capello <luca@...> writes:

> 
> Hi Pavel,
> 
> on 10/21/04 22:20, Pavel Machek wrote:
> > It is a bug, here's the fix.
> actually, your fix doesn't work, as you can see from the attached
> syslog: I still need to synchronise the clock via NTP.
> 

Maybe I'm missing something here, but if the problem is that the
kernel doesn't update the system clock from the hardware clock on
resume, why bother with NTP? Can't you just do a hwclock --hctosys?

Of course, the proper way is for the kernel to do it, I'm just saying..

Jon



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
