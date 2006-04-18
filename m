From: "Garry T. Williams" <gtwilliams@gmail.com>
Subject: Re: acpi function test suite 0.1 and test results
Date: Tue, 18 Apr 2006 08:53:42 -0400
Message-ID: <200604180853.42649.gtwilliams@gmail.com>
References: <D352FD896397D04482B87731BD4DBE7F411331@bjsmsx401nb>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WFOREgKFCNqIHCm"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.229]:63090 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750705AbWDRMxw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Apr 2006 08:53:52 -0400
Received: by wproxy.gmail.com with SMTP id 68so1095634wri
        for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 05:53:49 -0700 (PDT)
In-Reply-To: <D352FD896397D04482B87731BD4DBE7F411331@bjsmsx401nb>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Ling L" <ling.l.yu@intel.com>
Cc: linux-acpi@vger.kernel.org, "Zhang, Kexin" <kexin.zhang@intel.com>, "Luo, Zhenlin" <zhenlin.luo@intel.com>

--Boundary-00=_WFOREgKFCNqIHCm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 18 April 2006 00:53, Yu, Ling L wrote:

> Could you use root to run again and send me the screen output again?

Well, I decided to try to capture some information on this failure.  So 
I shut down all my applications and tried again as root.  This time 
there was no hang -- the tests ran to completion.  I did run an update 
from Fedora update repositories before trying again.  This installed 
several updates to GNOME.  Probably not related, but who knows?  
<shrug>

Anyway, here's the output of the abat tests.

I now note that the tests apparently left my machine in a throttled 
state.  Everything was running slower than usual.  Instead of 
investigating that, I simply shut down and rebooted since I had to get 
off to work.  If you would like additional information about this, I 
can try again tonight.

-- 
Garry T. Williams --- +1 678 656-4579

--Boundary-00=_WFOREgKFCNqIHCm
Content-Type: text/plain;
  charset="iso-8859-1";
  name="abat.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="abat.out"

ACPI ABAT started...

Fedora Core release 5 (Bordeaux)
Kernel \r on an \m

Linux tfr 2.6.16-1.2080_FC5 #1 Tue Mar 28 03:38:34 EST 2006 i686 i686
i386 GNU/Linux



*******************************************************
*           Test ACPI file system interfaces          *
*******************************************************

-------------------------------------------------------
ACPI is supported.
-------------------------------------------------------
version:    20060127
-------------------------------------------------------
alarm       2006-04-00  00:00:00
event       OK
dsdt        OK
fadt        OK
sleep       mem(S3) disk(S4)
wakeup      Not set
-------------------------------------------------------
Driver      State       Device      Item         Information
------      -----       ------      ----         -----------
ac          loaded      NO
battery     loaded      NO
button      loaded      lid/LID0    info         type: Lid Switch
                                    state        state: open
                        power/PWRB  info         type: Power Button
(CM)
                        power/PWRF  info         type: Power Button
(FF)
ec          build-in    NO
fan         build-in    NO
power       build-in    NO
processor   build-in    NO
thermal     build-in    NO
video       loaded      GFX0        DOS          DOS setting: <1>
                                    POST         <not supported>
                                    POST_info    <not supported>
                                    ROM          <TODO>
                                    info         Switching heads: yes
                                                 Video ROM: yes
                                                 Device to be POSTed
on boot:
                                                    no
                        GFX0/CRT    EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0100
                                                 type: CRT
                                                 known by bios: no
                                    state        state: 0x1d
                                                 query: 0x00
                        GFX0/DVI    EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0320
                                                 type: UNKNOWN
                                                 known by bios: no
                                    state        state: 0x1d
                                                 query: 0x00
                        GFX0/LCD    EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0410
                                                 type: UNKNOWN
                                                 known by bios: no
                                    state        state: 0x1f
                                                 query: 0x00
                        GFX0/TV     EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0240
                                                 type: UNKNOWN
                                                 known by bios: no
                                    state        state: 0x1d
                                                 query: 0x00
                        NGFX        DOS          DOS setting: <1>
                                    POST         <not supported>
                                    POST_info    <not supported>
                                    ROM          <TODO>
                                    info         Switching heads: yes
                                                 Video ROM: no
                                                 Device to be POSTed
on boot:
                                                    no
                        NGFX/CRT    EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0100
                                                 type: CRT
                                                 known by bios: no
                                    state        state: 0x0d
                                                 query: 0x00
                        NGFX/DVI    EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0111
                                                 type: UNKNOWN
                                                 known by bios: no
                                    state        state: 0x0d
                                                 query: 0x00
                        NGFX/LCD    EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0118
                                                 type: UNKNOWN
                                                 known by bios: no
                                    state        state: 0x0f
                                                 query: 0x00
                        NGFX/TV     EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0200
                                                 type: TVOUT
                                                 known by bios: no
                                    state        state: 0x0d
                                                 query: 0x00
-------------------------------------------------------

-------------
Test Summary:
-------------
TOTAL: 17
PASS:  17
FAIL:  0
NOTSUPPORT: 0
UNRESOLVED: 0
UNTESTED:   0
-------------



*******************************************************
*           Test ACPI drivers                         *
*******************************************************

-------------------------------------------------------
Driver      State       Action      Results
ac          loaded      verifying   PASS
                        unloading   PASS
                        verifying   PASS
                        loading     PASS
                        verifying   PASS
battery     loaded      verifying   PASS
                        unloading   PASS
                        verifying   PASS
                        loading     PASS
                        verifying   PASS
button      loaded      verifying   PASS
                        unloading   PASS
                        verifying   PASS
                        loading     PASS
                        verifying   PASS
ec          build-in    verifying   PASS
fan         build-in    verifying   PASS
power       build-in    verifying   PASS
processor   build-in    verifying   PASS
thermal     build-in    verifying   PASS
video       loaded      verifying   PASS
                        unloading   PASS
                        verifying   PASS
                        loading     PASS
                        verifying   PASS
container   notsupport
memhotplug  notsupport
numa        notsupport
-------------------------------------------------------


-------------
Test Summary:
-------------
TOTAL: 12
PASS:  9
FAIL:  0
NOTSUPPORT: 3
UNRESOLVED: 0
UNTESTED:   0
-------------




*******************************************************
*           Test ACPI P-state                         *
*******************************************************


Native Geyserville III Support (P state) - Demand Based Switching
###############################################################################
                 GV3/DBS validation for I386 and EM64T
        Geyserville III is an efficient mechanism for switching
to/from low
        voltage mode - Enhanced SpeedStep Technology. Dependent upon
ACPI.
-------------------------------------------------------------------------------
Fedora Core release 5 (Bordeaux)
Kernel \r on an \m
Linux tfr 2.6.16-1.2080_FC5 #1 Tue Mar 28 03:38:34 EST 2006 i686 i686
i386 GNU/Linux
-------------------------------------------------------------------------------
Start setup
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx est tm2
modprobe cpufreq_powersave
modprobe cpufreq_ondemand
The service cpuspeed should be stopped before running tests
Stopping cpuspeed:                                         [  OK  ]
../tmp/system_update_info:
modprobe -r cpufreq_powersave
modprobe -r cpufreq_ondemand
/etc/init.d/cpuspeed restart
Finish setup
Execution of test_1_1
get_governors output:
ondemand powersave userspace performance
num CPU = 0
READ_GOVERNOR performance
MAX_FREQ 1600000
READ_FREQ 1600000
Test p_states_test_1_1  PASSED
Execution of test_2_1
get_governors output:
ondemand powersave userspace performance
num CPU = 0
READ_GOVERNOR powersave
MIN_FREQ 800000
READ_FREQ 800000
Test p_states_test_2_1  PASSED
Execution of test_3_1
get_governors output:
ondemand powersave userspace performance
num CPU = 0
READ_GOVERNOR userspace
Test p_states_test_3_1  PASSED
Execution of test_3_2
get_governors output:
ondemand powersave userspace performance
num CPU = 0
READ_GOVERNOR userspace
AVLBL_FREQS 1600000 1333000 1067000 800000
READ_FREQ 1600000
READ_FREQ 1333000
READ_FREQ 1067000
READ_FREQ 800000
Test p_states_test_3_2  PASSED
Execution of test_4_1
get_governors output:
ondemand powersave userspace performance
num CPU = 0
READ_GOVERNOR ondemand
Test p_states_test_4_1  PASSED
Execution of test_4_2
get_governors output:
ondemand powersave userspace performance
num CPU = 0
READ_GOVERNOR ondemand
MIN_FREQ 800000
READ_FREQ 800000
Test p_states_test_4_2  PASSED
Execution of test_4_3
get_governors output:
ondemand powersave userspace performance
num CPU = 0
READ_GOVERNOR ondemand
MAX_FREQ 1600000
READ_FREQ 1600000
Test p_states_test_4_3  PASSED
Execution of test_4_4
get_governors output:
ondemand powersave userspace performance
TMP_FILE_PID:
27788
num CPU = 0
READ_GOVERNOR ondemand
MAX_FREQ 1600000
MIN_FREQ 800000
READ_FREQ 1600000
Test _test_4_4   PASSED
Start cleanup
modprobe -r cpufreq_powersave
modprobe -r cpufreq_ondemand
FATAL: Module cpufreq_ondemand is in use.
modprobe -r cpufreq_ondemand: return code 1
Do attempt to change governor
module to be removed ondemand
available governors - ondemand userspace performance
set_governor userspace
modprobe -r cpufreq_ondemand
OK
/etc/init.d/cpuspeed restart
Starting cpuspeed: [  OK  ]
Finish cleanup

Native Geyserville III Support (P state) - Demand Based Switching
###############################################################################
                 GV3/DBS validation for I386 and EM64T
        Geyserville III is an efficient mechanism for switching
to/from low
        voltage mode - Enhanced SpeedStep Technology. Dependent upon
ACPI.
-------------------------------------------------------------------------------
Fedora Core release 5 (Bordeaux)
Kernel \r on an \m
Linux tfr 2.6.16-1.2080_FC5 #1 Tue Mar 28 03:38:34 EST 2006 i686 i686
i386 GNU/Linux
-------------------------------------------------------------------------------
Details:
--------
p_states_test_1_1       PASSED
p_states_test_2_1       PASSED
p_states_test_3_1       PASSED
p_states_test_3_2       PASSED
p_states_test_4_1       PASSED
p_states_test_4_2       PASSED
p_states_test_4_3       PASSED
p_states_test_4_4       PASSED

Test Summary:
-------------
TOTAL:          8
PASS:           8
FAIL:           0
NOTSUPPORT:     0
UNRESOLVED:     0
UNTESTED:       0
###########################################################


Test report is in
/home/garry/tmp/acpi-test-0.1/ABAT/p_states/log/results/test_report,
log file in /home/garry/tmp/acpi-test-0.1/ABAT/p_states/log/stdout



*******************************************************
*           Test ACPI C-states                        *
*******************************************************


Start to test ...

Test 1 ...
CONFIG_ACPI=y
CONFIG_ACPI_PROCESSOR=y

test C-state support on CPU0 ............
CPU0 supports C2
max_cstate=C8

Test2 ...

test C-state switch on CPU0 ............
Current State: C2, Usage: 00319872
CPU0 supports C2
Current State: C2, Usage: 00320170
test CPU0: PASS


------------
Test Summary:
-------------
TOTAL: 2
PASS:  2
FAIL:  0
NOTSUPPORT: 0
UNRESOLVED: 0
UNTESTED:   0
-------------




*******************************************************
*           Test ACPI T-states                        *
*******************************************************

Start to test ...

Test1 ...
CONFIG_ACPI=y
CONFIG_ACPI_PROCESSOR=y
test T-state support on CPU0 ............
T state count = 8
T0: supported
T1: supported
T2: supported
T3: supported
T4: supported
T5: supported
T6: supported
T7: supported
test CPU0: PASS

Test2 ...
test T-state function on CPU0 ............
T state count = 8
set T0 on CPU0 ...
Current CPU0 throttling state T0: 0%
set T1 on CPU0 ...
Current CPU0 throttling state T1: 2%
set T2 on CPU0 ...
Current CPU0 throttling state T2: 12%
set T3 on CPU0 ...
Current CPU0 throttling state T3: 28%
set T4 on CPU0 ...
Current CPU0 throttling state T4: 44%
set T5 on CPU0 ...
Current CPU0 throttling state T5: 60%
set T6 on CPU0 ...
Current CPU0 throttling state T6: 76%
set T7 on CPU0 ...
Current CPU0 throttling state T7: 92%
test CPU0: PASS

Test3 ...
test T-state function on CPU0 ............
T state count = 8
Set P0:T0 on CPU0 ...
Current CPU0 throttling state T0: 0%
Set P0:T1 on CPU0 ...
Current CPU0 throttling state T1: 23%
Set P0:T2 on CPU0 ...
Current CPU0 throttling state T2: 30%
Set P0:T3 on CPU0 ...
Current CPU0 throttling state T3: 42%
Set P0:T4 on CPU0 ...
Current CPU0 throttling state T4: 57%
Set P0:T5 on CPU0 ...
Current CPU0 throttling state T5: 67%
Set P0:T6 on CPU0 ...
Current CPU0 throttling state T6: 81%
Set P0:T7 on CPU0 ...
Current CPU0 throttling state T7: 94%
test CPU0: PASS


------------
Test Summary:
-------------
TOTAL: 3
PASS:  3
FAIL:  0
NOTSUPPORT: 0
UNRESOLVED: 0
UNTESTED:   0
-------------


ACPI ABAT finished...

--Boundary-00=_WFOREgKFCNqIHCm--
