From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Subject: Re: [Qemu-devel] [PATCH 33/35] pc: ACPI BIOS: reserve SRAT entry for
 hotplug mem hole
Date: Mon, 2 Jun 2014 16:29:32 +0200
Message-ID: <20140602142932.GA20120@dhcp-192-168-178-175.profitbricks.localdomain>
References: <20140414184442.6ff3e626@nial.usersys.redhat.com>
 <20140505155915.GB8574@dhcp-192-168-178-175.profitbricks.localdomain>
 <20140506015239.GA3722@G08FNSTD100614.fnst.cn.fujitsu.com>
 <20140506130028.GB5326@dhcp-192-168-178-175.profitbricks.localdomain>
 <CAM4NYE8WjH-AhEAv9h8Z14+g3XutfEDM8UYFHtDUF7iR4jAOUg@mail.gmail.com>
 <20140528100722.01b59a48@nial.usersys.redhat.com>
 <20140528122312.GA4730@dhcp-192-168-178-175.profitbricks.localdomain>
 <20140528152642.108cb193@nial.usersys.redhat.com>
 <20140528163813.GB28017@dhcp-192-168-178-175.profitbricks.localdomain>
 <20140529111237.7d775371@nial.usersys.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:56947 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133AbaFBO3k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jun 2014 10:29:40 -0400
Received: by mail-wi0-f171.google.com with SMTP id cc10so4626546wib.10
        for <linux-acpi@vger.kernel.org>; Mon, 02 Jun 2014 07:29:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140529111237.7d775371@nial.usersys.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com, aik@ozlabs.ru, Hu Tao <hutao@cn.fujitsu.com>, mjt@tls.msk.ru, qemu-devel <qemu-devel@nongnu.org>, lcapitulino@redhat.com, kraxel@redhat.com, akong@redhat.com, quintela@redhat.com, armbru@redhat.com, aliguori@amazon.com, jan.kiszka@siemens.com, lersek@redhat.com, ehabkost@redhat.com, marcel.a@redhat.com, stefanha@redhat.com, Anshul Makkar <anshul.makkar@profitbricks.com>, chegu_vinod@hp.com, rth@twiddle.net, kwolf@redhat.com, s.priebe@profihost.ag, mreitz@redhat.com, pbonzini@redhat.com, afaerber@suse.de, linux-acpi@vger.kernel.org

On Thu, May 29, 2014 at 11:12:37AM +0200, Igor Mammedov wrote:
> On Wed, 28 May 2014 18:38:13 +0200
> Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com> wrote:
> 
> > On Wed, May 28, 2014 at 03:26:42PM +0200, Igor Mammedov wrote:
> > > On Wed, 28 May 2014 14:23:13 +0200
> > > Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com> wrote:
> > > 
> > > > On Wed, May 28, 2014 at 10:07:22AM +0200, Igor Mammedov wrote:
> > > > > On Tue, 27 May 2014 17:57:31 +0200
> > > > > Anshul Makkar <anshul.makkar@profitbricks.com> wrote:
> > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > I tested the hot unplug patch and doesn't seem to work properly with Debian
> > > > > > 6 and Ubuntu host.
> > > > > > 
> > > > > > Scenario:
> > > > > > I added 3 dimm devices of 1G each:
> > > > > > 
> > > > > > object_add memory-ram,id=ram0,size=1G, device_add dimm,id=dimm1,memdev=ram0
> > > > > > 
> > > > > > object_add memory-ram,id=ram1,size=1G, device_add dimm,id=dimm2,memdev=ram1
> > > > > > 
> > > > > > object_add memory-ram,id=ram2,size=1G, device_add dimm,id=dimm3,memdev=ram2
> > > > > > 
> > > > > > device_del dimm3: I get the OST EVENT EJECT 0x3 and OST STATUS as 0x84(IN
> > > > > > PROGRESS) If I check on the guest, the device has been successfully
> > > > > > removed. But no OST EJECT SUCCESS event was received.
> > > > > I think there should be a SUCCESS event,
> > > > > it should be investigated from the guest side first, OST support in kernel
> > > > > is relatively new.
> > > > 
> > > > When testing older guest kernel (3.11), _OST success events are not sent
> > > > from the guest. I haven't tried newer versions yet.
> > > > 
> > > > In terms of OSPM _OST behaviour, I am not sure if returning OST success status
> > > > on succcesful removal is *required*. Figure 6-37, page 306 of ACPI spec5.0
> > > > shows that on succcesfull OS ejection ejection, _EJ0 is evaluated. Evaluating
> > > > _OST does not seem to be a requirement, is it? (cc'ing linux-acpi for input)
> > > > 
> > > > In linux guests, on successful removal, _EJ0 is always evaluated. I believe we
> > > > should be handling _EJ0 and doing the dimm removal (object_unparent) there.
> > > > Currently OST successes are never received and dimm devices remain in QEMU even
> > > > when successfully ejected from guest.
> > > > E.g. a quick patch for _EJ0 handling, on top of Hu Tao's series:
> > > > 
> The same register [0x14] is control register when writing there, so we can use-reuse
> the same bit position as MRMV for signaling QEMU to perform eject on writing 1 there,
> similarly like it's done for insert event.

thanks, on a closer look that makes sense. MRMV is sufficient, example patch
below.

With the new "query-acpi-ospm-status" we can read OST status from QMP. However
as I mentioned, on succesful removal, the guest kernel does not send the OST success
status (0x0).

This leads to the scenario where memory device is succesfully ejected, _EJ0 is
evaluated in guest and device is deleted in qemu (with the patch below). The
dimm will no longer show up in "query-memory-devices", however the ospm status
of the dimm slot will still remain  at 0x84 (ejection in progress).  This can
be confusing to management layers. Do you have any suggestion for how to
report the succesful _EJ0? We could simply write a succesful status:

  mdev->ost_status = 0x0 

when MRMV is written to, but it is a bit hacky. On the other hand, having another
command only for _EJ0 notification sounds like overkill.

In terms of linux kernel ACPI conformity, Figure 6-37 in the spec implies that
_OST evaluation is not required after succesfull _EJ0 evaluation. Also see
relevant comment in drivers/acpi/scan.c: acpi_scan_hot_remove() line 378
(3.15-rc8):
    /*
    * Verify if eject was indeed successful.  If not, log an error
    * message.  No need to call _OST since _EJ0 call was made
    * OK.
    */



acpi, memory-hotplug: Add _EJ0 handling

---
 docs/specs/acpi_mem_hotplug.txt |    3 ++-
 hw/acpi/memory_hotplug.c        |    9 +++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/docs/specs/acpi_mem_hotplug.txt b/docs/specs/acpi_mem_hotplug.txt
index 1290994..4501774 100644
--- a/docs/specs/acpi_mem_hotplug.txt
+++ b/docs/specs/acpi_mem_hotplug.txt
@@ -35,7 +35,8 @@ Memory hot-plug interface (IO port 0xa00-0xa17, 1-4 byte access):
               1: if set to 1 clears device insert event, set by OSPM
                  after it has emitted device check event for the
                  selected memory device
-              2-7: reserved, OSPM must clear them before writing to register
+              2: Device no longer used by guest, can be safely removed	 
+              3-7: reserved, OSPM must clear them before writing to register
 
 Selecting memory device slot beyond present range has no effect on platform:
    - write accesses to memory hot-plug registers not documented above are
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 8aa829d..24989d3 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -93,9 +93,6 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
         case 0x03: /* EJECT */
             switch (mdev->ost_status) {
             case 0x0: /* SUCCESS */
-                object_unparent(OBJECT(mdev->dimm));
-                mdev->is_removing = false;
-                mdev->dimm = NULL;
                 break;
             case 0x1: /* FAILURE */
             case 0x2: /* UNRECOGNIZED NOTIFY */
@@ -115,9 +112,6 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
         case 0x103: /* OSPM EJECT */
             switch (mdev->ost_status) {
             case 0x0: /* SUCCESS */
-                object_unparent(OBJECT(mdev->dimm));
-                mdev->is_removing = false;
-                mdev->dimm = NULL;
                 break;
             case 0x84: /* EJECTION IN PROGRESS */
                 mdev->is_enabled = false;
@@ -135,6 +129,9 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
             trace_mhp_acpi_clear_insert_evt(mem_st->selector);
         } else if (data & 4) { /* MRMV */
             mdev->is_enabled = false;
+            object_unparent(OBJECT(mdev->dimm));
+            mdev->is_removing = false;
+            mdev->dimm = NULL;
         }
         break;
     }

