From: Ralf Gerbig <rge-8kTjH38Bi09AfugRpC6u6w@public.gmane.org>
Subject: Re: Radeon M7 and resuming from suspend-to-ram
Date: Wed, 19 Jan 2005 21:07:07 +0100
Message-ID: <87ekghkwt0.fsf-news@hsp-law.de>
References: <41E7D334.6060003@sllpilots.fi>
	<1105723866.28126.10.camel@elrond.flymine.org>
	<87k6qal75i.fsf-news@hsp-law.de> <1106095573.7368.29.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1106095573.7368.29.camel@tyrosine> (Matthew Garrett's message
 of "Wed, 19 Jan 2005 00:46:13 +0000")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

* Matthew Garrett writes:
> On Tue, 2005-01-18 at 23:11 +0100, Ralf Gerbig wrote:
>> chvt 1 
>> vbetool vbestate save > /tmp/vbestate
>> 
>> in /usr/lib/poewersave/scripts/prepare_suspend_to_ram and
>> 
>> vbetool vbestate restore < /tmp/vbestate
>> chvt 7
>> 
>> in /usr/lib/poewersave/scripts/restore_after_suspend_to_ram
>> 
>> the LCD becomes alive after suspend to ram.

> Excellent. So far, the best solution we've found is to save the vbestate
> on boot rather than on suspend. There's a small number of machines that
> this hangs on, irritatingly, but I'm trying to track them down. It seems
> far more successful than using video_post for the most part.

Last night I was too dumbfounded that it actually worked to include
any details.

The thing is an Acer Travelmate 380:

rge@lapdog2:~> /sbin/lspci 
0000:00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
0000:00:00.1 System peripheral: Intel Corp. 855GM/GME GMCH Memory I/O Control Registers (rev 02)
0000:00:00.3 System peripheral: Intel Corp. 855GM/GME GMCH Configuration Process Registers (rev 02)
0000:00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integrated Graphics Device (rev 02)
0000:00:02.1 Display controller: Intel Corp. 82852/855GM Integrated Graphics Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03)
0000:02:01.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)
0000:02:09.0 CardBus bridge: Texas Instruments PCI7420 CardBus Controller
0000:02:09.2 FireWire (IEEE 1394): Texas Instruments PCI7x20 1394a-2000 OHCI Two-Port PHY/Link-Layer Controller
0000:02:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)

rge@lapdog2:~> /sbin/lspci -n
0000:00:00.0 Class 0600: 8086:3580 (rev 02)
0000:00:00.1 Class 0880: 8086:3584 (rev 02)
0000:00:00.3 Class 0880: 8086:3585 (rev 02)
0000:00:02.0 Class 0300: 8086:3582 (rev 02)
0000:00:02.1 Class 0380: 8086:3582 (rev 02)
0000:00:1d.0 Class 0c03: 8086:24c2 (rev 03)
0000:00:1d.1 Class 0c03: 8086:24c4 (rev 03)
0000:00:1d.2 Class 0c03: 8086:24c7 (rev 03)
0000:00:1d.7 Class 0c03: 8086:24cd (rev 03)
0000:00:1e.0 Class 0604: 8086:2448 (rev 83)
0000:00:1f.0 Class 0601: 8086:24cc (rev 03)
0000:00:1f.1 Class 0101: 8086:24ca (rev 03)
0000:00:1f.3 Class 0c05: 8086:24c3 (rev 03)
0000:00:1f.5 Class 0401: 8086:24c5 (rev 03)
0000:00:1f.6 Class 0703: 8086:24c6 (rev 03)
0000:02:01.0 Class 0280: 8086:4220 (rev 05)
0000:02:09.0 Class 0607: 104c:ac8e
0000:02:09.2 Class 0c00: 104c:802e
0000:02:0a.0 Class 0200: 10ec:8139 (rev 10)

Kernel is 2.6.11-rc1-mm1, Distribution SuSE 9.2
gcc version 3.3.4 (pre 3.3.5 20040809)

SuSE does not have a shared libpci, only static so the precompiled
binary unsurprisingly did not work.

Compiling the source I got: 

rge@lapdog2:/usr/src/vbetool-0.2> make
if gcc -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" 
-DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" -DPACKAGE=\"vbetool\" 
-DVERSION=\"0.2\"  -I. -I.    
-g -Wall -Werror -pedantic -g -O2 -MT vbetool.o -MD -MP -MF ".deps/vbetool.Tpo" \
  -c -o vbetool.o `test -f 'vbetool.c' || echo './'`vbetool.c; \
then mv -f ".deps/vbetool.Tpo" ".deps/vbetool.Po"; \
else rm -f ".deps/vbetool.Tpo"; exit 1; \
fi
In file included from /usr/include/stdlib.h:416,
                 from vbetool.c:14:
/usr/include/sys/types.h:62: error: conflicting types for `dev_t'
/usr/include/linux/types.h:22: error: previous declaration of `dev_t'
/usr/include/sys/types.h:67: error: conflicting types for `gid_t'
/usr/include/linux/types.h:52: error: previous declaration of `gid_t'
/usr/include/sys/types.h:72: error: conflicting types for `mode_t'
/usr/include/linux/types.h:24: error: previous declaration of `mode_t'
/usr/include/sys/types.h:77: error: conflicting types for `nlink_t'
/usr/include/linux/types.h:25: error: previous declaration of `nlink_t'
/usr/include/sys/types.h:82: error: conflicting types for `uid_t'
/usr/include/linux/types.h:51: error: previous declaration of `uid_t'
In file included from /usr/include/sys/types.h:216,
                 from /usr/include/stdlib.h:416,
                 from vbetool.c:14:
/usr/include/sys/select.h:78: error: conflicting types for `fd_set'
/usr/include/linux/types.h:21: error: previous declaration of `fd_set'

stdlib.h:415-416:

#if defined __USE_SVID || defined __USE_XOPEN_EXTENDED || defined __USE_BSD
# include <sys/types.h>         /* we need int32_t... */ 

after fuzing around with -D, I temporally commented out the
include. Thereafter adding -lpci to the end of the link command, I got
a working executable.

Ralf
-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
