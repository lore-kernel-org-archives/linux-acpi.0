From: "D. S." <silent.bob-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Subject: acpi-problem with samsung x10 1700
Date: Fri, 19 Dec 2003 16:09:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1071846583.2072.95.camel@drnpc01.hell.hellgate.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

hi folks,
maybe you folks could help me out.
i fixed the dsdt.aml so far that iasl compiles without an error.
so far so good.

now dmesg gives me the following:

acpi-1121: error:method execution failed [\SB_.ADP1._STA] (Node
c1613920), AE_AML_NO_RETURN_VALUE
acpi-1121: error:method execution failed [\SB_.BAT1._STA] (Node
c1613a20), AE_AML_NO_RETURN_VALUE

this means, if i'm correct, that the stats for battery and ac-adapter
can't be read.
i am not sure where to correct this and how.

so you maybe need some info on the machine/dist.
samsung x10 xtc1700
bios 06ye (samsung orginal shipped)
suse 9.0 (wich is patched already for reading dsdt)

help would be great!

regards
d.

Some programming languages manage to absorb change, but withstand
progress. -- Epigrams in Programming, ACM SIGPLAN Sept. 1982



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
