From: "Jan Beulich" <jbeulich@novell.com>
Subject: [PATCH] constify tables in pci_irq.c
Date: Thu, 12 Mar 2009 11:58:25 +0000
Message-ID: <49B906F1.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vpn.id2.novell.com ([195.33.99.129]:36722 "EHLO
	vpn.id2.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbZCLMRu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2009 08:17:50 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 drivers/acpi/pci_irq.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.29-rc7/drivers/acpi/pci_irq.c	2009-03-04 09:10:22.000000000 +0100
+++ 2.6.29-rc7-acpi-pci-irq-dmi-const/drivers/acpi/pci_irq.c	2009-02-13 12:42:29.000000000 +0100
@@ -86,7 +86,7 @@ static struct acpi_prt_entry *acpi_pci_i
 }
 
 /* http://bugzilla.kernel.org/show_bug.cgi?id=4773 */
-static struct dmi_system_id medion_md9580[] = {
+static const struct dmi_system_id medion_md9580[] = {
 	{
 		.ident = "Medion MD9580-F laptop",
 		.matches = {
@@ -98,7 +98,7 @@ static struct dmi_system_id medion_md958
 };
 
 /* http://bugzilla.kernel.org/show_bug.cgi?id=5044 */
-static struct dmi_system_id dell_optiplex[] = {
+static const struct dmi_system_id dell_optiplex[] = {
 	{
 		.ident = "Dell Optiplex GX1",
 		.matches = {
@@ -110,7 +110,7 @@ static struct dmi_system_id dell_optiple
 };
 
 /* http://bugzilla.kernel.org/show_bug.cgi?id=10138 */
-static struct dmi_system_id hp_t5710[] = {
+static const struct dmi_system_id hp_t5710[] = {
 	{
 		.ident = "HP t5710",
 		.matches = {
@@ -123,13 +123,13 @@ static struct dmi_system_id hp_t5710[] =
 };
 
 struct prt_quirk {
-	struct dmi_system_id	*system;
+	const struct dmi_system_id *system;
 	unsigned int		segment;
 	unsigned int		bus;
 	unsigned int		device;
 	unsigned char		pin;
-	char			*source;	/* according to BIOS */
-	char			*actual_source;
+	const char		*source;	/* according to BIOS */
+	const char		*actual_source;
 };
 
 #define PCI_INTX_PIN(c)		(c - 'A' + 1)
@@ -139,7 +139,7 @@ struct prt_quirk {
  * interrupt at the listed segment/bus/device/pin is connected to the first
  * link device, but it is actually connected to the second.
  */
-static struct prt_quirk prt_quirks[] = {
+static const struct prt_quirk prt_quirks[] = {
 	{ medion_md9580, 0, 0, 9, PCI_INTX_PIN('A'),
 		"\\_SB_.PCI0.ISA_.LNKA",
 		"\\_SB_.PCI0.ISA_.LNKB"},
@@ -155,7 +155,7 @@ static void do_prt_fixups(struct acpi_pr
 			  struct acpi_pci_routing_table *prt)
 {
 	int i;
-	struct prt_quirk *quirk;
+	const struct prt_quirk *quirk;
 
 	for (i = 0; i < ARRAY_SIZE(prt_quirks); i++) {
 		quirk = &prt_quirks[i];



