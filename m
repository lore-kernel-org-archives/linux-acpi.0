From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Why does gcc suck at switch()?
Date: Fri, 3 Oct 2003 15:56:14 +0100
Sender: gcc-owner-/MQLu3FmUzdAfugRpC6u6w@public.gmane.org
Message-ID: <20031003145614.GP24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-83540-gcc-@public.gmane.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc-@public.gmane.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc-/MQLu3FmUzdAfugRpC6u6w@public.gmane.org>
List-Help: <http://gcc.gnu.org/ml/>
Content-Disposition: inline
To: gcc-/MQLu3FmUzdAfugRpC6u6w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Why does gcc generate worse code for switch() statements than for
multiple-if?

$ gcc --version
gcc (GCC) 3.3.2 20030908 (Debian prerelease)

I would expect a compiler to produce the same code for these cases.
Instead, switch is worse than the multiple-if:

-       switch (event) {
-       case ACPI_THERMAL_NOTIFY_TEMPERATURE:
+       if (event == ACPI_THERMAL_NOTIFY_TEMPERATURE) {
                acpi_thermal_check(tz);
-               break;
-       case ACPI_THERMAL_NOTIFY_THRESHOLDS:
+       } else if (event == ACPI_THERMAL_NOTIFY_THRESHOLDS) {
                acpi_thermal_get_trip_points(tz);
                acpi_thermal_check(tz);
                acpi_bus_generate_event(device, event, 0);
-               break;
-       case ACPI_THERMAL_NOTIFY_DEVICES:
+       } else if (event == ACPI_THERMAL_NOTIFY_DEVICES) {
                if (tz->flags.devices)
                        acpi_thermal_get_devices(tz);
                acpi_bus_generate_event(device, event, 0);
-               break;
-       default:
+       } else {
                ACPI_DEBUG_PRINT((ACPI_DB_INFO,
                        "Unsupported event [0x%x]\n", event));
-               break;
        }

$ size *.o
   text    data     bss     dec     hex filename
   5996     704      16    6716    1a3c thermal-multiple-if.o
   6005     704      16    6725    1a45 thermal-switch.o

Here's the asm diff between the two versions:

-       cmpl    $129, %esi
-       je      .L597
-       cmpl    $129, %esi
-       ja      .L602
-       addl    $-128, %esi
-       je      .L596
-       jmp     .L592
-.L602:
-       cmpl    $130, %esi
-       je      .L598
-       jmp     .L592
-.L596:
+       cmpl    $128, %esi
+       jne     .L595
 ...
-.L597:
+.L595:
+       cmpl    $129, %esi
+       jne     .L597
 ...
-.L598:
+.L597:
+       cmpl    $130, %esi
+       jne     .L592

The other diffs are just label numbers changing.  Given that gcc was
instructed to optimise for space (full command line:

gcc -Wp,-MD,drivers/acpi/.thermal.o.d -nostdinc -iwithprefix include \
	-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall \
	-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing \
	-fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 \
	-Iinclude/asm-i386/mach-default -fomit-frame-pointer  -Os   \
	-DKBUILD_BASENAME=thermal -DKBUILD_MODNAME=thermal -c \
	-o drivers/acpi/thermal.o drivers/acpi/thermal.c

I think it should choose the more space-efficient approach.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
