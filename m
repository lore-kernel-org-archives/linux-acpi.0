From: Vernon Mauery <vernux-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: Simply a question
Date: Mon, 13 Sep 2004 11:13:09 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095091619.24292.9.camel@localhost.localdomain>
References: <I3ZCVM$29288463650BED0B5BA0CE522E48D1CB@libero.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <I3ZCVM$29288463650BED0B5BA0CE522E48D1CB-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gaetano Sferra <gaesferr-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-09-13 at 05:47, Gaetano Sferra wrote:
> I'm a newsbie to the ACPI system and I've a simple question: 
> What can happen to my CPU if I turn off the acpi support in the kernel?

ACPI is the new way of having the hardware and software work together to
deal with power/thermal/configuration issues.  In the old way (APM),
BIOS would simply tell the kernel, "the battery is too low, I am
suspending" and then do it.  ACPI offers a way to move the policy out
into kernel land (and even sometimes userland) so the hardware simply
reports events and stuff.  Then, the kernel or app can respond
appropriately to the events and keep the system working in the best
possible way.

The message that says your machine will be damaged might be a bit
misleading, but in some cases it is true.  Some newer machines are
legacy free (meaning no APM) and MUST have ACPI support in the kernel to
work properly.  So, if you can determine if your machine can use APM or
not, this would tell you if you can disable ACPI support.  However, ACPI
seems to work quite well on many newer machines, even to the point that
you can use it instead of APM.

--Vernon

> The reason of this "strange" or "stipid" question is the help message in the
> kernel help regards the thermal control: "If you use a laptop you should say Y
> here, otherwise your CPU can be damaged". If it is true then it implies that the
> ACPI software command the on/off of the cooling fan or something similar but
> isn't it an unsafe behavior? Shouldn't be the BIOS or some hardware to control
> this stuffs?
> 
> Thank you for explainations.
> Gaetano Sferra
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM. 
> Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
