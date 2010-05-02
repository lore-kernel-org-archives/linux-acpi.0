From: Jerone Young <jerone.young@canonical.com>
Subject: [PATCH] [RESUBMIT] Fix mute key on older Lenovo made Thinkpads by
 OSI blacklisting
Date: Sat, 01 May 2010 22:20:32 -0500
Message-ID: <1272770432.15493.49.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:57288 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754850Ab0EBDUl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 May 2010 23:20:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>

After much discussion over these patches there are some points that have
been sorted out:

	- New X & W series Thinkpads (X201 & W510) ONLY send a mute
          key press and nothing more. By adding the older
          models, as this patch does, has the machines acting with the
          same behavior. Lenovo has dropped hardware mute.
          Lenovo looks to not be updating the R series.

	- These models have no light indicator on them that the mute
          is on. This is a Lenovo x200 keyboard:
          http://www.slashgear.com/gallery/data_files/7/4/ThinkPad_X200_keyboard.jpg
          
	
	- These machines do not send any ACPI or any type of event when 
          the mute button is pressed. Unless you expose to them that
          Linux is the OS. Then it will send mute key press. Lenovo made
          Thinkpads do not have the same behavior as the IBM made
          Thinkpads.
 

	- While the hardware mute is disabled by this patch.
		- Fixes muting of headphone jack. Lenovo only has
                  hardware mute wired to the external speakers.
		- Gives users a much better Linux experience as Linux
                  can see the mute keypress and so (in distributions
                  like Ubuntu), give users visual indication that 
                  Mute is on. Right now users have no idea.

		* The hardware mute muted the volume in the hardware,
                  not waiting for software. This only comes in
                  handy if userspace or kernel crashes or malfunctions
                  and sound is still being sent from the sound card. 
         	  Thought this is a rare case. Most users perfer
                  knowing that the mute is on or off.

	- To pull off hardware muting properly under Linux will 
          require a userspace daemon to keep both hardware mute
          & userspace sound servers in sync. Again this is something
          newer equivalent Thinkpads could not use.

	- Other Lenovo models from this exact same time frame are
          already in blacklist.c fixing the SAME issue, and they
          ALL change the behavior in the SAME way. These include
          Lenovo Thinkpads T400 & T500.

	- This has been tested by many many users who love this
          behavior over the way it works now. Lenovo has changed
          the default behavior of the new Thinkpads to reflect 
          this.

	- These machines will not be getting a bios update to 
          change the behavior in the future.
 
This patch fixes that mute keys for X & R & W series Thinkpads. For
these Thinkpads in the BIOS if OS exposes itself as "Linux" it will
switch the functionality of the mute key to send a mute key press to the
OS. These machines will not be getting any bios updates in the future.

All of these Thinkpads do not have a little light that would indicate
the mute is on. So having them send the mute key to the OS makes a
better user experience and also will match behavior of newer Thinkpads.
These all have the same quirk the T400 & T500 have.

Unlike the last time I sent a similar patch(s) somethings have happened:

        - All new Lenovo Thinkpads now send a mute key press to the 
          OS by default (x201 series).

        - I've decoded the bioses. Under the Linux selection it 
          only does one operation. Switch the hardware mute to
          a software mute. Has no special operations done under
          Windows selections.
        
        - On all the machines. The hardware mute key is only wired
          to the external speakers. So the headphone jack does not 
          get muted by the hardware mute.

        - I also have gotten confirmation from users around the
          net that it works. Except for the W700, though based on
          data I found it was the same as the W500.


Signed-off-by: Jerone Young <jerone.young@canonical.com>

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 2815df6..cce6e1a 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -285,6 +285,46 @@ static struct dmi_system_id acpi_osi_dmi_table[]
__initdata = {
                     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T500"),
                },
        },
+       {
+       .callback = dmi_enable_osi_linux,
+       .ident = "Lenovo ThinkPad X200[s][t]",
+       .matches = {
+                    DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+                    DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X200"),
+               },
+       },
+       {
+       .callback = dmi_enable_osi_linux,
+       .ident = "Lenovo ThinkPad R400",
+       .matches = {
+                    DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+                    DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R400"),
+               },
+       },
+       {
+       .callback = dmi_enable_osi_linux,
+       .ident = "Lenovo ThinkPad R500",
+       .matches = {
+                    DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+                    DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R500"),
+               },
+       },
+       {
+       .callback = dmi_enable_osi_linux,
+       .ident = "Lenovo ThinkPad W500",
+       .matches = {
+                   DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+                   DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W500"),
+               },
+       },
+       {
+       .callback = dmi_enable_osi_linux,
+       .ident = "Lenovo ThinkPad W700[ds]",
+       .matches = {
+                  DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+                  DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W700"),
+               },
+       },
        {}
 };
 




