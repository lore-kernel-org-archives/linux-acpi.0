From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: [PATCH] ACPI/PNP: add two IDs to list for PNPACPI device enumeration
Date: Fri,  1 May 2015 19:05:20 +0200
Message-ID: <1430499920-28599-1-git-send-email-Witold.Szczeponik@gmx.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Witold Szczeponik <Witold.Szczeponik@gmx.net>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Commit eec15edbb0e14485998635ea7c62e30911b465f0 ("ACPI / PNP: use
device ID list for PNPACPI device enumeration") changed the way how
ACPI devices are enumerated and when they are added to the PNP bus.

However, it broke the sound card support on (at least) a vintage
IBM ThinkPad 600E: with said commit applied, two of the necessary
"CSC01xx" devices are not added to the PNP bus and hence can not be
found during the initialization of the "snd-cs4236" module.  As a
consequence, loading "snd-cs4236" causes null pointer exceptions.
The attached patch fixes the problem end re-enables sound on the
IBM ThinkPad 600E.

The patch is applied against Linux 4.0.x.


NB: A quick way to see if existing devices are missing from the
PNP bus, the following script can be used to list candidates IDs.

hids="/sys/bus/acpi/devices/*/hid"
for hid in $(grep -v -h -E -e "^(LNX|PNP|ACPI)" $hids | sort -u)
do
        grep -q \"$hid\" drivers/acpi/acpi_pnp.c || echo $hid
done

Signed-off-by: Witold Szczeponik <Witold.Szczeponik@gmx.net>


diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index b193f84..ff6d8ad 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -304,6 +304,8 @@ static const struct acpi_device_id acpi_pnp_device_ids[] = {
        {"PNPb006"},
        /* cs423x-pnpbios */
        {"CSC0100"},
+       {"CSC0103"},
+       {"CSC0110"},
        {"CSC0000"},
        {"GIM0100"},            /* Guillemot Turtlebeach something appears to be cs4232 compatible */
        /* es18xx-pnpbios */
-- 
1.9.1
