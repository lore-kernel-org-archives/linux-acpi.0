From: Len Brown <lenb@kernel.org>
Subject: [GIT PATCH] ACPI patches for 2.6.23-rc2
Date: Sun, 12 Aug 2007 02:08:25 -0400
Message-ID: <200708120208.25658.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47838 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbXHLGIg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Aug 2007 02:08:36 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

please pull from:=20

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git r=
elease

This will update the files shown below.

thanks!

-Len

ps. individual patches are available on linux-acpi@vger.kernel.org
and a consolidated plain patch is available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/=
2.6.23/acpi-release-20070126-2.6.23-rc2.diff.gz

 Documentation/kernel-parameters.txt         |   22 ++
 Documentation/thinkpad-acpi.txt             |    4=20
 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c |   41 +---
 drivers/acpi/asus_acpi.c                    |    1=20
 drivers/acpi/battery.c                      |   47 +----
 drivers/acpi/bay.c                          |    2=20
 drivers/acpi/dock.c                         |    6=20
 drivers/acpi/ec.c                           |  113 +++++-------
 drivers/acpi/event.c                        |    2=20
 drivers/acpi/processor_idle.c               |   14 +
 drivers/acpi/processor_perflib.c            |    6=20
 drivers/acpi/sbs.c                          |    6=20
 drivers/acpi/tables/tbxface.c               |   23 ++
 drivers/acpi/thermal.c                      |  143 ++++++++++++++--
 drivers/char/sonypi.c                       |    7=20
 drivers/misc/Kconfig                        |   22 +-
 drivers/misc/sony-laptop.c                  |    7=20
 drivers/misc/thinkpad_acpi.c                |   10 -
 drivers/misc/thinkpad_acpi.h                |    2=20
 include/acpi/processor.h                    |    2=20
 20 files changed, 311 insertions(+), 169 deletions(-)

through these commits:

Adrian Bunk (4):
      sony-laptop: sony_nc_ids[] can become static.
      ACPI: EC: acpi_ec_remove(): fix use-after-free
      ACPI: sbs: remove dead code
      ACPI: static

Alexey Starikovskiy (5):
      ACPI: EC: Remove noisy debug printk fron EC driver.
      ACPI: Battery: Synchronize battery operations.
      ACPI: EC: If ECDT is not found, look up EC in DSDT.
      ACPI: EC: Switch from boot_ec as soon as we find its desc in DSDT=
=2E
      ACPI EC: remove potential deadlock from EC

Eugene Teo (1):
      sonypi: fix ids member of struct acpi_driver

=46enghua Yu (1):
      acpi-cpufreq: Fix some x86/x86-64 acpi-cpufreq driver issues

Henrique de Moraes Holschuh (3):
      ACPI: thinkpad-acpi: fix the module init failure path
      ACPI: thinkpad-acpi: change thinkpad-acpi input default and kconf=
ig help
      ACPI: thinkpad-acpi: fix sysfs paths in documentation

Holger Macht (1):
      ACPI: dock: Send key=3Dvalue pair instead of plain value

Jesper Juhl (1):
      asus_acpi: fix possible double free (found by Coverity)

Len Brown (8):
      ACPI: add "acpi_no_auto_ssdt" bootparam
      ACPI: EC: fix build warning
      ACPI: thermal: create "thermal.off=3D1" to disable ACPI thermal s=
upport
      ACPI: thermal: expose "thermal.tzp=3D" to set global polling freq=
uency
      ACPI: thermal: create "thermal.psv=3D" to override passive trip p=
oints
      ACPI: thermal: create "thermal.nocrt" to disable critical actions
      ACPI: thermal: create "thermal.act=3D" to disable or override act=
ive trip point
      ACPI: thermal: add DMI hooks to handle AOpen's broken Award BIOS

Mattia Dongili (1):
      sony-laptop: restore the last user requested brightness level on =
resume.

Meelis Roos (1):
      ACPI: EC: fix run-together printk lines

Stephan Berberig (1):
      ACPI: bay: send envp with uevent - fix

Venki Pallipadi (1):
      ACPI: fix "Time Problems with 2.6.23-rc1-gf695baf2"

with this log:

commit 4e54e9f4423a86aa21b70cb9d339cb09f275188f
Merge: 27196c3... bc90a01...
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:21:22 2007 -0400

    Pull sbs into release branch

commit 27196c30db1ed4ab09c2071149b3324a1a53cfb9
Merge: ad17b20... 5010929...
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:21:08 2007 -0400

    Pull processor into release branch

commit ad17b209dca860a570e4ca75312c9f4d32672402
Merge: d88da66... e13d874...
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:20:59 2007 -0400

    Pull fluff into release branch

commit d88da66f9397f06f3a7b4e5148bd5e71cb9d7952
Merge: 6712a4f... 199e9e7...
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:20:41 2007 -0400

    Pull ec into release branch

commit 6712a4fbb14a466d259e53a5314d8011ecab3d7b
Merge: d8dd3cb... 66b5682...
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:20:33 2007 -0400

    Pull dock-bay into release branch

commit d8dd3cbcf1b30c315a28f65cb719bb2d7105a317
Merge: fc0dc4d... 0b5bfa1...
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:19:23 2007 -0400

    Pull bugzilla-8842 into release branch

commit fc0dc4d3aa9c73e275accf2966e0bdf16bff45f1
Merge: 53fdc51... 3bd92ba...
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:18:11 2007 -0400

    Pull bugzilla-8768 into release branch

commit 53fdc5185c994ad6def3729a905ac4a47c477c9d
Merge: 3b6919e... 67effe8...
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:17:59 2007 -0400

    Pull bugzilla-3774 into release branch

commit 3b6919e536865703a0d5c823f5a34c86cedd07cf
Merge: 3864e8c... de47b69... f7b88cc... 9de1cc4...
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:17:12 2007 -0400

    pull asus sony thinkpad into release branch

commit 0b5bfa1cbefdc6e4c60f30ed545389b5ffe0f75f
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:13:02 2007 -0400

    ACPI: thermal: add DMI hooks to handle AOpen's broken Award BIOS
   =20
    Use DMI to:
    1. enable polling (BIOS thermal events are broken)
    2. disable active trip points (BIOS fan control is broken)
    3. disable passive trip point (BIOS hard-codes it too low)
   =20
    The actual temperature reading does work,
    and with the aid of polling, the critical
    trip point should work too.
   =20
    http://bugzilla.kernel.org/show_bug.cgi?id=3D8842
   =20
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f8707ec9643769957065405b5090e4aa64fd8214
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:12:54 2007 -0400

    ACPI: thermal: create "thermal.act=3D" to disable or override activ=
e trip point
   =20
    thermal.act=3D-1 disables all active trip points
    in all ACPI thermal zones.
   =20
    thermal.act=3DC, where C > 0, overrides all lowest temperature
    active trip points in all thermal zones to C degrees Celsius.
    Raising this trip-point may allow you to keep your system silent
    up to a higher temperature.  However, it will not allow you to
    raise the lowest temperature trip point above the next higher
    trip point (if there is one).  Lowering this trip point may
    kick in the fan sooner.
   =20
    Note that overriding this trip-point will disable any BIOS attempts
    to implement hysteresis around the lowest temperature trip point.
    This may result in the fan starting and stopping frequently
    if temperature frequently crosses C.
   =20
    WARNING: raising trip points above the manufacturer's defaults
    may cause the system to run at higher temperature and shorten
    its life.
   =20
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f54871456162aff557d57bec51639b1288d4a84b
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:12:44 2007 -0400

    ACPI: thermal: create "thermal.nocrt" to disable critical actions
   =20
    thermal.nocrt=3D1 disables actions on _CRT and _HOT
    ACPI thermal zone trip-points.  They will be marked
    as <disabled> in /proc/acpi/thermal_zone/*/trip_points.
   =20
    There are two cases where this option is used:
   =20
    1. Debugging a hot system crossing valid trip point.
   =20
       If your system fan is spinning at full speed,
       be sure that the vent is not clogged with dust.
       Many laptops have very fine thermal fins that are easily blocked=
=2E
   =20
       Check that the processor fan-sink is properly seated,
       has the proper thermal grease, and is really spinning.
   =20
       Check for fan related options in BIOS SETUP.
       Sometimes there is a performance vs quiet option.
       Defaults are generally the most conservative.
   =20
       If your fan is not spinning, yet /proc/acpi/fan/
       has files in it, please file a Linux/ACPI bug.
   =20
       WARNING: you risk shortening the lifetime of your
       hardware if you use this parameter on a hot system.
       Note that this refers to all system components,
       including the disk drive.
   =20
    2. Working around a cool system crossing critical
       trip point due to erroneous temperature reading.
   =20
       Try again with CONFIG_HWMON=3Dn
       There is known potential for conflict between the
       the hwmon sub-system and the ACPI BIOS.
       If this fixes it, notify lm-sensors@lm-sensors.org
       and linux-acpi@vger.kernel.org
   =20
       Otherwise, file a Linux/ACPI bug, or notify
       just linux-acpi@vger.kernel.org.
   =20
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a70cdc5200b0eb9fc3ef64efb29baac9b2cf2431
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:12:35 2007 -0400

    ACPI: thermal: create "thermal.psv=3D" to override passive trip poi=
nts
   =20
    "thermal.psv=3D-1" disables passive trip points
    for all ACPI thermal zones.
   =20
    "thermal.psv=3DC", where 'C' is degrees Celsius,
    overrides all existing passive trip points
    for all ACPI thermal zones.
   =20
    thermal.psv is checked at module load time,
    and in response to trip-point change events.
   =20
    Note that if the system does not deliver thermal zone
    temperature change events near the new trip-point,
    then it will not be noticed.  To force your custom
    trip point to be noticed, you may need to enable polling:
    eg. thermal.tzp=3D3000 invokes polling every 5 minutes.
   =20
    Note that once passive thermal throttling is invoked,
    it has its own internal Thermal Sampling Period (_TSP),
    that is unrelated to _TZP.
   =20
    WARNING: disabling or raising a thermal trip point
    may result in increased running temperature and
    shorter hardware lifetime on some systems.
   =20
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 730ff34de766a6fddee25ac1c32bc49c1a2fd758
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:12:26 2007 -0400

    ACPI: thermal: expose "thermal.tzp=3D" to set global polling freque=
ncy
   =20
    Thermal Zone Polling frequency (_TZP) is an optional ACPI object
    recommending the rate that the OS should poll the associated therma=
l zone.
   =20
    If _TZP is 0, no polling should be used.
    If _TZP is non-zero, then the platform recommends that
    the OS poll the thermal zone at the specified rate.
    The minimum period is 30 seconds.
    The maximum period is 5 minutes.
   =20
    (note _TZP and thermal.tzp units are in deci-seconds,
     so _TZP =3D 300 corresponds to 30 seconds)
   =20
    If _TZP is not present, ACPI 3.0b recommends that the
    thermal zone be polled at an "OS provided default frequency".
   =20
    However, common industry practice is:
    1. The BIOS never specifies any _TZP
    2. High volume OS's from this century never poll any thermal zones
   =20
    Ie. The OS depends on the platform's ability to
    provoke thermal events when necessary, and
    the "OS provided default frequency" is "never":-)
   =20
    There is a proposal that ACPI 4.0 be updated to reflect
    common industry practice -- ie. no _TZP, no polling.
   =20
    The Linux kernel already follows this practice --
    thermal zones are not polled unless _TZP is present and non-zero.
   =20
    But thermal zone polling is useful as a workaround for systems
    which have ACPI thermal control, but have an issue preventing
    thermal events.  Indeed, some Linux distributions still
    set a non-zero thermal polling frequency for this reason.
   =20
    But rather than ask the user to write a polling frequency
    into all the /proc/acpi/thermal_zone/*/polling_frequency
    files, here we simply document and expose the already
    existing module parameter to do the same at system level,
    to simplify debugging those broken platforms.
   =20
    Note that thermal.tzp is a module-load time parameter only.
   =20
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 72b33ef8bb1ac7f6c5a16d23304ab25ddc73d93d
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 00:12:17 2007 -0400

    ACPI: thermal: create "thermal.off=3D1" to disable ACPI thermal sup=
port
   =20
    "thermal.off=3D1" disables all ACPI thermal support at boot time.
   =20
    CONFIG_ACPI_THERMAL=3Dn can do this at build time.
    "# rmmod thermal" can do this at run time,
    as long as thermal is built as a module.
   =20
    WARNING: On some systems, disabling ACPI thermal support
    will cause the system to run hotter and reduce the
    lifetime of the hardware.
   =20
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9de1cc4a1724adda84101912e8ba51460f110044
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Aug 11 00:08:33 2007 -0300

    ACPI: thinkpad-acpi: fix sysfs paths in documentation
   =20
    The documentation used "thinkpad-acpi" to refer to the directories =
in
    sysfs, while it should have been using "thinkpad_acpi".  Thanks to =
Hugh
    Dickins for the error report.
   =20
    I wish I could just call the module and everything else by the prop=
er
    name with the "-", instead of using these ugly translations to "_".
   =20
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Cc: Hugh Dickins <hugh@veritas.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e13d87473284131a7ead8121d5d29345101f68a4
Author: Adrian Bunk <bunk@stusta.de>
Date:   Fri Aug 10 13:45:18 2007 -0700

    ACPI: static
   =20
    Make the needlessly global "acpi_event_seqnum" static.
   =20
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 199e9e7d1106686a85ee9fdf6a824051aa82682e
Author: Alexey Starikovskiy <astarikovskiy@suse.de>
Date:   Fri Aug 10 13:45:18 2007 -0700

    ACPI EC: remove potential deadlock from EC
   =20
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 66b568218ab73be161dc109b913e6fa7dda44e16
Author: Holger Macht <hmacht@suse.de>
Date:   Fri Aug 10 13:10:32 2007 -0700

    ACPI: dock: Send key=3Dvalue pair instead of plain value
   =20
    Send key=3Dvalue pair along with the uevent instead of a plain valu=
e so that
    userspace (udev) can handle it like common environment variables.
   =20
    Signed-off-by: Holger Macht <hmacht@suse.de>
    Acked-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Cc: Stephan Berberig <s.berberig@arcor.de>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7aa763cb56b6efdfa5c1b83c336abf1be914afcd
Author: Stephan Berberig <s.berberig@arcor.de>
Date:   Fri Aug 10 13:10:31 2007 -0700

    ACPI: bay: send envp with uevent - fix
   =20
    There must not be a new-line character in the uevent.  Otherwise, u=
dev gets
    confused.  Thanks to Kay Sievers for pointing it out.
   =20
    Signed-off-by: Stephan Berberig <s.berberig@arcor.de>
    Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 501092929ccb8a1d2eb0ed700e38df4ae0de7108
Author: Fenghua Yu <fenghua.yu@intel.com>
Date:   Tue Aug 7 18:40:30 2007 -0400

    acpi-cpufreq: Fix some x86/x86-64 acpi-cpufreq driver issues
   =20
    This patch addresses some issues in x86/x86-64 acpi-cpufreq driver:
   =20
    1.  Current memory allocation for acpi_perf_data is actually open-c=
oded
       alloc_percpu().  The patch defines and handles acpi_perf_data as=
 percpu
       data.  The code will be cleaner and easier to be maintained with=
 this
       change.
   =20
    2. Won't load driver in acpi_cpufreq_early_init() failure case.
   =20
    3. Add __init for acpi_cpufreq_early_init().
   =20
    Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
    Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Cc: Dave Jones <davej@codemonkey.org.uk>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ed3110efb538d7acbf635095c1382118f7414f75
Author: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Tue Jul 31 12:04:31 2007 -0700

    ACPI: fix "Time Problems with 2.6.23-rc1-gf695baf2"
   =20
    Enable C3 without bm control only for CST based C3.
   =20
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5f70bf7510e5e51b0bac32b1470c92e9332452a4
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sun Aug 5 15:20:45 2007 -0300

    ACPI: thinkpad-acpi: change thinkpad-acpi input default and kconfig=
 help
   =20
    The current kconfig help text was misleading users.  Also, the defa=
ult for
    an input-layer-optimized support caused way too many problems witho=
ut
    up-to-date userspace in place.
   =20
    So, rework the help text, and change the default to N.  Note that
    distributions are supposed to enable this option as soon as they up=
date HAL
    to a version that handles the thinkpad-acpi new input layer interfa=
ce.
   =20
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Cc: Michael S. Tsirkin <mst@dev.mellanox.co.il>
    Cc: Hugh Dickins <hugh@veritas.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0a5245099819b0ae0a8e985f54909ba8414faba5
Author: Meelis Roos <mroos@linux.ee>
Date:   Thu Jul 26 12:56:55 2007 +0300

    ACPI: EC: fix run-together printk lines
   =20
    Signed-off-by: Meelis Roos <mroos@linux.ee>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit bc90a0105dea7b773e99ae7abde56a6930081ddb
Author: Adrian Bunk <bunk@stusta.de>
Date:   Mon Jul 9 11:33:15 2007 -0700

    ACPI: sbs: remove dead code
   =20
    Remove dead code spotted by the Coverity checker.
   =20
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 07ddf768d860bee7bd6581b7af3ce1009dbd05d0
Author: Adrian Bunk <bunk@stusta.de>
Date:   Sun Jul 29 17:00:37 2007 +0200

    ACPI: EC: acpi_ec_remove(): fix use-after-free
   =20
    This patch fixes an obvious use-after-free introduced by
    commit 837012ede14a8fc088be3682c964da7fc6af026b.
   =20
    Spotted by the Coverity checker.
   =20
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7c010de7506954e973abfab5c5999c5a97f7a73e
Author: Alexey Starikovskiy <astarikivskiy@suse.de>
Date:   Fri Aug 3 17:57:53 2007 -0400

    ACPI: EC: Switch from boot_ec as soon as we find its desc in DSDT.
   =20
    Some ASUS laptops fail to use boot time EC
    and need to eventually switch to one described in DSDT.
   =20
    http://bugzilla.kernel.org/show_bug.cgi?id=3D8709
   =20
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 52fe4bdf40bc07498c5f7935551774e8f8458190
Author: Len Brown <len.brown@intel.com>
Date:   Fri Aug 3 17:55:53 2007 -0400

    ACPI: EC: fix build warning
   =20
    drivers/acpi/ec.c:657: warning: =E2=80=98acpi_ec_register_query_met=
hods=E2=80=99 defined but not used
   =20
    Signed-off-by: Len Brown <len.brown@intel.com>

commit cd8c93a4e04dce8f00d1ef3a476aac8bd65ae40b
Author: Alexey Starikovskiy <astarikovskiy@suse.de>
Date:   Fri Aug 3 17:52:48 2007 -0400

    ACPI: EC: If ECDT is not found, look up EC in DSDT.
   =20
    Some ASUS laptops access EC space from device _INI methods, but do =
not
    provide ECDT for early EC setup. In order to make them function pro=
perly,
    there is a need to find EC is DSDT before any _INI is called.
   =20
    Similar functionality was turned on by acpi_fake_ecdt=3D1 command l=
ine
    before. Now it is on all the time.
   =20
    http://bugzilla.kernel.org/show_bug.cgi?id=3D8598
   =20
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3bd92ba19a89fe61ebf58804f9c8675372f50c1c
Author: Alexey Starikovskiy <astarikivskiy@suse.de>
Date:   Fri Aug 3 17:38:20 2007 -0400

    ACPI: Battery: Synchronize battery operations.
   =20
    http://bugzilla.kernel.org/show_bug.cgi?id=3D8768
   =20
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f1cd1fe61b96e4312312d42c0a9784dfab12e007
Author: Alexey Starikovskiy <astarikovskiy@suse.de>
Date:   Fri Aug 3 17:28:17 2007 -0400

    ACPI: EC: Remove noisy debug printk fron EC driver.
   =20
    ACPI: EC: Handler for query 0x57 is not found!
   =20
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit de47b69c7b7be46b0848b2c4f8e23c478cd68690
Author: Jesper Juhl <jesper.juhl@gmail.com>
Date:   Sun Jul 29 00:45:59 2007 +0200

    asus_acpi: fix possible double free (found by Coverity)
   =20
    Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ac36393de6034be7266264a435360e7628849005
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Jul 27 17:04:40 2007 -0300

    ACPI: thinkpad-acpi: fix the module init failure path
   =20
    Thomas Renninger reports that if one tries to load thinkpad-acpi in=
 a
    non-thinkpad, one gets:
   =20
    Call Trace:
     [<ffffffff802fa57d>] kref_get+0x2f/0x36
     [<ffffffff802f97f7>] kobject_get+0x12/0x17
     [<ffffffff8036dfd7>] get_driver+0x14/0x1a
     [<ffffffff8036dfee>] driver_remove_file+0x11/0x32
     [<ffffffff8823b9be>] :thinkpad_acpi:thinkpad_acpi_module_exit+0xa8=
/0xfc
     [<ffffffff8824b8a0>] :thinkpad_acpi:thinkpad_acpi_module_init+0x74=
a/0x776
     [<ffffffff8024f968>] __link_module+0x0/0x25
     [<ffffffff80252269>] sys_init_module+0x162c/0x178f
     [<ffffffff8020bc2e>] system_call+0x7e/0x83
   =20
    So, track if the platform driver and its driver attributes were reg=
istered,
    and only deallocate them in that case.
   =20
    This patch is based on Thomas Renninger's patch for the issue.
   =20
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Acked-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f7b88ccb63188e775fe02e746c39ed177741cfc7
Author: Eugene Teo <eugeneteo@kernel.sg>
Date:   Sat Aug 4 00:22:32 2007 +0900

    sonypi: fix ids member of struct acpi_driver
   =20
    ids member of struct acpi_driver is of type struct acpi_device_id, =
not a
    character array.
   =20
    Signed-off-by: Eugene Teo <eugeneteo@kernel.sg>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 11604ecf6fb9c2ab0152fbddb7ea2724438ef76e
Author: Adrian Bunk <bunk@stusta.de>
Date:   Sat Aug 4 00:22:31 2007 +0900

    sony-laptop: sony_nc_ids[] can become static.
   =20
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e84a02ba0b33a97a8486f3248fd45f50b1a1c014
Author: Mattia Dongili <malattia@linux.it>
Date:   Sat Aug 4 00:22:30 2007 +0900

    sony-laptop: restore the last user requested brightness level on re=
sume.
   =20
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 67effe8fff32f60bdf51cba484766ba6003005bb
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jul 26 00:50:06 2007 -0400

    ACPI: add "acpi_no_auto_ssdt" bootparam
   =20
    "acpi_no_auto_ssdt" prevents Linux from automatically loading
    all the SSDTs listed in the RSDT/XSDT.
   =20
    This is needed for debugging.  In particular,
    it allows a DSDT override to optionally be a DSDT+SSDT override.
   =20
    http://bugzilla.kernel.org/show_bug.cgi?id=3D3774
   =20
    Signed-off-by: Len Brown <len.brown@intel.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
