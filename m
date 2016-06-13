From: Al Stone <al.stone@linaro.org>
Subject: [RESEND PATCH v5 1/1] ARM64: ACPI: Update documentation for latest  specification version
Date: Mon, 13 Jun 2016 15:41:55 -0600
Message-ID: <1465854115-4960-2-git-send-email-al.stone@linaro.org>
References: <1465854115-4960-1-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465854115-4960-1-git-send-email-al.stone@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>
List-Id: linux-acpi@vger.kernel.org

The ACPI 6.1 specification was recently released at the end of January
2016, but the arm64 kernel documentation for the use of ACPI was writte=
n
for the 5.1 version of the spec.  There were significant additions to t=
he
spec that had not yet been mentioned -- for example, the 6.0 mechanisms
added to make it easier to define processors and low power idle states,
as well as the 6.1 addition allowing regular interrupts (not just from
GPIO) be used to signal ACPI general purpose events.

This patch reflects going back through and examining the specs in detai=
l
and updating content appropriately.  Whilst there, a few odds and ends =
of
typos were caught as well.  This brings the documentation up to date wi=
th
ACPI 6.1 for arm64.

Signed-off-by: Al Stone <al.stone@linaro.org>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Roy Franz <roy.franz@hpe.com>
---
 Documentation/arm64/acpi_object_usage.txt | 343 ++++++++++++++++------=
--------
 Documentation/arm64/arm-acpi.txt          |  40 ++--
 2 files changed, 213 insertions(+), 170 deletions(-)

diff --git a/Documentation/arm64/acpi_object_usage.txt b/Documentation/=
arm64/acpi_object_usage.txt
index a6e1a18..c77010c 100644
--- a/Documentation/arm64/acpi_object_usage.txt
+++ b/Documentation/arm64/acpi_object_usage.txt
@@ -13,14 +13,14 @@ For ACPI on arm64, tables also fall into the follow=
ing categories:
=20
        -- Required: DSDT, FADT, GTDT, MADT, MCFG, RSDP, SPCR, XSDT
=20
-       -- Recommended: BERT, EINJ, ERST, HEST, SSDT
+       -- Recommended: BERT, EINJ, ERST, HEST, PCCT, SSDT
=20
-       -- Optional: BGRT, CPEP, CSRT, DRTM, ECDT, FACS, FPDT, MCHI, MP=
ST,
-          MSCT, RASF, SBST, SLIT, SPMI, SRAT, TCPA, TPM2, UEFI
-
-       -- Not supported: BOOT, DBG2, DBGP, DMAR, ETDT, HPET, IBFT, IVR=
S,
-          LPIT, MSDM, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
+       -- Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, IO=
RT,
+          MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT, =
STAO,
+	  TCPA, TPM2, UEFI, XENV
=20
+       -- Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IBFT, IVRS, LPI=
T,
+          MSDM, OEMx, PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
=20
 Table  Usage for ARMv8 Linux
 -----  ---------------------------------------------------------------=
-
@@ -50,7 +50,8 @@ CSRT   Signature Reserved (signature =3D=3D "CSRT")
=20
 DBG2   Signature Reserved (signature =3D=3D "DBG2")
        =3D=3D DeBuG port table 2 =3D=3D
-       Microsoft only table, will not be supported.
+       License has changed and should be usable.  Optional if used ins=
tead
+       of earlycon=3D<device> on the command line.
=20
 DBGP   Signature Reserved (signature =3D=3D "DBGP")
        =3D=3D DeBuG Port table =3D=3D
@@ -133,10 +134,11 @@ GTDT   Section 5.2.24 (signature =3D=3D "GTDT")
=20
 HEST   Section 18.3.2 (signature =3D=3D "HEST")
        =3D=3D Hardware Error Source Table =3D=3D
-       Until further error source types are defined, use only types 6 =
(AER
-       Root Port), 7 (AER Endpoint), 8 (AER Bridge), or 9 (Generic Har=
dware
-       Error Source).  Firmware first error handling is possible if an=
d only
-       if Trusted Firmware is being used on arm64.
+       ARM-specific error sources have been defined; please use those =
or the
+       PCI types such as type 6 (AER Root Port), 7 (AER Endpoint), or =
8 (AER
+       Bridge), or use type 9 (Generic Hardware Error Source).  Firmwa=
re first
+       error handling is possible if and only if Trusted Firmware is b=
eing
+       used on arm64.
=20
        Must be supplied if RAS support is provided by the platform.  I=
t
        is recommended this table be supplied.
@@ -149,20 +151,30 @@ IBFT   Signature Reserved (signature =3D=3D "IBFT=
")
        =3D=3D iSCSI Boot Firmware Table =3D=3D
        Microsoft defined table, support TBD.
=20
+IORT   Signature Reserved (signature =3D=3D "IORT")
+       =3D=3D Input Output Remapping Table =3D=3D
+       arm64 only table, required in order to describe IO topology, SM=
MUs,
+       and GIC ITSs, and how those various components are connected to=
gether,
+       such as identifying which components are behind which SMMUs/ITS=
s.
+       This table will only be required on certain SBSA platforms (e.g=
=2E,
+       when using GICv3-ITS and an SMMU); on SBSA Level 0 platforms, i=
t=20
+       remains optional.
+
 IVRS   Signature Reserved (signature =3D=3D "IVRS")
        =3D=3D I/O Virtualization Reporting Structure =3D=3D
        x86_64 (AMD) only table, will not be supported.
=20
 LPIT   Signature Reserved (signature =3D=3D "LPIT")
        =3D=3D Low Power Idle Table =3D=3D
-       x86 only table as of ACPI 5.1; future versions have been adapte=
d for
-       use with ARM and will be recommended in order to support ACPI p=
ower
-       management.
+       x86 only table as of ACPI 5.1; starting with ACPI 6.0, processo=
r
+       descriptions and power states on ARM platforms should use the D=
SDT
+       and define processor container devices (_HID ACPI0010, Section =
8.4,
+       and more specifically 8.4.3 and and 8.4.4).
=20
 MADT   Section 5.2.12 (signature =3D=3D "APIC")
        =3D=3D Multiple APIC Description Table =3D=3D
        Required for arm64.  Only the GIC interrupt controller structur=
es
-       should be used (types 0xA - 0xE).
+       should be used (types 0xA - 0xF).
=20
 MCFG   Signature Reserved (signature =3D=3D "MCFG")
        =3D=3D Memory-mapped ConFiGuration space =3D=3D
@@ -176,14 +188,38 @@ MPST   Section 5.2.21 (signature =3D=3D "MPST")
        =3D=3D Memory Power State Table =3D=3D
        Optional, not currently supported.
=20
+MSCT   Section 5.2.19 (signature =3D=3D "MSCT")
+       =3D=3D Maximum System Characteristic Table =3D=3D
+       Optional, not currently supported.
+
 MSDM   Signature Reserved (signature =3D=3D "MSDM")
        =3D=3D Microsoft Data Management table =3D=3D
        Microsoft only table, will not be supported.
=20
-MSCT   Section 5.2.19 (signature =3D=3D "MSCT")
-       =3D=3D Maximum System Characteristic Table =3D=3D
+NFIT   Section 5.2.25 (signature =3D=3D "NFIT")
+       =3D=3D NVDIMM Firmware Interface Table =3D=3D
+       Optional, not currently supported.
+
+OEMx   Signature of "OEMx" only
+       =3D=3D OEM Specific Tables =3D=3D
+       All tables starting with a signature of "OEM" are reserved for =
OEM
+       use.  Since these are not meant to be of general use but are li=
mited
+       to very specific end users, they are not recommended for use an=
d are
+       not supported by the kernel for arm64.
+
+PCCT   Section 14.1 (signature =3D=3D "PCCT)
+       =3D=3D Platform Communications Channel Table =3D=3D
+       Recommend for use on arm64; use of PCC is recommended when usin=
g CPPC
+       to control performance and power for platform processors.
+
+PMTT   Section 5.2.21.12 (signature =3D=3D "PMTT")
+       =3D=3D Platform Memory Topology Table =3D=3D
        Optional, not currently supported.
=20
+PSDT   Section 5.2.11.3 (signature =3D=3D "PSDT")
+       =3D=3D Persistent System Description Table =3D=3D
+       Obsolete table, will not be supported.
+
 RASF   Section 5.2.20 (signature =3D=3D "RASF")
        =3D=3D RAS Feature table =3D=3D
        Optional, not currently supported.
@@ -195,7 +231,7 @@ RSDP   Section 5.2.5 (signature =3D=3D "RSD PTR")
 RSDT   Section 5.2.7 (signature =3D=3D "RSDT")
        =3D=3D Root System Description Table =3D=3D
        Since this table can only provide 32-bit addresses, it is depre=
cated
-       on arm64, and will not be used.
+       on arm64, and will not be used.  If provided, it will be ignore=
d.
=20
 SBST   Section 5.2.14 (signature =3D=3D "SBST")
        =3D=3D Smart Battery Subsystem Table =3D=3D
@@ -220,7 +256,7 @@ SPMI   Signature Reserved (signature =3D=3D "SPMI")
 SRAT   Section 5.2.16 (signature =3D=3D "SRAT")
        =3D=3D System Resource Affinity Table =3D=3D
        Optional, but if used, only the GICC Affinity structures are re=
ad.
-       To support NUMA, this table is required.
+       To support arm64 NUMA, this table is required.
=20
 SSDT   Section 5.2.11.2 (signature =3D=3D "SSDT")
        =3D=3D Secondary System Description Table =3D=3D
@@ -235,6 +271,11 @@ SSDT   Section 5.2.11.2 (signature =3D=3D "SSDT")
        These tables are optional, however.  ACPI tables should contain=
 only
        one DSDT but can contain many SSDTs.
=20
+STAO   Signature Reserved (signature =3D=3D "STAO")
+       =3D=3D _STA Override table =3D=3D
+       Optional, but only necessary in virtualized environments in ord=
er to
+       hide devices from guest OSs.
+
 TCPA   Signature Reserved (signature =3D=3D "TCPA")
        =3D=3D Trusted Computing Platform Alliance table =3D=3D
        Optional, not currently supported, and may need changes to full=
y
@@ -266,6 +307,10 @@ WPBT   Signature Reserved (signature =3D=3D "WPBT"=
)
        =3D=3D Windows Platform Binary Table =3D=3D
        Microsoft only table, will not be supported.
=20
+XENV   Signature Reserved (signature =3D=3D "XENV")
+       =3D=3D Xen project table =3D=3D
+       Optional, used only by Xen at present.
+
 XSDT   Section 5.2.8 (signature =3D=3D "XSDT")
        =3D=3D eXtended System Description Table =3D=3D
        Required for arm64.
@@ -273,44 +318,46 @@ XSDT   Section 5.2.8 (signature =3D=3D "XSDT")
=20
 ACPI Objects
 ------------
-The expectations on individual ACPI objects are discussed in the list =
that
-follows:
+The expectations on individual ACPI objects that are likely to be used=
 are
+shown in the list that follows; any object not explicitly mentioned be=
low
+should be used as needed for a particular platform or particular subsy=
stem,
+such as power management or PCI.
=20
 Name   Section         Usage for ARMv8 Linux
 ----   ------------    -----------------------------------------------=
--
-_ADR   6.1.1           Use as needed.
-
-_BBN   6.5.5           Use as needed; PCI-specific.
+_CCA   6.2.17          This method must be defined for all bus masters
+                       on arm64 -- there are no assumptions made about
+                       whether such devices are cache coherent or not.
+                       The _CCA value is inherited by all descendants =
of
+                       these devices so it does not need to be repeate=
d.
+                       Without _CCA on arm64, the kernel does not know=
 what
+                       to do about setting up DMA for the device.
=20
-_BDN   6.5.3           Optional; not likely to be used on arm64.
+                       NB: this method provides default cache coherenc=
y
+                       attributes; the presence of an SMMU can be used=
 to
+                       modify that, however.  For example, a master co=
uld
+                       default to non-coherent, but be made coherent w=
ith
+                       the appropriate SMMU configuration (see Table 1=
7 of
+                       the IORT specification, ARM Document DEN 0049B)=
=2E
=20
-_CCA   6.2.17          This method should be defined for all bus maste=
rs
-                       on arm64.  While cache coherency is assumed, ma=
king
-                       it explicit ensures the kernel will set up DMA =
as
-                       it should.
+_CID   6.1.2           Use as needed, see also _HID.
=20
-_CDM   6.2.1           Optional, to be used only for processor devices=
=2E
+_CLS   6.1.3           Use as needed, see also _HID.
=20
-_CID   6.1.2           Use as needed.
-
-_CLS   6.1.3           Use as needed.
+_CPC   8.4.7.1         Use as needed, power management specific.  CPPC=
 is
+                       recommended on arm64.
=20
 _CRS   6.2.2           Required on arm64.
=20
-_DCK   6.5.2           Optional; not likely to be used on arm64.
+_CSD   8.4.2.2         Use as needed, used only in conjunction with _C=
ST.
+
+_CST   8.4.2.1         Low power idle states (8.4.4) are recommended i=
nstead
+                       of C-states.
=20
 _DDN   6.1.4           This field can be used for a device name.  Howe=
ver,
                        it is meant for DOS device names (e.g., COM1), =
so be
                        careful of its use across OSes.
=20
-_DEP   6.5.8           Use as needed.
-
-_DIS   6.2.3           Optional, for power management use.
-
-_DLM   5.7.5           Optional.
-
-_DMA   6.2.4           Optional.
-
 _DSD   6.2.5           To be used with caution.  If this object is use=
d, try
                        to use it within the constraints already define=
d by the
                        Device Properties UUID.  Only in rare circumsta=
nces
@@ -325,20 +372,10 @@ _DSD   6.2.5           To be used with caution.  =
If this object is used, try
                        with the UEFI Forum; this may cause some iterat=
ion as
                        more than one OS will be registering entries.
=20
-_DSM                   Do not use this method.  It is not standardized=
, the
+_DSM   9.1.1           Do not use this method.  It is not standardized=
, the
                        return values are not well documented, and it i=
s
                        currently a frequent source of error.
=20
-_DSW   7.2.1           Use as needed; power management specific.
-
-_EDL   6.3.1           Optional.
-
-_EJD   6.3.2           Optional.
-
-_EJx   6.3.3           Optional.
-
-_FIX   6.2.7           x86 specific, not used on arm64.
-
 \_GL   5.7.1           This object is not to be used in hardware reduc=
ed
                        mode, and therefore should not be used on arm64=
=2E
=20
@@ -349,35 +386,22 @@ _GLK   6.5.7           This object requires a glo=
bal lock be defined; there
 \_GPE  5.3.1           This namespace is for x86 use only.  Do not use=
 it
                        on arm64.
=20
-_GSB   6.2.7           Optional.
-
-_HID   6.1.5           Use as needed.  This is the primary object to u=
se in
-                       device probing, though _CID and _CLS may also b=
e used.
-
-_HPP   6.2.8           Optional, PCI specific.
-
-_HPX   6.2.9           Optional, PCI specific.
-
-_HRV   6.1.6           Optional, use as needed to clarify device behav=
ior; in
-                       some cases, this may be easier to use than _DSD=
=2E
+_HID   6.1.5           This is the primary object to use in device pro=
bing,
+		       though _CID and _CLS may also be used.
=20
 _INI   6.5.1           Not required, but can be useful in setting up d=
evices
                        when UEFI leaves them in a state that may not b=
e what
                        the driver expects before it starts probing.
=20
-_IRC   7.2.15          Use as needed; power management specific.
-
-_LCK   6.3.4           Optional.
-
-_MAT   6.2.10          Optional; see also the MADT.
+_LPI   8.4.4.3         Recommended for use with processor definitions =
(_HID
+		       ACPI0010) on arm64.  See also _RDI.
=20
-_MLS   6.1.7           Optional, but highly recommended for use in
-                       internationalization.
+_MLS   6.1.7           Highly recommended for use in internationalizat=
ion.
=20
-_OFF   7.1.2           It is recommended to define this method for any=
 device
+_OFF   7.2.2           It is recommended to define this method for any=
 device
                        that can be turned on or off.
=20
-_ON    7.1.3           It is recommended to define this method for any=
 device
+_ON    7.2.3           It is recommended to define this method for any=
 device
                        that can be turned on or off.
=20
 \_OS   5.7.3           This method will return "Linux" by default (thi=
s is
@@ -398,122 +422,107 @@ _OSC   6.2.11          This method can be a glo=
bal method in ACPI (i.e.,
                        by the kernel community, then register it with =
the
                        UEFI Forum.
=20
-\_OSI  5.7.2           Deprecated on ARM64.  Any invocation of this me=
thod
-                       will print a warning on the console and return =
false.
-                       That is, as far as ACPI firmware is concerned, =
_OSI
-                       cannot be used to determine what sort of system=
 is
-                       being used or what functionality is provided.  =
The
-                       _OSC method is to be used instead.
-
-_OST   6.3.5           Optional.
+\_OSI  5.7.2           Deprecated on ARM64.  As far as ACPI firmware i=
s=20
+		       concerned, _OSI is not to be used to determine what=20
+		       sort of system is being used or what functionality
+		       is provided.  The _OSC method is to be used instead.
=20
 _PDC   8.4.1           Deprecated, do not use on arm64.
=20
 \_PIC  5.8.1           The method should not be used.  On arm64, the o=
nly
                        interrupt model available is GIC.
=20
-_PLD   6.1.8           Optional.
-
 \_PR   5.3.1           This namespace is for x86 use only on legacy sy=
stems.
                        Do not use it on arm64.
=20
-_PRS   6.2.12          Optional.
-
 _PRT   6.2.13          Required as part of the definition of all PCI r=
oot
                        devices.
=20
-_PRW   7.2.13          Use as needed; power management specific.
-
-_PRx   7.2.8-11        Use as needed; power management specific.  If _=
PR0 is
+_PRx   7.3.8-11        Use as needed; power management specific.  If _=
PR0 is
                        defined, _PR3 must also be defined.
=20
-_PSC   7.2.6           Use as needed; power management specific.
-
-_PSE   7.2.7           Use as needed; power management specific.
-
-_PSW   7.2.14          Use as needed; power management specific.
-
-_PSx   7.2.2-5         Use as needed; power management specific.  If _=
PS0 is
+_PSx   7.3.2-5         Use as needed; power management specific.  If _=
PS0 is
                        defined, _PS3 must also be defined.  If clocks =
or
                        regulators need adjusting to be consistent with=
 power
                        usage, change them in these methods.
=20
-\_PTS  7.3.1           Use as needed; power management specific.
-
-_PXM   6.2.14          Optional.
-
-_REG   6.5.4           Use as needed.
+_RDI   8.4.4.4         Recommended for use with processor definitions =
(_HID
+		       ACPI0010) on arm64.  This should only be used in=20
+		       conjunction with _LPI.
=20
 \_REV  5.7.4           Always returns the latest version of ACPI suppo=
rted.
=20
-_RMV   6.3.6           Optional.
-
 \_SB   5.3.1           Required on arm64; all devices must be defined =
in this
                        namespace.
=20
-_SEG   6.5.6           Use as needed; PCI-specific.
-
-\_SI   5.3.1,          Optional.
-       9.1
-
-_SLI   6.2.15          Optional; recommended when SLIT table is in use=
=2E
+_SLI   6.2.15          Use is recommended when SLIT table is in use.
=20
 _STA   6.3.7,          It is recommended to define this method for any=
 device
-       7.1.4           that can be turned on or off.
+       7.2.4           that can be turned on or off.  See also the STA=
O table
+                       that provides overrides to hide devices in virt=
ualized
+                       environments.
=20
-_SRS   6.2.16          Optional; see also _PRS.
+_SRS   6.2.16          Use as needed; see also _PRS.
=20
 _STR   6.1.10          Recommended for conveying device names to end u=
sers;
                        this is preferred over using _DDN.
=20
 _SUB   6.1.9           Use as needed; _HID or _CID are preferred.
=20
-_SUN   6.1.11          Optional.
-
-\_Sx   7.3.2           Use as needed; power management specific.
-
-_SxD   7.2.16-19       Use as needed; power management specific.
-
-_SxW   7.2.20-24       Use as needed; power management specific.
+_SUN   6.1.11          Use as needed, but recommended.
=20
-_SWS   7.3.3           Use as needed; power management specific; this =
may
+_SWS   7.4.3           Use as needed; power management specific; this =
may
                        require specification changes for use on arm64.
=20
-\_TTS  7.3.4           Use as needed; power management specific.
-
-\_TZ   5.3.1           Optional.
-
 _UID   6.1.12          Recommended for distinguishing devices of the s=
ame
                        class; define it if at all possible.
=20
-\_WAK  7.3.5           Use as needed; power management specific.
+
=20
=20
 ACPI Event Model
 ----------------
 Do not use GPE block devices; these are not supported in the hardware =
reduced
 profile used by arm64.  Since there are no GPE blocks defined for use =
on ARM
-platforms, GPIO-signaled interrupts should be used for creating system=
 events.
+platforms, ACPI events must be signaled differently.
+
+There are two options: GPIO-signaled interrupts (Section 5.6.5), and
+interrupt-signaled events (Section 5.6.9).  Interrupt-signaled events =
are a
+new feature in the ACPI 6.1 specification.  Either -- or both -- can b=
e used
+on a given platform, and which to use may be dependent of limitations =
in any
+given SoC.  If possible, interrupt-signaled events are recommended.
=20
=20
 ACPI Processor Control
 ----------------------
-Section 8 of the ACPI specification is currently undergoing change tha=
t
-should be completed in the 6.0 version of the specification.  Processo=
r
-performance control will be handled differently for arm64 at that poin=
t
-in time.  Processor aggregator devices (section 8.5) will not be used,
-for example, but another similar mechanism instead.
-
-While UEFI constrains what we can say until the release of 6.0, it is
-recommended that CPPC (8.4.5) be used as the primary model.  This will
-still be useful into the future.  C-states and P-states will still be
-provided, but most of the current design work appears to favor CPPC.
+Section 8 of the ACPI specification changed significantly in version 6=
=2E0.
+Processors should now be defined as Device objects with _HID ACPI0007;=
 do
+not use the deprecated Processor statement in ASL.  All multiprocessor=
 systems
+should also define a hierarchy of processors, done with Processor Cont=
ainer
+Devices (see Section 8.4.3.1, _HID ACPI0010); do not use processor agg=
regator
+devices (Section 8.5) to describe processor topology.  Section 8.4 of =
the
+specification describes the semantics of these object definitions and =
how
+they interrelate.
+
+Most importantly, the processor hierarchy defined also defines the low=
 power
+idle states that are available to the platform, along with the rules f=
or
+determining which processors can be turned on or off and the circumsta=
nces
+that control that.  Without this information, the processors will run =
in
+whatever power state they were left in by UEFI.
+
+Note too, that the processor Device objects defined and the entries in=
 the
+MADT for GICs are expected to be in synchronization.  The _UID of the =
Device
+object must correspond to processor IDs used in the MADT.
+
+It is recommended that CPPC (8.4.5) be used as the primary model for p=
rocessor
+performance control on arm64.  C-states and P-states may become availa=
ble at
+some point in the future, but most current design work appears to favo=
r CPPC.
=20
 Further, it is essential that the ARMv8 SoC provide a fully functional
 implementation of PSCI; this will be the only mechanism supported by A=
CPI
-to control CPU power state (including secondary CPU booting).
-
-More details will be provided on the release of the ACPI 6.0 specifica=
tion.
+to control CPU power state.  Booting of secondary CPUs using the ACPI
+parking protocol is possible, but discouraged, since only PSCI is supp=
orted
+for ARM servers.
=20
=20
 ACPI System Address Map Interfaces
@@ -535,21 +544,25 @@ used to indicate fatal errors that cannot be corr=
ected, and require immediate
 attention.
=20
 Since there is no direct equivalent of the x86 SCI or NMI, arm64 handl=
es
-these slightly differently.  The SCI is handled as a normal GPIO-signa=
led
-interrupt; given that these are corrected (or correctable) errors bein=
g
-reported, this is sufficient.  The NMI is emulated as the highest prio=
rity
-GPIO-signaled interrupt possible.  This implies some caution must be u=
sed
-since there could be interrupts at higher privilege levels or even int=
errupts
-at the same priority as the emulated NMI.  In Linux, this should not b=
e the
-case but one should be aware it could happen.
+these slightly differently.  The SCI is handled as a high priority int=
errupt;
+given that these are corrected (or correctable) errors being reported,=
 this
+is sufficient.  The NMI is emulated as the highest priority interrupt
+possible.  This implies some caution must be used since there could be
+interrupts at higher privilege levels or even interrupts at the same p=
riority
+as the emulated NMI.  In Linux, this should not be the case but one sh=
ould
+be aware it could happen.
=20
=20
 ACPI Objects Not Supported on ARM64
 -----------------------------------
 While this may change in the future, there are several classes of obje=
cts
 that can be defined, but are not currently of general interest to ARM =
servers.
+Some of these objects have x86 equivalents, and may actually make sens=
e in ARM
+servers.  However, there is either no hardware available at present, o=
r there
+may not even be a non-ARM implementation yet.  Hence, they are not cur=
rently
+supported.
=20
-These are not supported:
+The following classes of objects are not supported:
=20
        -- Section 9.2: ambient light sensor devices
=20
@@ -571,16 +584,6 @@ These are not supported:
=20
        -- Section 9.18: time and alarm devices (see 9.15)
=20
-
-ACPI Objects Not Yet Implemented
---------------------------------
-While these objects have x86 equivalents, and they do make some sense =
in ARM
-servers, there is either no hardware available at present, or in some =
cases
-there may not yet be a non-ARM implementation.  Hence, they are curren=
tly not
-implemented though that may change in the future.
-
-Not yet implemented are:
-
        -- Section 10: power source and power meter devices
=20
        -- Section 11: thermal management
@@ -589,5 +592,31 @@ Not yet implemented are:
=20
        -- Section 13: SMBus interfaces
=20
-       -- Section 17: NUMA support (prototypes have been submitted for
-          review)
+
+This also means that there is no support for the following objects:
+
+Name   Section                     Name   Section
+----   ------------                ----   ------------
+_ALC   9.3.4                       _FDM   9.10.3
+_ALI   9.3.2                       _FIX   6.2.7
+_ALP   9.3.6                       _GAI   10.4.5
+_ALR   9.3.5                       _GHL   10.4.7
+_ALT   9.3.3                       _GTM   9.9.2.1.1
+_BCT   10.2.2.10                   _LID   9.5.1
+_BDN   6.5.3                       _PAI   10.4.4
+_BIF   10.2.2.1                    _PCL   10.3.2
+_BIX   10.2.2.1                    _PIF   10.3.3
+_BLT   9.2.3                       _PMC   10.4.1
+_BMA   10.2.2.4                    _PMD   10.4.8
+_BMC   10.2.2.12                   _PMM   10.4.3
+_BMD   10.2.2.11                   _PRL   10.3.4
+_BMS   10.2.2.5                    _PSR   10.3.1
+_BST   10.2.2.6                    _PTP   10.4.2
+_BTH   10.2.2.7                    _SBS   10.1.3
+_BTM   10.2.2.9                    _SHL   10.4.6
+_BTP   10.2.2.8                    _STM   9.9.2.1.1
+_DCK   6.5.2                       _UPD   9.16.1
+_EC    12.12                       _UPP   9.16.2
+_FDE   9.10.1                      _WPC   10.5.2
+_FDI   9.10.2                      _WPP   10.5.3
+
diff --git a/Documentation/arm64/arm-acpi.txt b/Documentation/arm64/arm=
-acpi.txt
index 570a4f8..1a74a04 100644
--- a/Documentation/arm64/arm-acpi.txt
+++ b/Documentation/arm64/arm-acpi.txt
@@ -34,7 +34,7 @@ of the summary text almost directly, to be honest.
=20
 The short form of the rationale for ACPI on ARM is:
=20
--- ACPI=E2=80=99s bytecode (AML) allows the platform to encode hardwar=
e behavior,
+-- ACPI=E2=80=99s byte code (AML) allows the platform to encode hardwa=
re behavior,
    while DT explicitly does not support this.  For hardware vendors, b=
eing
    able to encode behavior is a key tool used in supporting operating
    system releases on new hardware.
@@ -57,11 +57,11 @@ The short form of the rationale for ACPI on ARM is:
=20
 -- The new ACPI governance process works well and Linux is now at the =
same
    table as hardware vendors and other OS vendors.  In fact, there is =
no
-   longer any reason to feel that ACPI is only belongs to Windows or t=
hat
+   longer any reason to feel that ACPI only belongs to Windows or that
    Linux is in any way secondary to Microsoft in this arena.  The move=
 of
    ACPI governance into the UEFI forum has significantly opened up the
    specification development process, and currently, a large portion o=
f the
-   changes being made to ACPI is being driven by Linux.
+   changes being made to ACPI are being driven by Linux.
=20
 Key to the use of ACPI is the support model.  For servers in general, =
the
 responsibility for hardware behaviour cannot solely be the domain of t=
he
@@ -110,7 +110,7 @@ ACPI support in drivers and subsystems for ARMv8 sh=
ould never be mutually
 exclusive with DT support at compile time.
=20
 At boot time the kernel will only use one description method depending=
 on
-parameters passed from the bootloader (including kernel bootargs).
+parameters passed from the boot loader (including kernel bootargs).
=20
 Regardless of whether DT or ACPI is used, the kernel must always be ca=
pable
 of booting with either scheme (in kernels with both schemes enabled at=
 compile
@@ -159,7 +159,7 @@ Further, the ACPI core will only use the 64-bit add=
ress fields in the FADT
 (Fixed ACPI Description Table).  Any 32-bit address fields in the FADT=
 will
 be ignored on arm64.
=20
-Hardware reduced mode (see Section 4.1 of the ACPI 5.1 specification) =
will
+Hardware reduced mode (see Section 4.1 of the ACPI 6.1 specification) =
will
 be enforced by the ACPI core on arm64.  Doing so allows the ACPI core =
to
 run less complex code since it no longer has to provide support for le=
gacy
 hardware from other architectures.  Any fields that are not to be used=
 for
@@ -167,7 +167,7 @@ hardware reduced mode must be set to zero.
=20
 For the ACPI core to operate properly, and in turn provide the informa=
tion
 the kernel needs to configure devices, it expects to find the followin=
g
-tables (all section numbers refer to the ACPI 5.1 specfication):
+tables (all section numbers refer to the ACPI 6.1 specification):
=20
     -- RSDP (Root System Description Pointer), section 5.2.5
=20
@@ -185,9 +185,23 @@ tables (all section numbers refer to the ACPI 5.1 =
specfication):
     -- If PCI is supported, the MCFG (Memory mapped ConFiGuration
        Table), section 5.2.6, specifically Table 5-31.
=20
+    -- If booting without a console=3D<device> kernel parameter is
+       supported, the SPCR (Serial Port Console Redirection table),
+       section 5.2.6, specifically Table 5-31.
+
+    -- If necessary to describe the I/O topology, SMMUs and GIC ITSs,
+       the IORT (Input Output Remapping Table, section 5.2.6, specific=
ally
+       Table 5-31).
+
+    -- If NUMA is supported, the SRAT (System Resource Affinity Table)
+       and SLIT (System Locality distance Information Table), sections
+       5.2.16 and 5.2.17, respectively.
+
 If the above tables are not all present, the kernel may or may not be
 able to boot properly since it may not be able to configure all of the
-devices available.
+devices available.  This list of tables is not meant to be all inclusi=
ve;
+in some environments other tables may be needed (e.g., any of the APEI
+tables from section 18) to support specific functionality.
=20
=20
 ACPI Detection
@@ -198,7 +212,7 @@ the device structure.  This is detailed further in =
the "Driver
 Recommendations" section.
=20
 In non-driver code, if the presence of ACPI needs to be detected at
-runtime, then check the value of acpi_disabled. If CONFIG_ACPI is not
+run time, then check the value of acpi_disabled. If CONFIG_ACPI is not
 set, acpi_disabled will always be 1.
=20
=20
@@ -233,7 +247,7 @@ that looks like this: Name(KEY0, "value0").  An ACP=
I device driver would
 then retrieve the value of the property by evaluating the KEY0 object.
 However, using Name() this way has multiple problems: (1) ACPI limits
 names ("KEY0") to four characters unlike DT; (2) there is no industry
-wide registry that maintains a list of names, minimzing re-use; (3)
+wide registry that maintains a list of names, minimizing re-use; (3)
 there is also no registry for the definition of property values ("valu=
e0"),
 again making re-use difficult; and (4) how does one maintain backward
 compatibility as new hardware comes out?  The _DSD method was created
@@ -434,7 +448,8 @@ The ACPI specification changes regularly.  During t=
he year 2014, for instance,
 version 5.1 was released and version 6.0 substantially completed, with=
 most of
 the changes being driven by ARM-specific requirements.  Proposed chang=
es are
 presented and discussed in the ASWG (ACPI Specification Working Group)=
 which
-is a part of the UEFI Forum.
+is a part of the UEFI Forum.  The current version of the ACPI specific=
ation
+is 6.1 release in January 2016.
=20
 Participation in this group is open to all UEFI members.  Please see
 http://www.uefi.org/workinggroup for details on group membership.
@@ -443,7 +458,7 @@ It is the intent of the ARMv8 ACPI kernel code to f=
ollow the ACPI specification
 as closely as possible, and to only implement functionality that compl=
ies with
 the released standards from UEFI ASWG.  As a practical matter, there w=
ill be
 vendors that provide bad ACPI tables or violate the standards in some =
way.
-If this is because of errors, quirks and fixups may be necessary, but =
will
+If this is because of errors, quirks and fix-ups may be necessary, but=
 will
 be avoided if possible.  If there are features missing from ACPI that =
preclude
 it from being used on a platform, ECRs (Engineering Change Requests) s=
hould be
 submitted to ASWG and go through the normal approval process; for thos=
e that
@@ -480,8 +495,7 @@ References
     Software on ARM Platforms", dated 16 Aug 2014
=20
 [2] http://www.secretlab.ca/archives/151, 10 Jan 2015, Copyright (c) 2=
015,
-    Linaro Ltd., written by Grant Likely.  A copy of the verbatim text=
 (apart
-    from formatting) is also in Documentation/arm64/why_use_acpi.txt.
+    Linaro Ltd., written by Grant Likely.
=20
 [3] AMD ACPI for Seattle platform documentation:
     http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2012/10/Sea=
ttle_ACPI_Guide.pdf
--=20
2.5.5
