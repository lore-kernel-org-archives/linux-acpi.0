From: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Subject: RE: smpenum patch updated to 2.6.9-rc2
Date: Mon, 20 Sep 2004 14:59:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095685189.7495.7.camel@localhost.localdomain>
References: <F760B14C9561B941B89469F59BA3A847077F835A@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847077F835A-sBd4vmA9Se6krb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

ons, 15,.09.2004 kl. 14.17 -0700, skrev Grover, Andrew:
> > From: Stian Jordet [mailto:liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org] 
> 
> Hi Stian thanks a lot!

My pleasure :)

> > I have a Asus CUV266-DLS smp motherboard with Via Apollo Pro 266
> > chipset. It has never booted with io-apic in non-ACPI mode, and still
> > doesn't. I just want to let you know my experiences with your patch.
> > 
> > 1) With ACPI enabled everything works as it always has (one ACPI bug,
> > but that's another story)
> 
> great...
> 
> > 2) With acpi=off and CONFIG_X86_MPS the boot hangs at "ENABLING IO-
> > APIC's"
> 
> ok not a new bug...
> 
> > 3) With acpi=off and !CONFIG_X86_MPS the boot hangs at "Uncompressing
> > Linux... Ok, booting the kernel".
> 
> Fixed, please try the attached patch.

Yes, works now :)

> > 4) Without your patch and acpi=off the boot hangs at:
> > 
> > ENABLING IO-APIC IRQs
> > Setting 2 in the phys_id_present_map
> > ...changing IO-APIC Physical APIC ID to 2 ... ok.

Why do I get two more lines without your patch? With your patch I only
get the first line before it hangs...

Best regards,
Stian



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
