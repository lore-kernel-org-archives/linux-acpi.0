From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/42] ACPICA: 20151218 Release
Date: Fri, 01 Jan 2016 04:24:10 +0100
Message-ID: <24222450.mn47mdVdOl@vostro.rjw.lan>
References: <cover.1451367388.git.lv.zheng@intel.com> <3226201.pfN5a5dCCW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3226201.pfN5a5dCCW@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, January 01, 2016 04:04:47 AM Rafael J. Wysocki wrote:
> On Tuesday, December 29, 2015 01:52:19 PM Lv Zheng wrote:
> > The 20151218 ACPICA kernel-resident subsystem updates are linuxized based
> > on the linux-pm/linux-next branch.
> > 
> > The patchset has passed the following build/boot tests.
> > Build tests are performed as follows:
> > 1. i386 + allyes
> > 2. i386 + allno
> > 3. i386 + default + ACPI_DEBUGGER=y
> > 4. i386 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
> > 5. i386 + default + ACPI_DEBUG=n + ACPI=y
> > 6. i386 + default + ACPI=n
> > 7. x86_64 + allyes
> > 8. x86_64 + allno
> > 9. x86_64 + default + ACPI_DEBUGGER=y
> > 10.x86_64 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
> > 11.x86_64 + default + ACPI_DEBUG=n + ACPI=y
> > 12.x86_64 + default + ACPI=n
> > Boot tests are performed as follows:
> > 1. i386 + default + ACPI_DEBUGGER=y
> > 2. x86_64 + default + ACPI_DEBUGGER=y
> > Where:
> > 1. i386: machine named as "Dell Inspiron Mini 1010"
> > 2. x86_64: machine named as "HP Compaq 8200 Elite SFF PC"
> > 3. default: kernel configuration with following items enabled:
> >    All hardware drivers related to the machines of i386/x86_64
> >    All "drivers/acpi" configurations
> >    All "drivers/platform" drivers
> >    All other drivers that link the APIs provided by ACPICA subsystem
> > 
> > The divergences checking result:
> > Before applying (20150930 Release):
> >   517 lines
> > After applying (20151218 Release):
> >   506 lines
> > 
> > Bob Moore (25):
> >   ACPICA: exmutex: General cleanup, restructured some code
> >   ACPICA: Core: Major update for code formatting, no functional changes
> >   ACPICA: Split interpreter tracing functions to a new file
> >   ACPICA: acpiexec: Add support for AML files containing multiple
> >     tables
> >   ACPICA: Disassembler/tools: Support for multiple ACPI tables in one
> >     file
> >   ACPICA: iasl/acpiexec: Update input file handling and verification
> >   ACPICA: Revert "acpi_get_object_info: Add support for ACPI 5.0 _SUB
> >     method."
> >   ACPICA: Add comment explaining _SUB removal
> >   ACPICA: acpiexec/acpinames: Update for error checking macros
> >   ACPICA: Concatenate operator: Add extensions to support all ACPI
> >     objects
> >   ACPICA: Debug Object: Cleanup output
> >   ACPICA: Debug object: Fix output for a NULL object
> >   ACPICA: Update for output of the Debug Object
> >   ACPICA: getopt: Comment update, no functional change
> >   ACPICA: Add new exception code, AE_IO_ERROR
> >   ACPICA: iasl/Disassembler: Support ASL ElseIf operator
> >   ACPICA: Parser: Add constants for internal namepath function
> >   ACPICA: Parser: Fix for SuperName method invocation
> >   ACPICA: Update parameter type for ObjectType operator
> >   ACPICA: Update internal #defines for ObjectType operator. No
> >     functional change
> >   ACPICA: Update for CondRefOf and RefOf operators
> >   ACPICA: Cleanup code related to the per-table module level
> >     improvement
> >   ACPICA: Add "root node" case to the ACPI name repair code
> >   ACPICA: Add per-table execution of module-level code
> >   ACPICA: Update version to 20151218
> > 
> > Colin Ian King (1):
> >   ACPICA: Tools: Add spacing and missing options in acpibin tool
> > 
> > David E. Box (1):
> >   ACPICA: Fix SyncLevel support interaction with method
> >     auto-serialization
> > 
> > LABBE Corentin (1):
> >   ACPICA: Add "const" to some functions that return fixed strings
> > 
> > Lv Zheng (12):
> >   ACPICA: Linuxize: reduce divergences for 20151218 release
> >   ACPICA: Namespace: Fix wrong error log
> >   ACPICA: Debugger: reduce old external path format
> >   ACPICA: Namespace: Add scope information to the simple object repair
> >     mechanism
> >   ACPICA: Namespace: Add String -> ObjectReference conversion support
> >   ACPICA: Events: Deploys acpi_ev_find_region_handler()
> >   ACPICA: Events: Uses common_notify for address space handlers
> >   ACPICA: Utilities: Reorder initialization code
> >   ACPICA: Events: Fix an issue that region object is re-attached to
> >     another scope when it is already attached
> >   ACPICA: Events: Split acpi_ev_associate_reg_method() from region
> >     initialization code
> >   ACPICA: Events: Enhance acpi_ev_execute_reg_method() to ensure no
> >     _REG evaluations can happen during OS early boot stages
> >   ACPICA: Events: Introduce ACPI_REG_DISCONNECT invocation to
> >     acpi_ev_execute_reg_methods()
> > 
> > Markus Elfring (1):
> >   ACPICA: Debugger: Remove some unecessary NULL checks
> > 
> > Prarit Bhargava (1):
> >   ACPICA: acpi_get_sleep_type_data: Reduce warnings
> 
> Can you please send patch [8/42] again to me to the address I'm sending this
> message from?
> 
> It seems that it didn't make it to the mailing lists.

OK, found it.

Thanks,
Rafael
