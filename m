From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3]PCI resume code call pci_enable_device
Date: Fri, 21 Jan 2005 15:49:53 +0800
Message-ID: <1106293745.19407.66.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Add pci_enable_device in .resume method for some drivers. I just fixed
some at hand. Will fix more if there are other cases.

Signed-off-by: Li Shaohua<shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

---

 2.5-root/drivers/net/b44.c             |    1 +
 2.5-root/drivers/pcmcia/yenta_socket.c |    1 +
 2.5-root/drivers/usb/host/uhci-hcd.c   |    1 +
 3 files changed, 3 insertions(+)

diff -puN drivers/usb/host/uhci-hcd.c~resume_call_pci_enable_device drivers/usb/host/uhci-hcd.c
--- 2.5/drivers/usb/host/uhci-hcd.c~resume_call_pci_enable_device	2005-01-20 13:57:15.903906968 +0800
+++ 2.5-root/drivers/usb/host/uhci-hcd.c	2005-01-20 13:58:33.971038960 +0800
@@ -2251,6 +2251,7 @@ static int uhci_resume(struct usb_hcd *h
 	int rc;
 
 	pci_set_master(to_pci_dev(uhci_dev(uhci)));
+	pci_enable_device(to_pci_dev(uhci_dev(uhci)));
 
 	if (uhci->state == UHCI_SUSPENDED) {
 
diff -puN drivers/pcmcia/yenta_socket.c~resume_call_pci_enable_device drivers/pcmcia/yenta_socket.c
--- 2.5/drivers/pcmcia/yenta_socket.c~resume_call_pci_enable_device	2005-01-20 14:06:32.568281120 +0800
+++ 2.5-root/drivers/pcmcia/yenta_socket.c	2005-01-20 14:07:23.850485040 +0800
@@ -1057,6 +1057,7 @@ static int yenta_dev_resume (struct pci_
 		pci_restore_state(dev);
 		pci_write_config_dword(dev, 16*4, socket->saved_state[0]);
 		pci_write_config_dword(dev, 17*4, socket->saved_state[1]);
+		pci_enable_device(dev);
 
 		if (socket->type && socket->type->restore_state)
 			socket->type->restore_state(socket);
diff -puN drivers/net/b44.c~resume_call_pci_enable_device drivers/net/b44.c
--- 2.5/drivers/net/b44.c~resume_call_pci_enable_device	2005-01-20 14:35:17.696021840 +0800
+++ 2.5-root/drivers/net/b44.c	2005-01-20 14:35:44.457953408 +0800
@@ -1930,6 +1930,7 @@ static int b44_resume(struct pci_dev *pd
 	struct b44 *bp = netdev_priv(dev);
 
 	pci_restore_state(pdev);
+	pci_enable_device(pdev);
 
 	if (!netif_running(dev))
 		return 0;
_




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
