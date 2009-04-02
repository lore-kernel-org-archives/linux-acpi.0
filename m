From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 51/98] ACPICA: FADT: Favor 32-bit register addresses for compatibility
Date: Thu, 2 Apr 2009 14:11:20 +0200
Message-ID: <200904021411.21492.trenn@suse.de>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <31fbc073a35a017e34840deb9e865a701e986002.1238214619.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44585 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786AbZDBMLZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Apr 2009 08:11:25 -0400
In-Reply-To: <31fbc073a35a017e34840deb9e865a701e986002.1238214619.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Mark Doughty <me@markdoughty.co.uk>Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

Hi,

On Saturday 28 March 2009 05:31:26 Len Brown wrote:
> From: Bob Moore <robert.moore@intel.com>
> 
> Use the 32-bit register addresses whenever they are non-zero. This
> means that the 32-bit addresses are favored over the 64-bit
> (GAS) addresses. The 64-bit addresses are only used if the 32-bit
> addresses are zero. This change provides compatibility with all
> versions of Windows. The worst case that this solves is when both
> the 32-bit and 64-bit addresses are non-zero, but only the 32-bit
> addresses are actually valid. This appears to happen in some
> BIOSes because in this case, Windows uses the 32-bit addresses.

this one should finally make C-states on R40e work.
This one still applies with a tiny offset, please apply.
Not sure whether we can convince Mark for another test, it
would be great if you could try out things during 2.6.30
test phase at some time at least.

Thanks,

   Thomas

---
From: Thomas Renninger <trenn@suse.de>
Subject: Remove R40e c-state blacklist
Patch-mainline: not yet
References: http://bugzilla.kernel.org/show_bug.cgi?id=8246

Remove R40e c-state blacklist

Previous patch makes this machine to use the right FADT HW addresses
and C-states finally work fine.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Tested-by: Mark Doughty <me@markdoughty.co.uk>
CC: Yakui Zhao <yakui.zhao@intel.com>


---
 drivers/acpi/processor_idle.c |   51 ------------------------------------------
 1 file changed, 51 deletions(-)

--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -127,57 +127,6 @@ static int set_max_cstate(const struct d
 /* Actually this shouldn't be __cpuinitdata, would be better to fix the
    callers to only run once -AK */
 static struct dmi_system_id __cpuinitdata processor_power_dmi_table[] = {
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET70WW")}, (void *)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET60WW")}, (void *)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET43WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET45WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET47WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET50WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET52WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET55WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET56WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET59WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET60WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET61WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET62WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET64WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET65WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET68WW") }, (void*)1},
-	{ set_max_cstate, "Medion 41700", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"R01-A1J")}, (void *)1},
 	{ set_max_cstate, "Clevo 5600D", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"SHE845M0.86C.0013.D.0302131307")},

