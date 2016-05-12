From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] ACPI / scan: force creation of platform device for the Surface tablets
Date: Thu, 12 May 2016 16:06:32 +0200
Message-ID: <1463061992-11443-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Bastien Nocera <hadess@hadess.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

As mentioned in drivers/platform/x86/surfacepro3_button.c, the various
Microsoft Surface tablets do not follow the ACPI SOC buttons specification.
They present an I2C device like this:

  Device (WBUT)
  {
      Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
      {
          Return ("PNP0C40")
      }
 
      Name (_CID, "PNP0C40" /* Standard Button Controller */)  // _CID: Compatible ID
      Method (_STA, 0, NotSerialized)  // _STA: Status
      {
          Return (0x0F)
      }
 
      Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
      {
          [stripped]
      }
  }
 
  Device (TEV2)
  {
      Name (_HID, "MSHW0028")  // _HID: Hardware ID
      Name (_DEP, Package (0x06)  // _DEP: Dependencies
      {
          GPO0,
          GPO2,
          GPO1,
          ^PCI0.I2C2,
          ^PCI0.I2C7,
          ^PCI0.I2C7.PMIC
      })
      Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
      {
          Name (RBUF, ResourceTemplate ()
          {
              GpioInt (Edge, ActiveBoth, SharedAndWake, PullDefault, 0x09C4,
                  "\\_SB.GPO2", 0x00, ResourceConsumer, ,
                  )
                  {   // Pin list
                      0x0008
                  }
              GpioInt (Edge, ActiveBoth, SharedAndWake, PullDefault, 0x09C4,
                  "\\_SB.GPO2", 0x00, ResourceConsumer, ,
                  )
                  {   // Pin list
                      0x000A
                  }
              GpioInt (Edge, ActiveBoth, Shared, PullDefault, 0x09C4,
                  "\\_SB.GPO0", 0x00, ResourceConsumer, ,
                  )
                  {   // Pin list
                      0x005D
                  }
              GpioInt (Edge, ActiveBoth, Shared, PullDefault, 0x09C4,
                  "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                  )
                  {   // Pin list
                      0x0008
                  }
              I2cSerialBus (0x002D, ControllerInitiated, 0x00061A80,
                  AddressingMode7Bit, "\\_SB.PCI0.I2C2",
                  0x00, ResourceConsumer, ,
                  )
              [stripped]
          })
          [stripped]
          If ((OBID <= 0x0C))
          {
              Return (RBUF) /* \_SB_.TEV2._CRS.RBUF */
          }
 
          Return (PBUF) /* \_SB_.TEV2._CRS.PBUF */
      }
 
      Method (_STA, 0, NotSerialized)  // _STA: Status
      {
          Return (0x0F)
      }
 
      Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
      {
          [stripped]
      }
  }

The actual HW button is named MSHW0028 on the MS Surface (Pro) 3 and
is meant to be bound on the I2C bus 7. The problem is that the bus
doesn't see any device on the address 0x002D.

The Surface Pro devices have working ACPI events and thus we can use
surfacepro3_button which is a pure acpi driver. The Surface 3 however
does not generate any ACPI events and the buttons are not working
through surfacepro3_button (even when we add the name TEV2 in this module).

The solution consists in forcing the creation of an platform device
which we can handle in soc_button_array as any proper SOC GPIO buttons
should be.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi,

this is IMO the best way to handle this situation (besides fixing the DSDT
itself). The other solutions I thought were:
- add a specific acpi driver that will unbind the current I2C acpi handle
  and will create the platform_driver
- add a specific acpi driver that merges surfacepro3_button and soc_button_array
  but has a lot of code duplication

I am open to any other solution if we could have this list of ids in a different
place but I could not see any other.

Cheers,
Benjamin

 drivers/acpi/scan.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5f28cf7..6fe9296 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -46,6 +46,12 @@ DEFINE_MUTEX(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 static DEFINE_MUTEX(acpi_hp_context_lock);
 
+static const struct acpi_device_id i2c_whitelisted_id_list[] = {
+	{"MSHW0028", 0},	/* Surface (Pro) 3 buttons */
+	{"MSHW0040", 0},	/* Surface Pro 4 buttons */
+	{"", 0},
+};
+
 struct acpi_dep_data {
 	struct list_head node;
 	acpi_handle master;
@@ -1676,13 +1682,21 @@ static void acpi_default_enumeration(struct acpi_device *device)
 	bool is_spi_i2c_slave = false;
 
 	/*
-	 * Do not enemerate SPI/I2C slaves as they will be enuerated by their
+	 * Do not enemerate SPI/I2C slaves as they will be enumerated by their
 	 * respective parents.
 	 */
 	INIT_LIST_HEAD(&resource_list);
 	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
 			       &is_spi_i2c_slave);
 	acpi_dev_free_resource_list(&resource_list);
+
+	/*
+	 * these devices are declared as I2C but should actually be
+	 * enumerated as platform devices.
+	 */
+	if (!acpi_match_device_ids(device, i2c_whitelisted_id_list))
+		is_spi_i2c_slave = false;
+
 	if (!is_spi_i2c_slave)
 		acpi_create_platform_device(device);
 }
-- 
2.5.0
