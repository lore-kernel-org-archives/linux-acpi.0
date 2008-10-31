From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: eeepc-laptop rfkill, stupid question #4 and 5
Date: Fri, 31 Oct 2008 17:09:09 +0000
Message-ID: <490B3BB5.8060801@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752523AbYJaRJ2@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Did you miss a call to rfkill_force_state() on resume?

I can hibernate, then interrupt the boot with F2 to get into the BIOS,
change the "Enable WLAN" setting, and continue the resume.  When the
eeepc-laptop driver resumes, it restores the pre-hibernation value.

Actually, normal boot doesn't preserve the setting either.  Your commit
changes the behaviour from the rfkill state being persistent across
reboot / power off (as a bios setting), to being always enabled on
boot.  It seems like a bad idea to me.

Thanks
Alan
