From: "Bongini Maurizio" <bong.mau-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Subject: ACPI Activation...
Date: Thu, 22 Apr 2004 16:57:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <002201c4287a$1e0d5d50$84fe1e97@computername>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001F_01C4288A.DD795210"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_001F_01C4288A.DD795210
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello folks

my name is Maurzio Bongini
i need to activate acpi
i read the sourceforge page and the "ACPI how to"

Hardware toshiba satellite 1800-712  last bios installed (2.10)
software :
boot manager Lilo
Default partition Windows XP -home
Second partition linux mandrake 9.2 kernel 2.4.22-10mdk
problem :
reboot process on windows function correctly
(shutdown,then power off,then power on again and reload)
reboot process on linux does not function
shutdown correctly,then don't poweroff like windows ,but try to reboot,
at this time pc hangs with a blank screen and fan at the maximum speed)
i look at windows configuration and i see that battery is ACPI managed
about battery here the info available on windows xp
Battery in ACPI windows compatible.
AC microsoft card.
so i want to activate acpi to make linux functioning at the same way as
microsoft do.
the current ACPI is 20030813
before activating i downloaded the last patch relative to 2.4.22 kernel
and i install it but i get the following errors: (see attached files)
what is the problem ?
i have to install first acpi and acpid before patching ?
i want also to know your opinion about the defect described..
does missing ACPI  activation may be the cause ?
thanks in advance for the support

(please answer to bong.mau-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org )

ciao

                     Maurizio




------=_NextPart_000_001F_01C4288A.DD795210
Content-Type: application/octet-stream;
	name="Config.in.rej"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Config.in.rej"

***************=0A=
*** 8,43 ****=0A=
    comment 'ACPI Support'=0A=
    bool         'ACPI Support' CONFIG_ACPI=0A=
    if [ "$CONFIG_ACPI" =3D "y" ]; then=0A=
-     if [ "$CONFIG_SMP" =3D "y" ]; then=0A=
-       bool         'CPU Enumeration Only' CONFIG_ACPI_HT_ONLY=0A=
-     else=0A=
-       define_bool CONFIG_ACPI_HT_ONLY n=0A=
-     fi=0A=
  =0A=
-     if [ "$CONFIG_ACPI_HT_ONLY" =3D "n" ]; then=0A=
        define_bool CONFIG_ACPI_BOOT		y=0A=
-       define_bool CONFIG_ACPI_BUS		y=0A=
-       define_bool CONFIG_ACPI_INTERPRETER	y=0A=
-       define_bool CONFIG_ACPI_EC		y=0A=
-       define_bool CONFIG_ACPI_POWER		y=0A=
-       if [ "$CONFIG_PCI" =3D "y" ]; then=0A=
-         define_bool CONFIG_ACPI_PCI		y=0A=
-       fi=0A=
-       define_bool CONFIG_ACPI_SLEEP		y=0A=
-       define_bool CONFIG_ACPI_SYSTEM		y=0A=
-       tristate     '  AC Adapter'	CONFIG_ACPI_AC=0A=
-       tristate     '  Battery'		CONFIG_ACPI_BATTERY=0A=
-       tristate     '  Button'		CONFIG_ACPI_BUTTON=0A=
-       tristate     '  Fan'		CONFIG_ACPI_FAN=0A=
-       tristate     '  Processor'	CONFIG_ACPI_PROCESSOR=0A=
-       dep_tristate '  Thermal Zone' 	CONFIG_ACPI_THERMAL =
$CONFIG_ACPI_PROCESSOR=0A=
-       if [ "$CONFIG_NUMA" =3D "y" -a "$CONFIG_X86_64" !=3D "y" ]; then=0A=
-         dep_bool       '  NUMA support'     CONFIG_ACPI_NUMA =
$CONFIG_NUMA=0A=
-       fi=0A=
-       tristate     '  ASUS Laptop Extras'  CONFIG_ACPI_ASUS=0A=
-       tristate     '  Toshiba Laptop Extras'	CONFIG_ACPI_TOSHIBA=0A=
-       bool         '  Debug Statements'	CONFIG_ACPI_DEBUG=0A=
-       bool         '  Relaxed AML Checking'	CONFIG_ACPI_RELAXED_AML=0A=
      fi=0A=
    fi=0A=
  =0A=
--- 8,37 ----=0A=
    comment 'ACPI Support'=0A=
    bool         'ACPI Support' CONFIG_ACPI=0A=
    if [ "$CONFIG_ACPI" =3D "y" ]; then=0A=
  =0A=
+     define_bool CONFIG_ACPI_BOOT		y=0A=
+     define_bool CONFIG_ACPI_BUS			y=0A=
+     define_bool CONFIG_ACPI_INTERPRETER		y=0A=
+     define_bool CONFIG_ACPI_EC			y=0A=
+     define_bool CONFIG_ACPI_POWER		y=0A=
+     if [ "$CONFIG_PCI" =3D "y" ]; then=0A=
+       define_bool CONFIG_ACPI_PCI		y=0A=
+     fi=0A=
+     define_bool CONFIG_ACPI_SLEEP		y=0A=
+     define_bool CONFIG_ACPI_SYSTEM		y=0A=
+     tristate     '  AC Adapter'	CONFIG_ACPI_AC=0A=
+     tristate     '  Battery'		CONFIG_ACPI_BATTERY=0A=
+     tristate     '  Button'		CONFIG_ACPI_BUTTON=0A=
+     tristate     '  Fan'		CONFIG_ACPI_FAN=0A=
+     tristate     '  Processor'	CONFIG_ACPI_PROCESSOR=0A=
+     dep_tristate '  Thermal Zone' 	CONFIG_ACPI_THERMAL =
$CONFIG_ACPI_PROCESSOR=0A=
+     tristate     '  ASUS Laptop Extras'  CONFIG_ACPI_ASUS=0A=
+     tristate     '  Toshiba Laptop Extras'	CONFIG_ACPI_TOSHIBA=0A=
+     bool         '  Debug Statements'	CONFIG_ACPI_DEBUG=0A=
+     bool         '  Relaxed AML Checking'	CONFIG_ACPI_RELAXED_AML=0A=
+   else=0A=
+     if [ "$CONFIG_SMP" =3D "y" ]; then=0A=
        define_bool CONFIG_ACPI_BOOT		y=0A=
      fi=0A=
    fi=0A=
  =0A=

------=_NextPart_000_001F_01C4288A.DD795210
Content-Type: application/octet-stream;
	name="Configure.help.rej"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Configure.help.rej"

***************=0A=
*** 19951,19981 ****=0A=
    of verbosity. Saying Y enables these statements. This will increase=0A=
    your kernel size by around 50K.=0A=
  =0A=
- ACPI Relaxed AML Checking=0A=
- CONFIG_ACPI_RELAXED_AML=0A=
-   If you say `Y' here, the ACPI interpreter will relax its checking=0A=
-   for valid AML and will ignore some AML mistakes, such as off-by-one=0A=
-   errors in region sizes.  Some laptops may require this option.  In=0A=
-   particular, many Toshiba laptops require this for correct operation=0A=
-   of the AC module.=0A=
- =0A=
- ACPI Bus Manager=0A=
- CONFIG_ACPI_BUSMGR=0A=
-   The ACPI Bus Manager enumerates devices in the ACPI namespace, and=0A=
-   handles PnP messages.  All ACPI devices use its services, so using=0A=
-   them requires saying Y here.=0A=
- =0A=
- ACPI System Driver=0A=
- CONFIG_ACPI_SYS=0A=
-   This driver will enable your system to shut down using ACPI, and=0A=
-   dump your ACPI DSDT table using /proc/acpi/dsdt.=0A=
- =0A=
- ACPI Processor Driver=0A=
- CONFIG_ACPI_CPU=0A=
-   This driver installs ACPI as the idle handler for Linux, and uses=0A=
-   ACPI C2 and C3 processor states to save power, on systems that=0A=
-   support it.=0A=
- =0A=
  ACPI Button=0A=
  CONFIG_ACPI_BUTTON=0A=
    This driver registers for events based on buttons, such as the=0A=
--- 19929,19934 ----=0A=
    of verbosity. Saying Y enables these statements. This will increase=0A=
    your kernel size by around 50K.=0A=
  =0A=
  ACPI Button=0A=
  CONFIG_ACPI_BUTTON=0A=
    This driver registers for events based on buttons, such as the=0A=

------=_NextPart_000_001F_01C4288A.DD795210
Content-Type: application/octet-stream;
	name="io_apic.c.rej"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="io_apic.c.rej"

***************=0A=
*** 1762,1768 ****=0A=
  }=0A=
  =0A=
  =0A=
- int io_apic_set_pci_routing (int ioapic, int pin, int irq)=0A=
  {=0A=
  	struct IO_APIC_route_entry entry;=0A=
  	unsigned long flags;=0A=
--- 1824,1830 ----=0A=
  }=0A=
  =0A=
  =0A=
+ int io_apic_set_pci_routing (int ioapic, int pin, int irq, int =
edge_level, int active_high_low)=0A=
  {=0A=
  	struct IO_APIC_route_entry entry;=0A=
  	unsigned long flags;=0A=
***************=0A=
*** 1785,1802 ****=0A=
  	entry.dest_mode =3D INT_DELIVERY_MODE;=0A=
  	entry.dest.logical.logical_dest =3D TARGET_CPUS;=0A=
  	entry.mask =3D 1;					 /* Disabled (masked) */=0A=
- 	entry.trigger =3D 1;				   /* Level sensitive */=0A=
- 	entry.polarity =3D 1;					/* Low active */=0A=
  =0A=
- 	add_pin_to_irq(irq, ioapic, pin);=0A=
  =0A=
  	entry.vector =3D assign_irq_vector(irq);=0A=
  =0A=
  	printk(KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x =
-> "=0A=
- 		"IRQ %d)\n", ioapic, =0A=
- 		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);=0A=
  =0A=
- 	irq_desc[irq].handler =3D &ioapic_level_irq_type;=0A=
  =0A=
  	set_intr_gate(entry.vector, interrupt[irq]);=0A=
  =0A=
--- 1847,1871 ----=0A=
  	entry.dest_mode =3D INT_DELIVERY_MODE;=0A=
  	entry.dest.logical.logical_dest =3D TARGET_CPUS;=0A=
  	entry.mask =3D 1;					 /* Disabled (masked) */=0A=
+ 	entry.trigger =3D edge_level;=0A=
+ 	entry.polarity =3D active_high_low;=0A=
  =0A=
+ 	/*=0A=
+ 	 * IRQs < 16 are already in the irq_2_pin[] map=0A=
+ 	 */=0A=
+ 	if (irq >=3D 16)=0A=
+ 		add_pin_to_irq(irq, ioapic, pin);=0A=
  =0A=
  	entry.vector =3D assign_irq_vector(irq);=0A=
  =0A=
  	printk(KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x =
-> "=0A=
+ 		"IRQ %d Mode:%i Active:%i)\n", ioapic,=0A=
+ 		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq, edge_level, =
active_high_low);=0A=
  =0A=
+ 	if (edge_level)=0A=
+ 		irq_desc[irq].handler =3D &ioapic_level_irq_type;=0A=
+ 	else=0A=
+ 		irq_desc[irq].handler =3D &ioapic_edge_irq_type;=0A=
  =0A=
  	set_intr_gate(entry.vector, interrupt[irq]);=0A=
  =0A=

------=_NextPart_000_001F_01C4288A.DD795210
Content-Type: application/octet-stream;
	name="io_apic.h.rej"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="io_apic.h.rej"

***************=0A=
*** 141,153 ****=0A=
   */=0A=
  #define io_apic_assign_pci_irqs (mp_irq_entries && !skip_ioapic_setup)=0A=
  =0A=
- #else  /* !CONFIG_X86_IO_APIC */=0A=
  #define io_apic_assign_pci_irqs 0=0A=
- #endif=0A=
  =0A=
  extern int io_apic_get_unique_id (int ioapic, int apic_id);=0A=
  extern int io_apic_get_version (int ioapic);=0A=
  extern int io_apic_get_redir_entries (int ioapic);=0A=
- extern int io_apic_set_pci_routing (int ioapic, int pin, int irq);=0A=
  =0A=
  #endif=0A=
--- 141,170 ----=0A=
   */=0A=
  #define io_apic_assign_pci_irqs (mp_irq_entries && !skip_ioapic_setup)=0A=
  =0A=
+ extern int skip_ioapic_setup;	/* 1 for "noapic" */=0A=
+ =0A=
+ static inline void disable_ioapic_setup(void)=0A=
+ {=0A=
+ 	skip_ioapic_setup =3D 1;=0A=
+ }=0A=
+ =0A=
+ static inline int ioapic_setup_disabled(void)=0A=
+ {=0A=
+ 	return skip_ioapic_setup;=0A=
+ }=0A=
+ =0A=
+ #else	/* !CONFIG_X86_IO_APIC */=0A=
+ =0A=
  #define io_apic_assign_pci_irqs 0=0A=
+ =0A=
+ static inline void disable_ioapic_setup(void)=0A=
+ { }=0A=
+ =0A=
+ #endif	/* !CONFIG_X86_IO_APIC */=0A=
  =0A=
  extern int io_apic_get_unique_id (int ioapic, int apic_id);=0A=
  extern int io_apic_get_version (int ioapic);=0A=
  extern int io_apic_get_redir_entries (int ioapic);=0A=
+ extern int io_apic_set_pci_routing (int ioapic, int pin, int irq, int, =
int);=0A=
  =0A=
  #endif=0A=

------=_NextPart_000_001F_01C4288A.DD795210
Content-Type: application/octet-stream;
	name="mpparse.c.rej"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mpparse.c.rej"

***************=0A=
*** 139,147 ****=0A=
  	str[6] =3D 0;=0A=
  	Dprintk("Bus #%d is %s\n", m->mpc_busid, str);=0A=
  =0A=
- 	if (m->mpc_busid >=3D MAX_MP_BUSSES) {=0A=
  		printk(KERN_ERR "MAX_MP_BUSSES ERROR mpc_busid %d, max %d\n", =
m->mpc_busid, MAX_MP_BUSSES);=0A=
- 	} else if (strncmp(str, "ISA", 3) =3D=3D 0) {=0A=
  		mp_bus_id_to_type[m->mpc_busid] =3D MP_BUS_ISA;=0A=
  	} else if (strncmp(str, "EISA", 4) =3D=3D 0) {=0A=
  		mp_bus_id_to_type[m->mpc_busid] =3D MP_BUS_EISA;=0A=
--- 156,167 ----=0A=
  	str[6] =3D 0;=0A=
  	Dprintk("Bus #%d is %s\n", m->mpc_busid, str);=0A=
  =0A=
+ #if MAX_MP_BUSSES < 256=0A=
+ 	if ((long)m->mpc_busid >=3D MAX_MP_BUSSES) {=0A=
  		printk(KERN_ERR "MAX_MP_BUSSES ERROR mpc_busid %d, max %d\n", =
m->mpc_busid, MAX_MP_BUSSES);=0A=
+ 	} else =0A=
+ #endif	=0A=
+ 	if (strncmp(str, "ISA", 3) =3D=3D 0) {=0A=
  		mp_bus_id_to_type[m->mpc_busid] =3D MP_BUS_ISA;=0A=
  	} else if (strncmp(str, "EISA", 4) =3D=3D 0) {=0A=
  		mp_bus_id_to_type[m->mpc_busid] =3D MP_BUS_EISA;=0A=
***************=0A=
*** 713,719 ****=0A=
  			return i;=0A=
  	}=0A=
  =0A=
- 	printk(KERN_ERR "ERROR: Unable to locate IOAPIC for IRQ %d/n", irq);=0A=
  =0A=
  	return -1;=0A=
  }=0A=
--- 733,739 ----=0A=
  			return i;=0A=
  	}=0A=
  =0A=
+ 	printk(KERN_ERR "ERROR: Unable to locate IOAPIC for IRQ %d\n", irq);=0A=
  =0A=
  	return -1;=0A=
  }=0A=
***************=0A=
*** 756,762 ****=0A=
  	mp_ioapic_routing[idx].irq_end =3D irq_base + =0A=
  		io_apic_get_redir_entries(idx);=0A=
  =0A=
- 	printk("IOAPIC[%d]: apic_id %d, version %d, address 0x%lx, "=0A=
  		"IRQ %d-%d\n", idx, mp_ioapics[idx].mpc_apicid, =0A=
  		mp_ioapics[idx].mpc_apicver, mp_ioapics[idx].mpc_apicaddr,=0A=
  		mp_ioapic_routing[idx].irq_start,=0A=
--- 776,782 ----=0A=
  	mp_ioapic_routing[idx].irq_end =3D irq_base + =0A=
  		io_apic_get_redir_entries(idx);=0A=
  =0A=
+ 	printk("IOAPIC[%d]: apic_id %d, version %d, address 0x%x, "=0A=
  		"IRQ %d-%d\n", idx, mp_ioapics[idx].mpc_apicid, =0A=
  		mp_ioapics[idx].mpc_apicver, mp_ioapics[idx].mpc_apicaddr,=0A=
  		mp_ioapic_routing[idx].irq_start,=0A=
***************=0A=
*** 883,933 ****=0A=
  =0A=
  #ifndef CONFIG_ACPI_HT_ONLY=0A=
  =0A=
- /* Ensure the ACPI SCI interrupt level is active low, edge-triggered */=0A=
- =0A=
  extern FADT_DESCRIPTOR acpi_fadt;=0A=
  =0A=
- void __init mp_config_ioapic_for_sci(int irq)=0A=
- {=0A=
- 	int ioapic;=0A=
- 	int ioapic_pin;=0A=
- 	struct acpi_table_madt* madt;=0A=
- 	struct acpi_table_int_src_ovr *entry =3D NULL;=0A=
- 	void *madt_end;=0A=
- 	acpi_status status;=0A=
- =0A=
- 	/*=0A=
- 	 * Ensure that if there is an interrupt source override entry=0A=
- 	 * for the ACPI SCI, we leave it as is. Unfortunately this involves=0A=
- 	 * walking the MADT again.=0A=
- 	 */=0A=
- 	status =3D acpi_get_firmware_table("APIC", 1, ACPI_LOGICAL_ADDRESSING,=0A=
- 		(struct acpi_table_header **) &madt);=0A=
- 	if (ACPI_SUCCESS(status)) {=0A=
- 		madt_end =3D (void *) (unsigned long)madt + madt->header.length;=0A=
- =0A=
- 		entry =3D (struct acpi_table_int_src_ovr *)=0A=
-                 ((unsigned long) madt + sizeof(struct =
acpi_table_madt));=0A=
- =0A=
- 		while ((void *) entry < madt_end) {=0A=
-                 	if (entry->header.type =3D=3D ACPI_MADT_INT_SRC_OVR &&=0A=
- 			    acpi_fadt.sci_int =3D=3D entry->global_irq)=0A=
-                 		return;=0A=
- =0A=
-                 	entry =3D (struct acpi_table_int_src_ovr *)=0A=
-                 	        ((unsigned long) entry + =
entry->header.length);=0A=
-         	}=0A=
- 	}=0A=
- =0A=
- 	ioapic =3D mp_find_ioapic(irq);=0A=
- =0A=
- 	ioapic_pin =3D irq - mp_ioapic_routing[ioapic].irq_start;=0A=
- =0A=
- 	io_apic_set_pci_routing(ioapic, ioapic_pin, irq);=0A=
- }=0A=
- =0A=
  #endif /*CONFIG_ACPI_HT_ONLY*/=0A=
  =0A=
  #ifdef CONFIG_ACPI_PCI=0A=
  =0A=
  void __init mp_parse_prt (void)=0A=
--- 904,915 ----=0A=
  =0A=
  #ifndef CONFIG_ACPI_HT_ONLY=0A=
  =0A=
  extern FADT_DESCRIPTOR acpi_fadt;=0A=
  =0A=
  #endif /*CONFIG_ACPI_HT_ONLY*/=0A=
  =0A=
+ int acpi_tolerant;=0A=
+ =0A=
  #ifdef CONFIG_ACPI_PCI=0A=
  =0A=
  void __init mp_parse_prt (void)=0A=
***************=0A=
*** 939,944 ****=0A=
  	int			ioapic_pin =3D 0;=0A=
  	int			irq =3D 0;=0A=
  	int			idx, bit =3D 0;=0A=
  =0A=
  	/*=0A=
  	 * Parsing through the PCI Interrupt Routing Table (PRT) and program=0A=
--- 921,928 ----=0A=
  	int			ioapic_pin =3D 0;=0A=
  	int			irq =3D 0;=0A=
  	int			idx, bit =3D 0;=0A=
+ 	int			edge_level =3D 0;=0A=
+ 	int			active_high_low =3D 0;=0A=
  =0A=
  	/*=0A=
  	 * Parsing through the PCI Interrupt Routing Table (PRT) and program=0A=
***************=0A=
*** 949,961 ****=0A=
  =0A=
  		/* Need to get irq for dynamic entry */=0A=
  		if (entry->link.handle) {=0A=
- 			irq =3D acpi_pci_link_get_irq(entry->link.handle, =
entry->link.index);=0A=
  			if (!irq)=0A=
  				continue;=0A=
- 		} else=0A=
  			irq =3D entry->link.index;=0A=
  =0A=
  		irq =3D entry->link.index;=0A=
  		ioapic =3D mp_find_ioapic(irq);=0A=
  		if (ioapic < 0)=0A=
  			continue;=0A=
--- 933,955 ----=0A=
  =0A=
  		/* Need to get irq for dynamic entry */=0A=
  		if (entry->link.handle) {=0A=
+ 			irq =3D acpi_pci_link_get_irq(entry->link.handle, =
entry->link.index, &edge_level, &active_high_low);=0A=
  			if (!irq)=0A=
  				continue;=0A=
+ 		} else {=0A=
+ 			edge_level =3D 1;=0A=
+ 			active_high_low =3D 1;=0A=
  			irq =3D entry->link.index;=0A=
+ 		}=0A=
  =0A=
  		irq =3D entry->link.index;=0A=
+ =0A=
+   		/* Don't set up the ACPI SCI because it's already set up */=0A=
+                 if (acpi_fadt.sci_int =3D=3D irq) {=0A=
+                          entry->irq =3D irq; /*we still need to set =
entry's irq*/=0A=
+  			continue;=0A=
+                 }=0A=
+ =0A=
  		ioapic =3D mp_find_ioapic(irq);=0A=
  		if (ioapic < 0)=0A=
  			continue;=0A=
***************=0A=
*** 983,989 ****=0A=
  =0A=
  		mp_ioapic_routing[ioapic].pin_programmed[idx] |=3D (1<<bit);=0A=
  =0A=
- 		vector =3D io_apic_set_pci_routing(ioapic, ioapic_pin, irq);=0A=
  		if (vector)=0A=
  			entry->irq =3D irq;=0A=
  =0A=
--- 977,983 ----=0A=
  =0A=
  		mp_ioapic_routing[ioapic].pin_programmed[idx] |=3D (1<<bit);=0A=
  =0A=
+ 		vector =3D io_apic_set_pci_routing(ioapic, ioapic_pin, irq, =
edge_level, active_high_low);=0A=
  		if (vector)=0A=
  			entry->irq =3D irq;=0A=
  =0A=

------=_NextPart_000_001F_01C4288A.DD795210
Content-Type: application/octet-stream;
	name="pci_link.c.rej"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pci_link.c.rej"

***************=0A=
*** 290,296 ****=0A=
  	struct acpi_buffer	buffer =3D {sizeof(resource)+1, &resource};=0A=
  	int			i =3D 0;=0A=
  	int			valid =3D 0;=0A=
- =0A=
  	ACPI_FUNCTION_TRACE("acpi_pci_link_set");=0A=
  =0A=
  	if (!link || !irq)=0A=
--- 314,321 ----=0A=
  	struct acpi_buffer	buffer =3D {sizeof(resource)+1, &resource};=0A=
  	int			i =3D 0;=0A=
  	int			valid =3D 0;=0A=
+ 	int			resource_type =3D 0;=0A=
+    =0A=
  	ACPI_FUNCTION_TRACE("acpi_pci_link_set");=0A=
  =0A=
  	if (!link || !irq)=0A=
***************=0A=
*** 313,324 ****=0A=
  		}=0A=
  	}=0A=
  =0A=
  	memset(&resource, 0, sizeof(resource));=0A=
  =0A=
  	/* NOTE: PCI interrupts are always level / active_low / shared. But =
not all=0A=
  	   interrupts > 15 are PCI interrupts. Rely on the ACPI IRQ =
definition for =0A=
  	   parameters */=0A=
- 	if (irq <=3D 15) {=0A=
  		resource.res.id =3D ACPI_RSTYPE_IRQ;=0A=
  		resource.res.length =3D sizeof(struct acpi_resource);=0A=
  		resource.res.data.irq.edge_level =3D link->irq.edge_level;=0A=
--- 338,360 ----=0A=
  		}=0A=
  	}=0A=
  =0A=
+ 	/* If IRQ<=3D15, first try with a "normal" IRQ descriptor. If that =
fails, try with=0A=
+ 	 * an extended one */=0A=
+ 	if (irq <=3D 15) {=0A=
+ 		resource_type =3D ACPI_RSTYPE_IRQ;=0A=
+ 	} else {=0A=
+ 		resource_type =3D ACPI_RSTYPE_EXT_IRQ;=0A=
+ 	}=0A=
+ =0A=
+ retry_programming:=0A=
+    =0A=
  	memset(&resource, 0, sizeof(resource));=0A=
  =0A=
  	/* NOTE: PCI interrupts are always level / active_low / shared. But =
not all=0A=
  	   interrupts > 15 are PCI interrupts. Rely on the ACPI IRQ =
definition for =0A=
  	   parameters */=0A=
+ 	switch(resource_type) {=0A=
+ 	case ACPI_RSTYPE_IRQ:=0A=
  		resource.res.id =3D ACPI_RSTYPE_IRQ;=0A=
  		resource.res.length =3D sizeof(struct acpi_resource);=0A=
  		resource.res.data.irq.edge_level =3D link->irq.edge_level;=0A=
***************=0A=
*** 326,333 ****=0A=
  		resource.res.data.irq.shared_exclusive =3D ACPI_SHARED;=0A=
  		resource.res.data.irq.number_of_interrupts =3D 1;=0A=
  		resource.res.data.irq.interrupts[0] =3D irq;=0A=
- 	}=0A=
- 	else {=0A=
  		resource.res.id =3D ACPI_RSTYPE_EXT_IRQ;=0A=
  		resource.res.length =3D sizeof(struct acpi_resource);=0A=
  		resource.res.data.extended_irq.producer_consumer =3D ACPI_CONSUMER;=0A=
--- 362,370 ----=0A=
  		resource.res.data.irq.shared_exclusive =3D ACPI_SHARED;=0A=
  		resource.res.data.irq.number_of_interrupts =3D 1;=0A=
  		resource.res.data.irq.interrupts[0] =3D irq;=0A=
+ 		break;=0A=
+ 	   =0A=
+ 	case ACPI_RSTYPE_EXT_IRQ:=0A=
  		resource.res.id =3D ACPI_RSTYPE_EXT_IRQ;=0A=
  		resource.res.length =3D sizeof(struct acpi_resource);=0A=
  		resource.res.data.extended_irq.producer_consumer =3D ACPI_CONSUMER;=0A=
***************=0A=
*** 337,347 ****=0A=
  		resource.res.data.extended_irq.number_of_interrupts =3D 1;=0A=
  		resource.res.data.extended_irq.interrupts[0] =3D irq;=0A=
  		/* ignore resource_source, it's optional */=0A=
  	}=0A=
  	resource.end.id =3D ACPI_RSTYPE_END_TAG;=0A=
  =0A=
  	/* Attempt to set the resource */=0A=
  	status =3D acpi_set_current_resources(link->handle, &buffer);=0A=
  	if (ACPI_FAILURE(status)) {=0A=
  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _SRS\n"));=0A=
  		return_VALUE(-ENODEV);=0A=
--- 374,395 ----=0A=
  		resource.res.data.extended_irq.number_of_interrupts =3D 1;=0A=
  		resource.res.data.extended_irq.interrupts[0] =3D irq;=0A=
  		/* ignore resource_source, it's optional */=0A=
+ 		break;=0A=
  	}=0A=
  	resource.end.id =3D ACPI_RSTYPE_END_TAG;=0A=
  =0A=
  	/* Attempt to set the resource */=0A=
  	status =3D acpi_set_current_resources(link->handle, &buffer);=0A=
+    =0A=
+ =0A=
+ 	/* if we failed and IRQ <=3D 15, try again with an extended =
descriptor */=0A=
+ 	if (ACPI_FAILURE(status) && (resource_type =3D=3D ACPI_RSTYPE_IRQ)) {=0A=
+                 resource_type =3D ACPI_RSTYPE_EXT_IRQ;=0A=
+                 printk(PREFIX "Retrying with extended IRQ =
descriptor\n");=0A=
+                 goto retry_programming;=0A=
+ 	}=0A=
+   =0A=
+ 	/* check for total failure */=0A=
  	if (ACPI_FAILURE(status)) {=0A=
  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _SRS\n"));=0A=
  		return_VALUE(-ENODEV);=0A=

------=_NextPart_000_001F_01C4288A.DD795210
Content-Type: application/octet-stream;
	name="smpboot.c.rej"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="smpboot.c.rej"

***************=0A=
*** 51,57 ****=0A=
  static int smp_b_stepping;=0A=
  =0A=
  /* Setup configured maximum number of CPUs to activate */=0A=
- static int max_cpus =3D -1;=0A=
  =0A=
  /* Total count of live CPUs */=0A=
  int smp_num_cpus =3D 1;=0A=
--- 51,57 ----=0A=
  static int smp_b_stepping;=0A=
  =0A=
  /* Setup configured maximum number of CPUs to activate */=0A=
+ unsigned int max_cpus =3D NR_CPUS;=0A=
  =0A=
  /* Total count of live CPUs */=0A=
  int smp_num_cpus =3D 1;=0A=
***************=0A=
*** 1123,1130 ****=0A=
  			continue;=0A=
  =0A=
  		if (!(phys_cpu_present_map & (1ul << bit)))=0A=
- 			continue;=0A=
- 		if ((max_cpus >=3D 0) && (max_cpus <=3D cpucount+1))=0A=
  			continue;=0A=
  =0A=
  		do_boot_cpu(apicid);=0A=
--- 1111,1116 ----=0A=
  			continue;=0A=
  =0A=
  		if (!(phys_cpu_present_map & (1ul << bit)))=0A=
  			continue;=0A=
  =0A=
  		do_boot_cpu(apicid);=0A=

------=_NextPart_000_001F_01C4288A.DD795210--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
