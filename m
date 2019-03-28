From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 03/23] acpi doc: convert acpi/enumeration.txt to rst format
Date: Fri, 29 Mar 2019 00:27:01 +0800
Message-ID: <20190328162721.26138-4-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 .../acpi/{enumeration.txt => enumeration.rst} | 133 ++++++++++--------
 Documentation/acpi/index.rst                  |   1 +
 2 files changed, 72 insertions(+), 62 deletions(-)
 rename Documentation/acpi/{enumeration.txt => enumeration.rst} (87%)

diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.rst
similarity index 87%
rename from Documentation/acpi/enumeration.txt
rename to Documentation/acpi/enumeration.rst
index 7bcf9c3d9fbe..a99169603020 100644
--- a/Documentation/acpi/enumeration.txt
+++ b/Documentation/acpi/enumeration.rst
@@ -1,5 +1,7 @@
-ACPI based device enumeration
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+=============================
+ACPI Based Device Enumeration
+=============================
+
 ACPI 5 introduced a set of new resources (UartTSerialBus, I2cSerialBus,
 SpiSerialBus, GpioIo and GpioInt) which can be used in enumerating slave
 devices behind serial bus controllers.
@@ -11,12 +13,12 @@ that are accessed through memory-mapped registers.
 In order to support this and re-use the existing drivers as much as
 possible we decided to do following:
 
-	o Devices that have no bus connector resource are represented as
-	  platform devices.
+  - Devices that have no bus connector resource are represented as
+    platform devices.
 
-	o Devices behind real busses where there is a connector resource
-	  are represented as struct spi_device or struct i2c_device
-	  (standard UARTs are not busses so there is no struct uart_device).
+  - Devices behind real busses where there is a connector resource
+    are represented as struct spi_device or struct i2c_device
+    (standard UARTs are not busses so there is no struct uart_device).
 
 As both ACPI and Device Tree represent a tree of devices (and their
 resources) this implementation follows the Device Tree way as much as
@@ -31,7 +33,8 @@ enumerated from ACPI namespace. This handle can be used to extract other
 device-specific configuration. There is an example of this below.
 
 Platform bus support
-~~~~~~~~~~~~~~~~~~~~
+====================
+
 Since we are using platform devices to represent devices that are not
 connected to any physical bus we only need to implement a platform driver
 for the device and add supported ACPI IDs. If this same IP-block is used on
@@ -39,7 +42,7 @@ some other non-ACPI platform, the driver might work out of the box or needs
 some minor changes.
 
 Adding ACPI support for an existing driver should be pretty
-straightforward. Here is the simplest example:
+straightforward. Here is the simplest example::
 
 	#ifdef CONFIG_ACPI
 	static const struct acpi_device_id mydrv_acpi_match[] = {
@@ -61,12 +64,13 @@ configuring GPIOs it can get its ACPI handle and extract this information
 from ACPI tables.
 
 DMA support
-~~~~~~~~~~~
+===========
+
 DMA controllers enumerated via ACPI should be registered in the system to
 provide generic access to their resources. For example, a driver that would
 like to be accessible to slave devices via generic API call
 dma_request_slave_channel() must register itself at the end of the probe
-function like this:
+function like this::
 
 	err = devm_acpi_dma_controller_register(dev, xlate_func, dw);
 	/* Handle the error if it's not a case of !CONFIG_ACPI */
@@ -74,7 +78,7 @@ function like this:
 and implement custom xlate function if needed (usually acpi_dma_simple_xlate()
 is enough) which converts the FixedDMA resource provided by struct
 acpi_dma_spec into the corresponding DMA channel. A piece of code for that case
-could look like:
+could look like::
 
 	#ifdef CONFIG_ACPI
 	struct filter_args {
@@ -114,7 +118,7 @@ provided by struct acpi_dma.
 Clients must call dma_request_slave_channel() with the string parameter that
 corresponds to a specific FixedDMA resource. By default "tx" means the first
 entry of the FixedDMA resource array, "rx" means the second entry. The table
-below shows a layout:
+below shows a layout::
 
 	Device (I2C0)
 	{
@@ -138,12 +142,13 @@ acpi_dma_request_slave_chan_by_index() directly and therefore choose the
 specific FixedDMA resource by its index.
 
 SPI serial bus support
-~~~~~~~~~~~~~~~~~~~~~~
+======================
+
 Slave devices behind SPI bus have SpiSerialBus resource attached to them.
 This is extracted automatically by the SPI core and the slave devices are
 enumerated once spi_register_master() is called by the bus driver.
 
-Here is what the ACPI namespace for a SPI slave might look like:
+Here is what the ACPI namespace for a SPI slave might look like::
 
 	Device (EEP0)
 	{
@@ -163,7 +168,7 @@ Here is what the ACPI namespace for a SPI slave might look like:
 
 The SPI device drivers only need to add ACPI IDs in a similar way than with
 the platform device drivers. Below is an example where we add ACPI support
-to at25 SPI eeprom driver (this is meant for the above ACPI snippet):
+to at25 SPI eeprom driver (this is meant for the above ACPI snippet)::
 
 	#ifdef CONFIG_ACPI
 	static const struct acpi_device_id at25_acpi_match[] = {
@@ -182,7 +187,7 @@ to at25 SPI eeprom driver (this is meant for the above ACPI snippet):
 
 Note that this driver actually needs more information like page size of the
 eeprom etc. but at the time writing this there is no standard way of
-passing those. One idea is to return this in _DSM method like:
+passing those. One idea is to return this in _DSM method like::
 
 	Device (EEP0)
 	{
@@ -202,7 +207,7 @@ passing those. One idea is to return this in _DSM method like:
 		}
 
 Then the at25 SPI driver can get this configuration by calling _DSM on its
-ACPI handle like:
+ACPI handle like::
 
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_object_list input;
@@ -220,14 +225,15 @@ ACPI handle like:
 	kfree(output.pointer);
 
 I2C serial bus support
-~~~~~~~~~~~~~~~~~~~~~~
+======================
+
 The slaves behind I2C bus controller only need to add the ACPI IDs like
 with the platform and SPI drivers. The I2C core automatically enumerates
 any slave devices behind the controller device once the adapter is
 registered.
 
 Below is an example of how to add ACPI support to the existing mpu3050
-input driver:
+input driver::
 
 	#ifdef CONFIG_ACPI
 	static const struct acpi_device_id mpu3050_acpi_match[] = {
@@ -251,56 +257,57 @@ input driver:
 	};
 
 GPIO support
-~~~~~~~~~~~~
+============
+
 ACPI 5 introduced two new resources to describe GPIO connections: GpioIo
 and GpioInt. These resources can be used to pass GPIO numbers used by
 the device to the driver. ACPI 5.1 extended this with _DSD (Device
 Specific Data) which made it possible to name the GPIOs among other things.
 
-For example:
+For example::
 
-Device (DEV)
-{
-	Method (_CRS, 0, NotSerialized)
+	Device (DEV)
 	{
-		Name (SBUF, ResourceTemplate()
+		Method (_CRS, 0, NotSerialized)
 		{
-			...
-			// Used to power on/off the device
-			GpioIo (Exclusive, PullDefault, 0x0000, 0x0000,
-				IoRestrictionOutputOnly, "\\_SB.PCI0.GPI0",
-				0x00, ResourceConsumer,,)
+			Name (SBUF, ResourceTemplate()
 			{
-				// Pin List
-				0x0055
-			}
+				...
+				// Used to power on/off the device
+				GpioIo (Exclusive, PullDefault, 0x0000, 0x0000,
+					IoRestrictionOutputOnly, "\\_SB.PCI0.GPI0",
+					0x00, ResourceConsumer,,)
+				{
+					// Pin List
+					0x0055
+				}
+
+				// Interrupt for the device
+				GpioInt (Edge, ActiveHigh, ExclusiveAndWake, PullNone,
+					0x0000, "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer,,)
+				{
+					// Pin list
+					0x0058
+				}
+
+				...
 
-			// Interrupt for the device
-			GpioInt (Edge, ActiveHigh, ExclusiveAndWake, PullNone,
-				 0x0000, "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer,,)
-			{
-				// Pin list
-				0x0058
 			}
 
-			...
-
+			Return (SBUF)
 		}
 
-		Return (SBUF)
-	}
-
-	// ACPI 5.1 _DSD used for naming the GPIOs
-	Name (_DSD, Package ()
-	{
-		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-		Package ()
+		// ACPI 5.1 _DSD used for naming the GPIOs
+		Name (_DSD, Package ()
 		{
-			Package () {"power-gpios", Package() {^DEV, 0, 0, 0 }},
-			Package () {"irq-gpios", Package() {^DEV, 1, 0, 0 }},
-		}
-	})
-	...
+			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+			Package ()
+			{
+				Package () {"power-gpios", Package() {^DEV, 0, 0, 0 }},
+				Package () {"irq-gpios", Package() {^DEV, 1, 0, 0 }},
+			}
+		})
+		...
 
 These GPIO numbers are controller relative and path "\\_SB.PCI0.GPI0"
 specifies the path to the controller. In order to use these GPIOs in Linux
@@ -310,7 +317,7 @@ There is a standard GPIO API for that and is documented in
 Documentation/gpio/.
 
 In the above example we can get the corresponding two GPIO descriptors with
-a code like this:
+a code like this::
 
 	#include <linux/gpio/consumer.h>
 	...
@@ -334,21 +341,22 @@ See Documentation/acpi/gpio-properties.txt for more information about the
 _DSD binding related to GPIOs.
 
 MFD devices
-~~~~~~~~~~~
+===========
+
 The MFD devices register their children as platform devices. For the child
 devices there needs to be an ACPI handle that they can use to reference
 parts of the ACPI namespace that relate to them. In the Linux MFD subsystem
 we provide two ways:
 
-	o The children share the parent ACPI handle.
-	o The MFD cell can specify the ACPI id of the device.
+  - The children share the parent ACPI handle.
+  - The MFD cell can specify the ACPI id of the device.
 
 For the first case, the MFD drivers do not need to do anything. The
 resulting child platform device will have its ACPI_COMPANION() set to point
 to the parent device.
 
 If the ACPI namespace has a device that we can match using an ACPI id or ACPI
-adr, the cell should be set like:
+adr, the cell should be set like::
 
 	static struct mfd_cell_acpi_match my_subdevice_cell_acpi_match = {
 		.pnpid = "XYZ0001",
@@ -366,7 +374,8 @@ the MFD device and if found, that ACPI companion device is bound to the
 resulting child platform device.
 
 Device Tree namespace link device ID
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+====================================
+
 The Device Tree protocol uses device identification based on the "compatible"
 property whose value is a string or an array of strings recognized as device
 identifiers by drivers and the driver core.  The set of all those strings may be
@@ -423,4 +432,4 @@ the _DSD of the device object itself or the _DSD of its ancestor in the
 Otherwise, the _DSD itself is regarded as invalid and therefore the "compatible"
 property returned by it is meaningless.
 
-Refer to DSD-properties-rules.txt for more information.
+Refer to :doc:`DSD-properties-rules` for more information.
\ No newline at end of file
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index faeb545fb731..624eb95e982b 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -6,3 +6,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    :maxdepth: 2
 
    namespace
+   enumeration
-- 
2.20.1
