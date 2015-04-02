From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 3/3][RFD] device property: Implement fallback to built-in
 properties
Date: Thu, 2 Apr 2015 17:35:06 +0300
Message-ID: <20150402143506.GA2057@kuha.fi.intel.com>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com>
 <10066684.kPKm7OTnxF@vostro.rjw.lan>
 <1594911.7FXIhSfjIv@vostro.rjw.lan>
 <5634167.lftqZnjhIC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28028 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459AbbDBOfK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Apr 2015 10:35:10 -0400
Content-Disposition: inline
In-Reply-To: <5634167.lftqZnjhIC@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Mar 28, 2015 at 02:26:35AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify the fwnode_property_* accessors so as to make them fall back
> to using "built-in" device properties from a property_set structure
> associated with the given device (as the secondary firmware node)
> if the property in question cannot be retrieved from the primary
> firmware node (DT or ACPI).  That will make the device_properties_*
> functions do the same thing as they use fwnode_property_* internally.
> 
> That should make it easier to provide default values for device
> properties used by device drivers to be used in case the properties
> in question are not provided by the platform firmare at all or
> they cannot be retireved from the platform firmware due to errors.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

FWIW for the whole series:

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

I'm attaching the little patch I used to test this with Synopsys
Designware USB Device Controller. Everything worked nicely.

> First of all, this should show why I thought it would be better to use
> the primary/secondary scheme for firmware nodes instead of just having a
> list of them with the head pointed to by the struct device's fwnode field.
> Namely, within the primary/secondary scheme the ordering of property lookup
> is always well defined and there's no overhead when, for example, somebody
> specifically wants to access the ACPI companion firmware node etc.
> 
> Second, as I said in the intro message, this is not for immediate application
> (apart from any review comments on [1-2/3]), because it would introduce an
> artificial difference between DT and ACPI that I'd prefer to avoid.
> 
> Namely, dev_fwnode() (introduced by one of the patches in linux-next) returns
> the address of the dev->of_node's fwnode field if dev->of_node is present and
> that would not have the secondary pointer set.  On the other hand, since ACPI
> is now using set_primary_fwnode() to add its firmware node companions to
> devices, the secondary pointer in its firmware node handle will be set if the
> "built-in" properties are present.  So, effectively, with this patch applied
> ACPI would always fall back to the "built-in" properties (if present), while
> DT would not do that (unless the DT node is missing entirely).
> 
> That difference could be worked around, though, if dev->fwnode is always set
> whenever dev->of_node is set in essentially this way:
> 
> 	dev->of_node = dn;
> 	set_primary_fwnode(dev, &dn->fwnode);
> 
> (that, of course, can be defined as a macro or static inline).  Now, I'm not
> sure about that, but my somewhat educated guess is that while dev->of_node is
> read in many many places, the number of places in which it is set is actually
> much smaller and making this change in one go should be a workable thing.
> 
> Please let me know what you think.

To me falling back to the "built-in" device properties is the most
interesting thing. I have already a set of mfd and probing drivers,
such as dwc3-pci.c in my example, in my mind, where I have the ACPI
companion but could still really use the build-in properties.


Thanks,

-- 
heikki

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dwc3_pset_test.diff"

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index b773fb5..b02b782 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -31,8 +31,41 @@
 #define PCI_DEVICE_ID_INTEL_SPTLP	0x9d30
 #define PCI_DEVICE_ID_INTEL_SPTH	0xa130
 
+static struct property_entry dwc3_pci_prop[5];
+static struct property_set dwc3_pci_pset = {
+	.properties = dwc3_pci_prop,
+};
+
+static u8 lpm_nyet_threshold[2];
+static u8 tx_de_emphasis[2];
+
 static int dwc3_pci_quirks(struct pci_dev *pdev)
 {
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
+	    pdev->device == PCI_DEVICE_ID_INTEL_SPTLP) {
+		struct platform_device *dwc3 = pci_get_drvdata(pdev);
+
+		/* Let's test a couple of boolean properties */
+		dwc3_pci_prop[0].name = "snps,dis_u3_susphy_quirk";
+		dwc3_pci_prop[1].name = "snps,dis_u2_susphy_quirk";
+
+		/* And properties of type u8 */
+		lpm_nyet_threshold[0] = 0xf;
+		tx_de_emphasis[0] = 1;
+
+		dwc3_pci_prop[2].name = "snps,lpm-nyet-threshold";
+		dwc3_pci_prop[2].type = DEV_PROP_U8;
+		dwc3_pci_prop[2].nval = 1;
+		dwc3_pci_prop[2].value.u8_data = lpm_nyet_threshold;
+
+		dwc3_pci_prop[3].name = "snps,tx_de_emphasis";
+		dwc3_pci_prop[3].type = DEV_PROP_U8;
+		dwc3_pci_prop[3].nval = 1;
+		dwc3_pci_prop[3].value.u8_data = tx_de_emphasis;
+
+		device_add_property_set(&dwc3->dev, &dwc3_pci_pset);
+	}
+
 	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
 	    pdev->device == PCI_DEVICE_ID_AMD_NL_USB) {
 		struct dwc3_platform_data pdata;

--AqsLC8rIMeq19msA--
