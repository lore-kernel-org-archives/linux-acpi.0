From: Sam Ravnborg <sam@ravnborg.org>
Subject: Use of __init in asus_acpi.c + sony_acpi.c?
Date: Sun, 26 Feb 2006 10:42:06 +0100
Message-ID: <20060226094206.GA9871@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751302AbWBZJmT@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: len.brown@intel.com, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

When running the section mismatch check on latest -mm I see:

WARNING: drivers/acpi/asus_acpi.o - Section mismatch: reference to \
.init.text:asus_hotk_add from .data between 'asus_hotk_driver' (at \
offset 0xe0) and 'model_conf'
WARNING: drivers/acpi/sony_acpi.o - Section mismatch: reference to \
.init.text:sony_acpi_add from .data between 'sony_acpi_driver' (at \
offset 0xe0) and 'sony_acpi_values'
WARNING: drivers/acpi/sony_acpi.o - Section mismatch: reference to    \
.exit.text:sony_acpi_remove from .data between 'sony_acpi_driver' (at \
offset 0xe8) and 'sony_acpi_values'

Browsing the source I see that this is assignments to struct acpi_driver
structure:

static struct acpi_driver asus_hotk_driver = {
	.name = ACPI_HOTK_NAME,
	.class = ACPI_HOTK_CLASS,
	.ids = ACPI_HOTK_HID,
	.ops = {
		.add = asus_hotk_add,          <==== __init
		.remove	= asus_hotk_remove,
	},
};


>From browsing the code I cannot see when this happens.
In asus_acpi.c and sony_acpi.c the .add and .remove methods are
declared __init/__exit indicating that the add method is solely used
during early init of the module.

Is it correct that acpi_bus_register_driver() is only called during the
early init phase of a drivers and so we can discard the .add methods
after first usage?

Likewise for .remove that this is only used when a module is unloaded
and so can be discarded when builtin?

Either asus_acpi.c and sony_acpi.c needs updates or the rest of
acpi_driver needs an update (fails to use __init, __exit).

	Sam
