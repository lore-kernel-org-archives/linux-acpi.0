From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/30] ACPICA: 20160318 Release
Date: Mon, 11 Jul 2016 16:54:23 +0200
Message-ID: <2028972.srOPqn9oUn@vostro.rjw.lan>
References: <cover.1458714002.git.lv.zheng@intel.com> <5783AF59.8010609@suse.com> <12994353.mX8QG1g2Nk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <12994353.mX8QG1g2Nk@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <mbrugger@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Monday, July 11, 2016 04:48:26 PM Rafael J. Wysocki wrote:
> On Monday, July 11, 2016 04:38:17 PM Matthias Brugger wrote:
> > Hi Rafael,
> > 
> > On 24/03/16 14:08, Rafael J. Wysocki wrote:
> > > On Thu, Mar 24, 2016 at 2:38 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> > >> The 20160318 ACPICA kernel-resident subsystem updates are linuxized based
> > >> on the linux-pm/linux-next branch.
> > >>
> > >> The patchset has passed the following build/boot tests.
> > >> Build tests are performed as follows:
> > >> 1. i386 + allyes
> > >> 2. i386 + allno
> > >> 3. i386 + default + ACPI_DEBUGGER=y
> > >> 4. i386 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
> > >> 5. i386 + default + ACPI_DEBUG=n + ACPI=y
> > >> 6. i386 + default + ACPI=n
> > >> 7. x86_64 + allyes
> > >> 8. x86_64 + allno
> > >> 9. x86_64 + default + ACPI_DEBUGGER=y
> > >> 10.x86_64 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
> > >> 11.x86_64 + default + ACPI_DEBUG=n + ACPI=y
> > >> 12.x86_64 + default + ACPI=n
> > >> Boot tests are performed as follows:
> > >> 1. i386 + default + ACPI_DEBUGGER=y
> > >> 2. x86_64 + default + ACPI_DEBUGGER=y
> > >> Where:
> > >> 1. i386: machine named as "Dell Inspiron Mini 1010"
> > >> 2. x86_64: machine named as "HP Compaq 8200 Elite SFF PC"
> > >> 3. default: kernel configuration with following items enabled:
> > >>     All hardware drivers related to the machines of i386/x86_64
> > >>     All "drivers/acpi" configurations
> > >>     All "drivers/platform" drivers
> > >>     All other drivers that link the APIs provided by ACPICA subsystem
> > >>
> > >> The divergences checking result:
> > >> Before applying (20160212 Release):
> > >>    506 lines
> > >> After applying (20160318 Release):
> > >>    494 lines
> > >>
> > >> Al Stone (1):
> > >>    ACPICA: IORT: Add in support for the SMMUv3 subtable
> > >>
> > >> Aleksey Makarov (1):
> > >>
> > >>
> > >> Bob Moore (16):
> > >>    ACPICA: Headers: Minor update for SPCR ACPI table
> > >>    ACPICA: ACPI 6.1: Updates for the HEST ACPI table
> > >>    ACPICA: ACPI 6.1: Update NFIT table for additional new fields
> > >>    ACPICA: Headers: Update DMAR table for October 2014 I/O spec
> > >>    ACPICA: Tables: Update FADT handling
> > >>    ACPICA: ACPI 6.1: Add full support for this version of ACPI spec
> > >>    ACPICA: iASL/Headers: Fix incorrect definition of FPDT table
> > >>    ACPICA: Intepreter: Add object extensions to Concatenate operand
> > >>    ACPICA: Interpreter: Update some function headers, no functional
> > >>      change
> > >>    ACPICA: iASL: Cleanup/optimization for ToPLD macro support
> > >>    ACPICA: Cleanup some invocation indentations, no functional change
> > >>    ACPICA: Headers: Update generation of the ACPICA library
> > >>    ACPICA: Utilities: Update for strtoul64 merger
> > >>    ACPICA: All: const keyword changes across the ACPICA source
> > >>    ACPICA: iASL/Disassembler: Improve handling of unresolved methods
> > >>    ACPICA: Update version to 20160318
> > >>
> > >> Lv Zheng (11):
> > >>    ACPICA: Linuxize: reduce divergences for 20160212 release
> > >>    ACPICA: Linuxize: Remove useless platform headers
> > >>    ACPICA: Utilities: Add ACPI_IS_POWER_OF_TWO()
> > >>    Utilities: Fix missing parentheses in ACPI_GET_BITS()/ACPI_SET_BITS()
> > >>    ACPICA: Hardware: Enhance acpi_hw_validate_register() with
> > >>      access_width/bit_offset awareness
> > >>    ACPICA: Hardware: Add access_width/bit_offset support in
> > >>      acpi_hw_read()
> > >>    ACPICA: Hardware: Add access_width/bit_offset support for
> > >>      acpi_hw_write()
> > >>    ACPICA: Interpreter: Fix wrong conditions for
> > >>      acpi_ev_install_region_handlers() invocation
> > >>    ACPICA: Tables: Fix wrong MLC condition for dynamic table loading
> > >>    ACPICA: Events: Fix an issue that _REG association can happen before
> > >>      namespace is initialized
> > >>    ACPICA: Namespace: Reorder \_SB._INI to make sure it is evaluated
> > >>      before _REG evaluations
> > >>
> > >> Will Miles (1):
> > >>    ACPICA: Add support for QNX 6.6 platform
> > >
> > > This is too late to go in during the current merge window, but I'll
> > > queue it up and send a separate pull request for 4.6 with it next
> > > week.
> > >
> > > I'll fix up the whitespace breakage in the first patch (it is easy
> > > enough to fix up manually), but as Len said, please fix the process to
> > > avoid such things in the future.
> > >
> > 
> > I wasn't able to spot this series in linux-next, epsecially patch 03/30:
> > "ACPICA: Headers: Add new constants for the DBG2 ACPI table"
> > 
> > Can you please clarify what happened?
> 
> It was in linux-next.  I'm not sure why you didn't spot it in there.

It wasn't in there before the merge window opened, though, which really
seems to be what your question is about, right?

In this particular case an ACPICA release happened right before the
opening of a merge window and the choice was to either push it regardless
or to defer it to the next merge window.

The latter is not really attractive, though, because it only causes the
delta between upstream ACPICA and the Linux kernel to grow and we get more
stuff in in one go.

Please note, though, that it had spent some time in linux-next during the
merge window before it was pushed.

Thanks,
Rafael
