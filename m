From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] Minor fixes (was Re: [PATCH] S4Bios support for 2.4.20 + acpi-20021205)
Date: Fri, 13 Dec 2002 21:52:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021213205218.GT4327@poup.poupinou.org>
References: <20021213155309.GG4327@poup.poupinou.org> <20021213171431.045233f0.nils@kernelconcepts.de> <20021213163615.GI4327@poup.poupinou.org> <20021213181316.0b460077.nils@kernelconcepts.de> <20021213183622.GN4327@poup.poupinou.org> <20021213194907.5d99fc57.nils@kernelconcepts.de> <20021213191758.GP4327@poup.poupinou.org> <20021213210359.266e4417.nils@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="iVCmgExH7+hIHJ1A"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021213210359.266e4417.nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2002 at 09:03:59PM +0100, Nils Faerber wrote:
> On Fri, 13 Dec 2002 20:17:58 +0100
> Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:
> > On Fri, Dec 13, 2002 at 07:49:07PM +0100, Nils Faerber wrote:
> > [...]
> > > My result:
> > > 	S4BIOS_REQ:       0x00
> > > 
> > > > For ./acpidmp FACS | ./acpitbl:
> > > > Flags have bit 0 set.
> > > 
> > > Signature:              FACS
> > > Length:                 64
> > > Hardware Signature:     0x00000000
> > > Firmware Waking Vector: 0x00000000
> > > Global Lock:            0x00000000
> > > Flags:                  0x00000000
> > > 
> > > Hmm ... and now?
> > > What does that mean?
> > Your BIOS cry loudly that it do not support S4Bios (certainly due
> > to a lack of a suspend partition).  I supposed that my patch does it
> > right, so that if someone insist, it give up, but that is not the
> > case. I have to look what stupid brain-damaged bogosity I have written
> > then.
> 
> Oh well, many thanks again!
> I already thought something like this.
> Now, this just leaves the question what f*ckin' type of partition this
> BIOS wants. I already tried almost everything: lphdisk, zvhdd (DOS
> utility), simple VFAT32 partition, nothing. Oh well ... mybe I'll
> disassemble the BIOS - just joking :) I think best bet would be to ask
> Asus for a hint.
> 

This incremental patch should give you the oportunity to not go to s4bios
if bios do not support.  It fix also a printk introduced by me (sorry).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="00_system_fix_s4bios-2.4.20-acpi-20021205.diff"

--- linux-2.4.20/drivers/acpi/system.c	2002/12/13 20:15:23	1.2
+++ linux-2.4.20/drivers/acpi/system.c	2002/12/13 20:43:18
@@ -300,11 +300,16 @@
 		return AE_ERROR;
 
 
-	/* For s4bios, we need a wakeup address. */
-	if (state == ACPI_STATE_S4) {
-		if (!acpi_wakeup_address)
+	if (ACPI_STATE_S4 == state) {
+		/* For s4bios, we need a wakeup address. */
+		if (1 == acpi_gbl_FACS->S4bios_f &&
+		    0 != acpi_gbl_FADT->smi_cmd) {
+			if (!acpi_wakeup_address)
+				return AE_ERROR;
+			acpi_set_firmware_waking_vector((ACPI_PHYSICAL_ADDRESS) acpi_wakeup_address);
+		} else
+			/* We don't support S4 under 2.4.  Give up */
 			return AE_ERROR;
-		acpi_set_firmware_waking_vector((ACPI_PHYSICAL_ADDRESS) acpi_wakeup_address);
 	}
 
 	acpi_enter_sleep_state_prep(state);
@@ -366,8 +371,12 @@
 
 	p += sprintf(p, "states:                  ");
 	for (i=0; i<ACPI_S_STATE_COUNT; i++) {
-		if (system->states[i])
+		if (system->states[i]) 
 			p += sprintf(p, "S%d ", i);
+			if (i == ACPI_STATE_S4 &&
+			    acpi_gbl_FACS->S4bios_f &&
+			    0 != acpi_gbl_FADT->smi_cmd)
+				p += sprintf(p, "S4Bios ");
 	}
 	p += sprintf(p, "\n");
 
@@ -671,7 +680,7 @@
 			p += sprintf(p,"S%d ", i);
 			if (i == ACPI_STATE_S4 && acpi_gbl_FACS->S4bios_f &&
 			    acpi_gbl_FADT->smi_cmd != 0)
-				p += sprintf(p, "S4bios ");
+				p += sprintf(p, "S4Bios ");
 		}
 	}
 
@@ -716,7 +725,7 @@
 	printk(KERN_DEBUG "acpi: sleep %d\n", state);
 	if (!system->states[state])
 		return_VALUE(-ENODEV);
-	printk(KERN_DEBUG "acpi: GO!\n", state);
+	printk(KERN_DEBUG "acpi: GO!\n");
 	
 	/*
 	 * If S4 is supported by the OS, then we should assume that
@@ -1223,7 +1232,8 @@
 		status = acpi_get_sleep_type_data(i, &type_a, &type_b);
 		switch (i) {
 		case ACPI_STATE_S4:
-			if (acpi_gbl_FACS->S4bios_f && 0 != acpi_gbl_FADT->smi_cmd) {
+			if (acpi_gbl_FACS->S4bios_f &&
+			    0 != acpi_gbl_FADT->smi_cmd) {
 				printk(" S4bios");
 				system->states[i] = 1;
 			}

--iVCmgExH7+hIHJ1A--


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
