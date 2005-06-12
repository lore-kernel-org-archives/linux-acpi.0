From: "Jason Dagit" <dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was:
 Re: Resume from Suspend to RAM))
Date: Sun, 12 Jun 2005 14:40:30 -0700
Message-ID: <878y1fjltd.fsf@www.codersbase.com>
References: <200506061531.41132.stefandoesinger@gmx.at>
	<1118193341.3857.4.camel@linux-hp.sh.intel.com>
	<200506102049.42313.hugelmopf@vodafone.de>
	<200506122255.38020.chefturner@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506122255.38020.chefturner-S0/GAf8tV78@public.gmane.org> (Christoph Tavan's
 message of "Sun, 12 Jun 2005 22:55:37 +0200")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christoph Tavan <chefturner-S0/GAf8tV78@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Christoph Tavan <chefturner-S0/GAf8tV78@public.gmane.org> writes:

> On Friday 10 June 2005 20:49, Frank Siegert wrote:
>> 2. I tried to add the patch manually (and can't see where I missed
>> something -- the "extern void machine_real_restart(...)" line exists), b=
ut
>> kernel compilation then fails.
>>
>> | =A0 CC =A0 =A0 =A0init/version.o
>> | =A0 LD =A0 =A0 =A0init/built-in.o
>> | =A0 LD =A0 =A0 =A0.tmp_vmlinux1
>> | ld: BFD 2.15 assertion fail ../../bfd/linker.c:619
>> |
>> | drivers/built-in.o(.text+0x203ef): In function `acpi_enter_sleep_state=
':
>> | : undefined reference to `machine_real_restart'
>> |
>> | make[1]: *** [.tmp_vmlinux1] Fehler 1
>> | make[1]: Verlasse Verzeichnis =BB/usr/src/linux-2.6.12-rc6=AB
>> | make: *** [stamp-build] Fehler 2
>
> I get exactly the same error. I also would like to test that patch, but I=
=20
> cannot compile the sources with that patch applied.

What is your version of gcc?  I just got around to trying this patch
out today using 2.6.12-rc6 and everything worked great.  In fact, the
patch even does the suspend/resume correctly.  Now, it doesn't
actually go to sleep so it's not useful, but it was just for
testing/debugging right?

I'm using gcc 3.3.5 (Debian 1:3.3.5-13).

>
>> Would you mind posting the patch as attachment and the exact
>> command I have to issue in my kernel directory?
>
> That would be great!!!

the command I used from linux-2.6.12-rc6/ was:
patch drivers/acpi/hardware/hwsleep.c patch-s3.diff

that assumes patch-s3.diff is in the linux-2.6.12-rc6 directory.  I'm
also attaching the patch file again as you requested.

HTH,
Jason


--=-=-=
Content-Disposition: inline; filename=patch-s3.diff

--- a/drivers/acpi/hardware/hwsleep.c	2005-06-07 13:45:04.088273424 +0800
+++ b/drivers/acpi/hardware/hwsleep.c	2005-06-07 13:49:31.858566152 +0800
@@ -242,6 +242,19 @@ acpi_enter_sleep_state_prep (
  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
  ******************************************************************************/
+#define S3_DEBUG
+#ifdef S3_DEBUG
+#include <asm/io.h>
+extern void machine_real_restart(unsigned char *code, int length);
+static unsigned char jump_to_pm [] =
+{
+	0xea,
+	0x00,
+	0x00,
+	0x00,
+	0x00		/*    ljmp  $0x0000,$0x0000  */
+};
+#endif
 
 acpi_status asmlinkage
 acpi_enter_sleep_state (
@@ -315,6 +328,14 @@ acpi_enter_sleep_state (
 	PM1Acontrol |= (acpi_gbl_sleep_type_a << sleep_type_reg_info->bit_position);
 	PM1Bcontrol |= (acpi_gbl_sleep_type_b << sleep_type_reg_info->bit_position);
 
+#ifdef S3_DEBUG
+	if (sleep_state == ACPI_STATE_S3) {
+		*((short *)&jump_to_pm[3]) =
+			(short)(virt_to_phys((void *)acpi_wakeup_address)) >> 4;
+		/* Directly jump to acpi_wakeup_address */
+		machine_real_restart(jump_to_pm, sizeof(jump_to_pm));
+	}
+#endif
 	/*
 	 * We split the writes of SLP_TYP and SLP_EN to workaround
 	 * poorly implemented hardware.

--=-=-=--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
