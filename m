From: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Subject: Re: smpenum patch updated to 2.6.9-rc2
Date: Wed, 15 Sep 2004 00:00:08 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095199208.3738.6.camel@localhost.localdomain>
References: <F760B14C9561B941B89469F59BA3A847077BA236@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847077BA236-sBd4vmA9Se6krb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

man, 13,.09.2004 kl. 17.23 -0700, skrev Grover, Andrew:
> Hi all,
> 
> The smpenum patch, which separates the ACPI and MPS-specific code from
> each other in SMP init, has been updated to 2.6.9-rc2.

Hi Andy,

I have a Asus CUV266-DLS smp motherboard with Via Apollo Pro 266
chipset. It has never booted with io-apic in non-ACPI mode, and still
doesn't. I just want to let you know my experiences with your patch.

1) With ACPI enabled everything works as it always has (one ACPI bug,
but that's another story)

2) With acpi=off and CONFIG_X86_MPS the boot hangs at "ENABLING IO-
APIC's"

3) With acpi=off and !CONFIG_X86_MPS the boot hangs at "Uncompressing
Linux... Ok, booting the kernel".

4) Without your patch and acpi=off the boot hangs at:

ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC Physical APIC ID to 2 ... ok.

Since you asked for testing in your earlier mail, here you go :)

Sorry that my MB is so stupid :P

Best regards,
Stian



-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
