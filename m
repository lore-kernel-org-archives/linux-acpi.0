From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH -next] acpi utmisc: use WARN_ON() instead of warn_on_slowpath()
Date: Tue, 8 Jul 2008 17:44:51 +0200
Message-ID: <200807081744.53992.trenn@suse.de>
References: <20080701103339.b5acc1f3.randy.dunlap@oracle.com> <4871B55C.7040009@firstfloor.org> <20080707000320.25341603@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080707000320.25341603@infradead.org>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <andi@firstfloor.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, randy.dunlap@oracle.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Monday 07 July 2008 09:03:20 Arjan van de Ven wrote:
> On Mon, 07 Jul 2008 08:19:08 +0200
>
> Andi Kleen <andi@firstfloor.org> wrote:
> > I'm dropping the ACPI part because we're getting too many
> > reports of scary looking backtraces and ACPI exceptions are actually
> > not that exceptional.
>
> when I talked to Len about it he implied/said that these would only
> happen for ACPI code bugs (and not bios bugs).

drivers/acpi/processor_core.c:852:              ACPI_EXCEPTION((AE_INFO, status,
drivers/acpi/processor_core.c-853-                              "Processor Device is not present"));

and

drivers/acpi/parser/psloop.c-895-                                       if (status == AE_AML_NO_RETURN_VALUE) {
drivers/acpi/parser/psloop.c:896:                                               ACPI_EXCEPTION((AE_INFO, status,
drivers/acpi/parser/psloop.c-897-                                                               "Invoked method did not return a value"));

do very much look like BIOS bugs.

> Maybe he was 
> overestimating what the code would actually do; if so it would imo be
> well worth splitting out ACPI code assertions versions things that are
> BIOS caused (if only to be able to inform the user more consistently)

You want to split BIOS bug and kernel bug ACPI messages?
This is a good idea.
But this should be started in ACPICA code first.
ACPI_EXCEPTION is an ACPICA interface having an
ACPI_FIRMWARE_BUG for relevant messages would be nice.
There are probably also a lot ACPI_DEBUG_PRINT((ACPI_DB_INFO,
info messages suppressing bugs.
Being able to mark them with a ACPI_FIRMWARE_BUG interface, 
would be great.

As suggested some days ago, I'd like to have an interface in the kernel
to report firmware bugs via printk, netlink, both (or compiled out) to
userspace.
As soon as ACPICA can differ and invoke e.g.
ACPI_FIRMWARE_BUG, it can easily be extended to use a kernel
interface to send firmware bugs to userspace as such.

If you are already working in this area or have suggestions, please let me
know or keep me in CC.
Otherwise I will try to come up with some patches sooner or later.

Thanks,

         Thomas

BTW: I saw a lot people used:
ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
again in linux (not ACPICA code!) which is wrong.

These are suppressed if ACPI_DEBUG is not compiled in.
It does not make sense to use a debug interface for errors.
IMO ACPI_DB_ERROR and ACPI_DB_WARN
should be reverted or somehow enforced that
it cannot be used in kernel code anymore, maybe they should be renamed
into DB_DEBUG and DB_WHATEVER?

Here these are again used, some look like sever errors (on a first glance),
some not:

grep -n1 DB_ERROR drivers/acpi/*
drivers/acpi/acpi_memhotplug.c-456-             if (result)
drivers/acpi/acpi_memhotplug.c:457:                     ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
drivers/acpi/acpi_memhotplug.c-458-                             "Error in acpi_memory_enable_device\n"));
--
drivers/acpi/cm_sbs.c-54-       } else {
drivers/acpi/cm_sbs.c:55:               ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
drivers/acpi/cm_sbs.c-56-                                 "Cannot create %s\n", ACPI_AC_CLASS));
--
drivers/acpi/cm_sbs.c-85-       } else {
drivers/acpi/cm_sbs.c:86:               ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
drivers/acpi/cm_sbs.c-87-                                 "Cannot create %s\n", ACPI_BATTERY_CLASS));
--
drivers/acpi/fan.c-323- if (result) {
drivers/acpi/fan.c:324:         ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
drivers/acpi/fan.c-325-                           "Error reading fan power state\n"));
--
drivers/acpi/osl.c-726- if (!queue_work(queue, &dpc->work)) {
drivers/acpi/osl.c:727:         ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
drivers/acpi/osl.c-728-                   "Call to queue_work() failed.\n"));
--
drivers/acpi/processor_perflib.c-515-   if (!psd || (psd->type != ACPI_TYPE_PACKAGE)) {
drivers/acpi/processor_perflib.c:516:           ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSD data\n"));
drivers/acpi/processor_perflib.c-517-           result = -EFAULT;
--
drivers/acpi/processor_perflib.c-521-   if (psd->package.count != 1) {
drivers/acpi/processor_perflib.c:522:           ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSD data\n"));
drivers/acpi/processor_perflib.c-523-           result = -EFAULT;
--
drivers/acpi/processor_perflib.c-534-   if (ACPI_FAILURE(status)) {
drivers/acpi/processor_perflib.c:535:           ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSD data\n"));
drivers/acpi/processor_perflib.c-536-           result = -EFAULT;
--
drivers/acpi/processor_perflib.c-540-   if (pdomain->num_entries != ACPI_PSD_REV0_ENTRIES) {
drivers/acpi/processor_perflib.c:541:           ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _PSD:num_entries\n"));
drivers/acpi/processor_perflib.c-542-           result = -EFAULT;
--
drivers/acpi/processor_perflib.c-546-   if (pdomain->revision != ACPI_PSD_REV0_REVISION) {
drivers/acpi/processor_perflib.c:547:           ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _PSD:revision\n"));
drivers/acpi/processor_perflib.c-548-           result = -EFAULT;
--
drivers/acpi/processor_throttling.c-530-        if (!tsd || (tsd->type != ACPI_TYPE_PACKAGE)) {
drivers/acpi/processor_throttling.c:531:                ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _TSD data\n"));
drivers/acpi/processor_throttling.c-532-                result = -EFAULT;
--
drivers/acpi/processor_throttling.c-536-        if (tsd->package.count != 1) {
drivers/acpi/processor_throttling.c:537:                ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _TSD data\n"));
drivers/acpi/processor_throttling.c-538-                result = -EFAULT;
--
drivers/acpi/processor_throttling.c-549-        if (ACPI_FAILURE(status)) {
drivers/acpi/processor_throttling.c:550:                ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _TSD data\n"));
drivers/acpi/processor_throttling.c-551-                result = -EFAULT;
--
drivers/acpi/processor_throttling.c-555-        if (pdomain->num_entries != ACPI_TSD_REV0_ENTRIES) {
drivers/acpi/processor_throttling.c:556:                ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _TSD:num_entries\n"));
drivers/acpi/processor_throttling.c-557-                result = -EFAULT;
--
drivers/acpi/processor_throttling.c-561-        if (pdomain->revision != ACPI_TSD_REV0_REVISION) {
drivers/acpi/processor_throttling.c:562:                ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _TSD:revision\n"));
drivers/acpi/processor_throttling.c-563-                result = -EFAULT;
--
drivers/acpi/scan.c-467-        if(result)
drivers/acpi/scan.c:468:                ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error creating sysfs interface for device %s\n", device->dev.bus_id));
drivers/acpi/scan.c-469-
--
drivers/acpi/thermal.c-1174-    if (ACPI_FAILURE(status)) {
drivers/acpi/thermal.c:1175:            ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
drivers/acpi/thermal.c-1176-                            "Error attaching device data\n"));
--
drivers/acpi/video.c-1532-              if (ACPI_FAILURE(status)) {
drivers/acpi/video.c:1533:                      ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
drivers/acpi/video.c-1534-                                        "Error installing notify handler\n"));
--
drivers/acpi/video.c-2005-      if (ACPI_FAILURE(status)) {
drivers/acpi/video.c:2006:              ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
drivers/acpi/video.c-2007-                                "Error installing notify handler\n"));
