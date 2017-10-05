From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] ACPI / LPIT: Add Low Power Idle Table (LPIT) support
Date: Thu, 05 Oct 2017 14:48:05 -0700
Message-ID: <1507240085.53049.130.camel@linux.intel.com>
References: <1507227395-64204-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <CAHp75Vcm1K_Tg0wZx9HXXLEOjHw__2LWrBEM75icadcx_z0SxA@mail.gmail.com>
         <1507236213.53049.127.camel@linux.intel.com>
         <45679781.fRGPut79My@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7023 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbdJEVsG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Oct 2017 17:48:06 -0400
In-Reply-To: <45679781.fRGPut79My@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2017-10-05 at 22:56 +0200, Rafael J. Wysocki wrote:
> On Thursday, October 5, 2017 10:43:33 PM CEST Srinivas Pandruvada
> wrote:
> > 
> > On Thu, 2017-10-05 at 21:39 +0300, Andy Shevchenko wrote:
> > > 
> > > On Thu, Oct 5, 2017 at 9:16 PM, Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > 
> > > > 
> > > > Added functionality to read LPIT table, which provides:
> > > > 
> > > > - Sysfs interface to read residency counters via
> > > > /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> > > > /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency
> > > > _us
> > > > 
> > > > Here the count "low_power_idle_cpu_residency_us" shows the time
> > > > spent
> > > > by CPU package in low power state. This is read via MSR
> > > > interface,
> > > > which
> > > > points to MSR for PKG C10.
> > > > 
> > > > Here the count "low_power_idle_system_residency_us" show the
> > > > count
> > > > the
> > > > system was in low power state. This is read via MMIO interface.
> > > > This
> > > > is mapped to SLP_S0 residency on modern Intel systems. This
> > > > residency
> > > > is achieved only when CPU is in PKG C10 and all functional
> > > > blocks
> > > > are
> > > > in low power state.
> > > > 
> > > > It is possible that none of the above counters present or
> > > > anyone of
> > > > the
> > > > counter present or all counters present.
> > > > 
> > > > For example: On my Kabylake system both of the above counters
> > > > present.
> > > > After suspend to idle these counts updated and prints:
> > > > 6916179
> > > > 6998564
> > > > 
> > > > This counter can be read by tools like turbostat to display. Or
> > > > it
> > > > can
> > > > be used to debug, if modern systems are reaching desired low
> > > > power
> > > > state.
> > > > 
> > > > - Provides an interface to read residency counter memory
> > > > address
> > > > This address can be used to get the base address of PMC memory
> > > > mapped IO.
> > > > This is utilized by intel_pmc_core driver to print more debug
> > > > information.
> > > 
> > > > 
> > > > 
> > > > +               switch (residency_info_mem.gaddr.bit_width) {
> > > > +               case 8:
> > > > +                       count =
> > > > readb(residency_info_mem.iomem_addr);
> > > > +                       break;
> > > > +               case 16:
> > > > +                       count =
> > > > readw(residency_info_mem.iomem_addr);
> > > > +                       break;
> > > > +               case 32:
> > > > +                       count =
> > > > readl(residency_info_mem.iomem_addr);
> > > > +                       break;
> > > > +               case 64:
> > > > +                       count =
> > > > readq(residency_info_mem.iomem_addr);
> > > > +                       break;
> > > > +               default:
> > > > +                       return -EINVAL;
> > > > +               }
> > > 
> > > I saw something very similar already under drivers/acpi. Can we
> > > utilize it (split a helper out of it and re-use)?
> > This functionality is probably not only for ACPI, but may be other
> > parts of the kernel too. So if there is a common function then it
> > can
> > be more generic outside of ACPI.
> 
> If the value of the field is a GAS, we can use the ACPICA's library
> routine for reading from there I suppose.
> 
Something like this? Only it the prototype is in a header file, with
some defines for ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_read_memory


diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index db78d35..1b6ce24 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -663,6 +663,29 @@ acpi_status acpi_os_write_port(acpi_io_address
port, u32 value, u32 width)
 
 EXPORT_SYMBOL(acpi_os_write_port);
 
+acpi_status acpi_os_read_iomem(void __iomem *virt_addr, u64 *value,
u32 width)
+{
+
+       switch (width) {
+       case 8:
+               *(u8 *) value = readb(virt_addr);
+               break;
+       case 16:
+               *(u16 *) value = readw(virt_addr);
+               break;
+       case 32:
+               *(u32 *) value = readl(virt_addr);
+               break;
+       case 64:
+               *(u64 *) value = readq(virt_addr);
+               break;
+       default:
+               return AE_ERROR;
+       }
+
+       return AE_OK;
+}
+
 acpi_status
 acpi_os_read_memory(acpi_physical_address phys_addr, u64 *value, u32
width)
 {
@@ -684,22 +707,8 @@ acpi_os_read_memory(acpi_physical_address
phys_addr, u64 *value, u32 width)
        if (!value)
                value = &dummy;
 
-       switch (width) {
-       case 8:
-               *(u8 *) value = readb(virt_addr);
-               break;
-       case 16:
-               *(u16 *) value = readw(virt_addr);
-               break;
-       case 32:
-               *(u32 *) value = readl(virt_addr);
-               break;
-       case 64:
-               *(u64 *) value = readq(virt_addr);
-               break;
-       default:
+       if (acpi_os_read_iomem(virt_addr, value, width) != AE_OK)
                BUG();
-       }
 
        if (unmap)
                iounmap(virt_addr);
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index c66eb8f..6377e2d 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -287,7 +287,10 @@ acpi_status acpi_os_write_port(acpi_io_address
address, u32 value, u32 width);
 /*
  * Platform and hardware-independent physical memory interfaces
  */
+acpi_status acpi_os_read_iomem(void __iomem *virt_addr, u64 *value,
u32 width);
+
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_read_memory
+acpi_status acpi_os_read_iomem(void __iomem *virt_addr, u64 *value,
u32 width);
 acpi_status
 acpi_os_read_memory(acpi_physical_address address, u64 *value, u32
width);
 #endif



> Thanks,
> Rafael
> 
