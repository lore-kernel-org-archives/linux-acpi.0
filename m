From: Mattia Dongili <malattia@linux.it>
Subject: EC notifications not dispatched?
Date: Tue, 1 May 2007 13:50:38 +0900
Message-ID: <20070501045038.GA6940@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:52581 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035AbXEAEut (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 May 2007 00:50:49 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Peter Meerwald <pmeerw@pmeerw.net>

Hello,

some new Vaio models are notifing hotkeys to the SNC device through the
EC (dsdt snippet[1]):

Device (EC)
{       
    Name (_HID, EisaId ("PNP0C09"))
    ...
    Name (HF5P, 0x85)
    Name (HF5R, 0x05)
    ...
    Method (_Q50, 0, NotSerialized)
    {
	P8XH (Zero, 0x50)
	SECR (HF5P)
	Notify (SNC, 0x92)
    }   
	
    Method (_Q51, 0, NotSerialized)
    {   
	P8XH (Zero, 0x51)
	SECR (HF5R)
	Notify (SNC, 0x92)
    }
...
}
and a kernel log[2] while pressing FnF5 with
/proc/acpi/debug_layer=0xFFFF0004
/proc/acpi/debug_level=0xffffffff
is appended below. I would expect to find some traces of the _Q50/_Q51
evaluation and sequent notification. And yes, sony-laptop (which handles
the SNC) registers a notify_handler (line 771 in current code) this way:

	acpi_install_notify_handler(sony_nc_acpi_handle,
                                             ACPI_DEVICE_NOTIFY,
                                             sony_acpi_notify, NULL);

any clues why I don't get anything from that?
BTW: I'm Cc-ing one such vaio owner so that he can help answering some
questions if necessary.

[1]: full DSDT -> http://www.linux.it/~malattia/sony-laptop/DSDT.c1s.dsl
[2]: full dmesg -> http://www.linux.it/~malattia/logs/pressing-Fn5-Fn6-full.txt

Thanks,
Mattia

[  370.581379] **** Context Switch from TID C18F0A30 to TID DFF955B0 ****
[  370.581381] 
[  370.581387]   evmisc-0432 [DFF955B0] [14] ev_acquire_global_lock: ----Entry
[  370.581397]   evmisc-0460 [DFF955B0] [14] ev_acquire_global_lock: Acquired hardware Global Lock
[  370.581407]   evmisc-0463 [DFF955B0] [14] ev_acquire_global_lock: ----Exit- AE_OK
[  370.581417] evregion-0300 [DFF955B0] [16] ev_address_space_dispa: ----Entry
[  370.581428] evregion-0399 [DFF955B0] [16] ev_address_space_dispa: Handler c19057a4 (@c01f0f13) Address 0000000000000000 [EmbeddedControl]
[  370.581444] evxfevnt-0256 [DFF955B0] [17] enable_gpe            : ----Entry
[  370.581454]    evgpe-0183 [DFF955B0] [18] ev_enable_gpe         : ----Entry
[  370.581464]    evgpe-0118 [DFF955B0] [19] ev_update_gpe_enable_m: ----Entry
[  370.581474]    evgpe-0160 [DFF955B0] [19] ev_update_gpe_enable_m: ----Exit- AE_OK
[  370.581488]    evgpe-0230 [DFF955B0] [18] ev_enable_gpe         : ----Exit- AE_OK
[  370.581498] evxfevnt-0283 [DFF955B0] [17] enable_gpe            : ----Exit- AE_OK
[  370.581729] 
[  370.581730] **** Context Switch from TID DFF955B0 to TID C031A3C0 ****
[  370.581732] 
[  370.581736]    evsci-0072 [C031A3C0] [17] ev_sci_xrupt_handler  : ----Entry
[  370.581750]  evevent-0249 [C031A3C0] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.581768]    evgpe-0445 [C031A3C0] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.581783]    evgpe-0445 [C031A3C0] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.581798]    evgpe-0445 [C031A3C0] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.581810]    evgpe-0620 [C031A3C0] [18] ev_gpe_dispatch       : ----Entry
[  370.581824]    evgpe-0722 [C031A3C0] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.581840]    evgpe-0445 [C031A3C0] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.581852]    evsci-0091 [C031A3C0] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.581868]    evsci-0072 [C031A3C0] [17] ev_sci_xrupt_handler  : ----Entry
[  370.581884]  evevent-0249 [C031A3C0] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.581900]    evgpe-0445 [C031A3C0] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.581915]    evgpe-0445 [C031A3C0] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.581931]    evgpe-0445 [C031A3C0] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.581943]    evgpe-0620 [C031A3C0] [18] ev_gpe_dispatch       : ----Entry
[  370.581957]    evgpe-0722 [C031A3C0] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.581971]    evgpe-0445 [C031A3C0] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.581982]    evsci-0091 [C031A3C0] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.582437]    evsci-0072 [C031A3C0] [17] ev_sci_xrupt_handler  : ----Entry
[  370.582454]  evevent-0249 [C031A3C0] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.582470]    evgpe-0445 [C031A3C0] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.582486]    evgpe-0445 [C031A3C0] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.582502]    evgpe-0445 [C031A3C0] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.582514]    evgpe-0620 [C031A3C0] [18] ev_gpe_dispatch       : ----Entry
[  370.582529]    evgpe-0722 [C031A3C0] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.582543]    evgpe-0445 [C031A3C0] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.582554]    evsci-0091 [C031A3C0] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.582584] 
[  370.582585] **** Context Switch from TID C031A3C0 to TID DFF955B0 ****
[  370.582588] 
[  370.582591] evregion-0432 [DFF955B0] [16] ev_address_space_dispa: ----Exit- AE_OK
[  370.582604]   evmisc-0499 [DFF955B0] [14] ev_release_global_lock: ----Entry
[  370.582613]   evmisc-0526 [DFF955B0] [14] ev_release_global_lock: Released hardware Global Lock
[  370.582623]   evmisc-0534 [DFF955B0] [14] ev_release_global_lock: ----Exit- AE_OK
[  370.582734]    utils-0287 [DFF955B0] [02] evaluate_integer      : Return value [1]
[  370.587707]   evmisc-0432 [DFF955B0] [14] ev_acquire_global_lock: ----Entry
[  370.587717]   evmisc-0460 [DFF955B0] [14] ev_acquire_global_lock: Acquired hardware Global Lock
[  370.587728]   evmisc-0463 [DFF955B0] [14] ev_acquire_global_lock: ----Exit- AE_OK
[  370.587738] evregion-0300 [DFF955B0] [16] ev_address_space_dispa: ----Entry
[  370.587748] evregion-0399 [DFF955B0] [16] ev_address_space_dispa: Handler c19057a4 (@c01f0f13) Address 0000000000000001 [EmbeddedControl]
[  370.587764] evxfevnt-0256 [DFF955B0] [17] enable_gpe            : ----Entry
[  370.587773]    evgpe-0183 [DFF955B0] [18] ev_enable_gpe         : ----Entry
[  370.587784]    evgpe-0118 [DFF955B0] [19] ev_update_gpe_enable_m: ----Entry
[  370.587794]    evgpe-0160 [DFF955B0] [19] ev_update_gpe_enable_m: ----Exit- AE_OK
[  370.587807]    evgpe-0230 [DFF955B0] [18] ev_enable_gpe         : ----Exit- AE_OK
[  370.587816] evxfevnt-0283 [DFF955B0] [17] enable_gpe            : ----Exit- AE_OK
[  370.588146] 
[  370.588147] **** Context Switch from TID DFF955B0 to TID DFFC4570 ****
[  370.588150] 
[  370.588154]    evsci-0072 [DFFC4570] [17] ev_sci_xrupt_handler  : ----Entry
[  370.588167]  evevent-0249 [DFFC4570] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.588184]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.588200]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.588215]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.588229]    evgpe-0620 [DFFC4570] [18] ev_gpe_dispatch       : ----Entry
[  370.588242]    evgpe-0722 [DFFC4570] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.588256]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.588269]    evsci-0091 [DFFC4570] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.588531] 
[  370.588532] **** Context Switch from TID DFFC4570 to TID DFF53AB0 ****
[  370.588535] 
[  370.588539]    evsci-0072 [DFF53AB0] [17] ev_sci_xrupt_handler  : ----Entry
[  370.588553]  evevent-0249 [DFF53AB0] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.588569]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.588585]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.588601]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.588613]    evgpe-0620 [DFF53AB0] [18] ev_gpe_dispatch       : ----Entry
[  370.588626]    evgpe-0722 [DFF53AB0] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.588641]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.588653]    evsci-0091 [DFF53AB0] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.588691] 
[  370.588692] **** Context Switch from TID DFF53AB0 to TID DFF955B0 ****
[  370.588695] 
[  370.588698] evregion-0432 [DFF955B0] [16] ev_address_space_dispa: ----Exit- AE_OK
[  370.588708]   evmisc-0499 [DFF955B0] [14] ev_release_global_lock: ----Entry
[  370.588718]   evmisc-0526 [DFF955B0] [14] ev_release_global_lock: Released hardware Global Lock
[  370.588728]   evmisc-0534 [DFF955B0] [14] ev_release_global_lock: ----Exit- AE_OK
[  370.588788]   evmisc-0432 [DFF955B0] [14] ev_acquire_global_lock: ----Entry
[  370.588798]   evmisc-0460 [DFF955B0] [14] ev_acquire_global_lock: Acquired hardware Global Lock
[  370.588807]   evmisc-0463 [DFF955B0] [14] ev_acquire_global_lock: ----Exit- AE_OK
[  370.588818] evregion-0300 [DFF955B0] [16] ev_address_space_dispa: ----Entry
[  370.588828] evregion-0399 [DFF955B0] [16] ev_address_space_dispa: Handler c19057a4 (@c01f0f13) Address 0000000000000000 [EmbeddedControl]
[  370.588843] evxfevnt-0256 [DFF955B0] [17] enable_gpe            : ----Entry
[  370.588853]    evgpe-0183 [DFF955B0] [18] ev_enable_gpe         : ----Entry
[  370.588862]    evgpe-0118 [DFF955B0] [19] ev_update_gpe_enable_m: ----Entry
[  370.588872]    evgpe-0160 [DFF955B0] [19] ev_update_gpe_enable_m: ----Exit- AE_OK
[  370.588885]    evgpe-0230 [DFF955B0] [18] ev_enable_gpe         : ----Exit- AE_OK
[  370.588896] evxfevnt-0283 [DFF955B0] [17] enable_gpe            : ----Exit- AE_OK
[  370.589112] 
[  370.589113] **** Context Switch from TID DFF955B0 to TID DFFC4570 ****
[  370.589116] 
[  370.589119]    evsci-0072 [DFFC4570] [17] ev_sci_xrupt_handler  : ----Entry
[  370.589133]  evevent-0249 [DFFC4570] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.589150]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.589165]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.589181]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.589194]    evgpe-0620 [DFFC4570] [18] ev_gpe_dispatch       : ----Entry
[  370.589208]    evgpe-0722 [DFFC4570] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.589222]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.589234]    evsci-0091 [DFFC4570] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.589250] 
[  370.589252] **** Context Switch from TID DFFC4570 to TID DFF955B0 ****
[  370.589254] 
[  370.589259]    evsci-0072 [DFF955B0] [17] ev_sci_xrupt_handler  : ----Entry
[  370.589273]  evevent-0249 [DFF955B0] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.589289]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.589305]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.589321]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.589333]    evgpe-0620 [DFF955B0] [18] ev_gpe_dispatch       : ----Entry
[  370.589345]    evgpe-0722 [DFF955B0] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.589359]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.589371]    evsci-0091 [DFF955B0] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.589607] 
[  370.589608] **** Context Switch from TID DFF955B0 to TID DFFC4570 ****
[  370.589611] 
[  370.589615]    evsci-0072 [DFFC4570] [17] ev_sci_xrupt_handler  : ----Entry
[  370.589628]  evevent-0249 [DFFC4570] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.589644]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.589659]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.589676]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.589688]    evgpe-0620 [DFFC4570] [18] ev_gpe_dispatch       : ----Entry
[  370.589702]    evgpe-0722 [DFFC4570] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.589716]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.589728]    evsci-0091 [DFFC4570] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.589747] 
[  370.589748] **** Context Switch from TID DFFC4570 to TID DFF955B0 ****
[  370.589750] 
[  370.589754]    evsci-0072 [DFF955B0] [17] ev_sci_xrupt_handler  : ----Entry
[  370.589767]  evevent-0249 [DFF955B0] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.589782]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.589798]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.589814]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.589827]    evgpe-0620 [DFF955B0] [18] ev_gpe_dispatch       : ----Entry
[  370.589841]    evgpe-0722 [DFF955B0] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.589855]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.589867]    evsci-0091 [DFF955B0] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.589883] evregion-0432 [DFF955B0] [16] ev_address_space_dispa: ----Exit- AE_OK
[  370.589893]   evmisc-0499 [DFF955B0] [14] ev_release_global_lock: ----Entry
[  370.589902]   evmisc-0526 [DFF955B0] [14] ev_release_global_lock: Released hardware Global Lock
[  370.589913]   evmisc-0534 [DFF955B0] [14] ev_release_global_lock: ----Exit- AE_OK
[  370.590034] evregion-0300 [DFF955B0] [19] ev_address_space_dispa: ----Entry
[  370.590045] evregion-0399 [DFF955B0] [19] ev_address_space_dispa: Handler c18ee27c (@c01da149) Address 0000000000000072 [SystemIO]
[  370.590061] evregion-0432 [DFF955B0] [19] ev_address_space_dispa: ----Exit- AE_OK
[  370.590072] evregion-0300 [DFF955B0] [18] ev_address_space_dispa: ----Entry
[  370.590082] evregion-0399 [DFF955B0] [18] ev_address_space_dispa: Handler c18ee27c (@c01da149) Address 0000000000000073 [SystemIO]
[  370.590097] evregion-0432 [DFF955B0] [18] ev_address_space_dispa: ----Exit- AE_OK
[  370.590156]   evmisc-0432 [DFF955B0] [14] ev_acquire_global_lock: ----Entry
[  370.590167]   evmisc-0460 [DFF955B0] [14] ev_acquire_global_lock: Acquired hardware Global Lock
[  370.590177]   evmisc-0463 [DFF955B0] [14] ev_acquire_global_lock: ----Exit- AE_OK
[  370.590187] evregion-0300 [DFF955B0] [16] ev_address_space_dispa: ----Entry
[  370.590197] evregion-0399 [DFF955B0] [16] ev_address_space_dispa: Handler c19057a4 (@c01f0f13) Address 0000000000000035 [EmbeddedControl]
[  370.590210] evxfevnt-0256 [DFF955B0] [17] enable_gpe            : ----Entry
[  370.590220]    evgpe-0183 [DFF955B0] [18] ev_enable_gpe         : ----Entry
[  370.590231]    evgpe-0118 [DFF955B0] [19] ev_update_gpe_enable_m: ----Entry
[  370.590240]    evgpe-0160 [DFF955B0] [19] ev_update_gpe_enable_m: ----Exit- AE_OK
[  370.590253]    evgpe-0230 [DFF955B0] [18] ev_enable_gpe         : ----Exit- AE_OK
[  370.590263] evxfevnt-0283 [DFF955B0] [17] enable_gpe            : ----Exit- AE_OK
[  370.590494] 
[  370.590496] **** Context Switch from TID DFF955B0 to TID DFF53AB0 ****
[  370.590498] 
[  370.590502]    evsci-0072 [DFF53AB0] [17] ev_sci_xrupt_handler  : ----Entry
[  370.590515]  evevent-0249 [DFF53AB0] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.590531]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.590546]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.590562]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.590574]    evgpe-0620 [DFF53AB0] [18] ev_gpe_dispatch       : ----Entry
[  370.590588]    evgpe-0722 [DFF53AB0] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.590602]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.590613]    evsci-0091 [DFF53AB0] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.590629]    evsci-0072 [DFF53AB0] [17] ev_sci_xrupt_handler  : ----Entry
[  370.590642]  evevent-0249 [DFF53AB0] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.590658]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.590673]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.590689]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.590702]    evgpe-0620 [DFF53AB0] [18] ev_gpe_dispatch       : ----Entry
[  370.590715]    evgpe-0722 [DFF53AB0] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.590728]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.590740]    evsci-0091 [DFF53AB0] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.591108] 
[  370.591110] **** Context Switch from TID DFF53AB0 to TID DFFC4570 ****
[  370.591112] 
[  370.591116]    evsci-0072 [DFFC4570] [17] ev_sci_xrupt_handler  : ----Entry
[  370.591130]  evevent-0249 [DFFC4570] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.591146]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.591161]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.591176]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.591188]    evgpe-0620 [DFFC4570] [18] ev_gpe_dispatch       : ----Entry
[  370.591203]    evgpe-0722 [DFFC4570] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.591217]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.591228]    evsci-0091 [DFFC4570] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.591245] 
[  370.591247] **** Context Switch from TID DFFC4570 to TID DFF955B0 ****
[  370.591249] 
[  370.591253]    evsci-0072 [DFF955B0] [17] ev_sci_xrupt_handler  : ----Entry
[  370.591266]  evevent-0249 [DFF955B0] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.591282]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.591297]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.591312]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.591324]    evgpe-0620 [DFF955B0] [18] ev_gpe_dispatch       : ----Entry
[  370.591337]    evgpe-0722 [DFF955B0] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.591352]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.591364]    evsci-0091 [DFF955B0] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.591378] evregion-0432 [DFF955B0] [16] ev_address_space_dispa: ----Exit- AE_OK
[  370.591389]   evmisc-0499 [DFF955B0] [14] ev_release_global_lock: ----Entry
[  370.591399]   evmisc-0526 [DFF955B0] [14] ev_release_global_lock: Released hardware Global Lock
[  370.591410]   evmisc-0534 [DFF955B0] [14] ev_release_global_lock: ----Exit- AE_OK
[  370.591495] evregion-0300 [DFF955B0] [19] ev_address_space_dispa: ----Entry
[  370.591504] evregion-0399 [DFF955B0] [19] ev_address_space_dispa: Handler c18ee27c (@c01da149) Address 0000000000000072 [SystemIO]
[  370.591520] evregion-0432 [DFF955B0] [19] ev_address_space_dispa: ----Exit- AE_OK
[  370.591532] evregion-0300 [DFF955B0] [18] ev_address_space_dispa: ----Entry
[  370.591541] evregion-0399 [DFF955B0] [18] ev_address_space_dispa: Handler c18ee27c (@c01da149) Address 0000000000000073 [SystemIO]
[  370.591558] evregion-0432 [DFF955B0] [18] ev_address_space_dispa: ----Exit- AE_OK
[  370.591612]   evmisc-0432 [DFF955B0] [14] ev_acquire_global_lock: ----Entry
[  370.591622]   evmisc-0460 [DFF955B0] [14] ev_acquire_global_lock: Acquired hardware Global Lock
[  370.591632]   evmisc-0463 [DFF955B0] [14] ev_acquire_global_lock: ----Exit- AE_OK
[  370.591641] evregion-0300 [DFF955B0] [16] ev_address_space_dispa: ----Entry
[  370.591652] evregion-0399 [DFF955B0] [16] ev_address_space_dispa: Handler c19057a4 (@c01f0f13) Address 000000000000002F [EmbeddedControl]
[  370.591667] evxfevnt-0256 [DFF955B0] [17] enable_gpe            : ----Entry
[  370.591676]    evgpe-0183 [DFF955B0] [18] ev_enable_gpe         : ----Entry
[  370.591688]    evgpe-0118 [DFF955B0] [19] ev_update_gpe_enable_m: ----Entry
[  370.591698]    evgpe-0160 [DFF955B0] [19] ev_update_gpe_enable_m: ----Exit- AE_OK
[  370.591712]    evgpe-0230 [DFF955B0] [18] ev_enable_gpe         : ----Exit- AE_OK
[  370.591721] evxfevnt-0283 [DFF955B0] [17] enable_gpe            : ----Exit- AE_OK
[  370.592025] 
[  370.592027] **** Context Switch from TID DFF955B0 to TID DFF53AB0 ****
[  370.592029] 
[  370.592033]    evsci-0072 [DFF53AB0] [17] ev_sci_xrupt_handler  : ----Entry
[  370.592046]  evevent-0249 [DFF53AB0] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.592063]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.592078]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.592095]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.592107]    evgpe-0620 [DFF53AB0] [18] ev_gpe_dispatch       : ----Entry
[  370.592121]    evgpe-0722 [DFF53AB0] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.592134]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.592147]    evsci-0091 [DFF53AB0] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.592409] 
[  370.592411] **** Context Switch from TID DFF53AB0 to TID DFFC4570 ****
[  370.592414] 
[  370.592418]    evsci-0072 [DFFC4570] [17] ev_sci_xrupt_handler  : ----Entry
[  370.592431]  evevent-0249 [DFFC4570] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.592447]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.592462]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.592478]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.592490]    evgpe-0620 [DFFC4570] [18] ev_gpe_dispatch       : ----Entry
[  370.592506]    evgpe-0722 [DFFC4570] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.592521]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.592534]    evsci-0091 [DFFC4570] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.592550] 
[  370.592551] **** Context Switch from TID DFFC4570 to TID DFF955B0 ****
[  370.592554] 
[  370.592557]    evsci-0072 [DFF955B0] [17] ev_sci_xrupt_handler  : ----Entry
[  370.592571]  evevent-0249 [DFF955B0] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.592588]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.592604]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.592621]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.592634]    evgpe-0620 [DFF955B0] [18] ev_gpe_dispatch       : ----Entry
[  370.592647]    evgpe-0722 [DFF955B0] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.592661]    evgpe-0445 [DFF955B0] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.592672]    evsci-0091 [DFF955B0] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.592689] evregion-0432 [DFF955B0] [16] ev_address_space_dispa: ----Exit- AE_OK
[  370.592699]   evmisc-0499 [DFF955B0] [14] ev_release_global_lock: ----Entry
[  370.592709]   evmisc-0526 [DFF955B0] [14] ev_release_global_lock: Released hardware Global Lock
[  370.592719]   evmisc-0534 [DFF955B0] [14] ev_release_global_lock: ----Exit- AE_OK
[  370.592798]   evmisc-0432 [DFF955B0] [14] ev_acquire_global_lock: ----Entry
[  370.592808]   evmisc-0460 [DFF955B0] [14] ev_acquire_global_lock: Acquired hardware Global Lock
[  370.592818]   evmisc-0463 [DFF955B0] [14] ev_acquire_global_lock: ----Exit- AE_OK
[  370.592828] evregion-0300 [DFF955B0] [16] ev_address_space_dispa: ----Entry
[  370.592837] evregion-0399 [DFF955B0] [16] ev_address_space_dispa: Handler c19057a4 (@c01f0f13) Address 000000000000002E [EmbeddedControl]
[  370.592852] evxfevnt-0256 [DFF955B0] [17] enable_gpe            : ----Entry
[  370.592863]    evgpe-0183 [DFF955B0] [18] ev_enable_gpe         : ----Entry
[  370.592872]    evgpe-0118 [DFF955B0] [19] ev_update_gpe_enable_m: ----Entry
[  370.592882]    evgpe-0160 [DFF955B0] [19] ev_update_gpe_enable_m: ----Exit- AE_OK
[  370.592894]    evgpe-0230 [DFF955B0] [18] ev_enable_gpe         : ----Exit- AE_OK
[  370.592904] evxfevnt-0283 [DFF955B0] [17] enable_gpe            : ----Exit- AE_OK
[  370.593259] 
[  370.593261] **** Context Switch from TID DFF955B0 to TID DFFC4570 ****
[  370.593263] 
[  370.593267]    evsci-0072 [DFFC4570] [17] ev_sci_xrupt_handler  : ----Entry
[  370.593280]  evevent-0249 [DFFC4570] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.593296]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.593312]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.593328]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.593340]    evgpe-0620 [DFFC4570] [18] ev_gpe_dispatch       : ----Entry
[  370.593356]    evgpe-0722 [DFFC4570] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.593371]    evgpe-0445 [DFFC4570] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.593383]    evsci-0091 [DFFC4570] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.593656] 
[  370.593658] **** Context Switch from TID DFFC4570 to TID DFF53AB0 ****
[  370.593660] 
[  370.593664]    evsci-0072 [DFF53AB0] [17] ev_sci_xrupt_handler  : ----Entry
[  370.593678]  evevent-0249 [DFF53AB0] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.593694]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.593710]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.593726]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.593739]    evgpe-0620 [DFF53AB0] [18] ev_gpe_dispatch       : ----Entry
[  370.593753]    evgpe-0722 [DFF53AB0] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.593767]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.593779]    evsci-0091 [DFF53AB0] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.593795]    evsci-0072 [DFF53AB0] [17] ev_sci_xrupt_handler  : ----Entry
[  370.593809]  evevent-0249 [DFF53AB0] [17] ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000011
[  370.593824]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE0: Status=00, Enable=26
[  370.593839]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE8: Status=00, Enable=00
[  370.593855]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE10: Status=FF, Enable=80
[  370.593867]    evgpe-0620 [DFF53AB0] [18] ev_gpe_dispatch       : ----Entry
[  370.593882]    evgpe-0722 [DFF53AB0] [18] ev_gpe_dispatch       : ----Exit- 0000000000000001
[  370.593897]    evgpe-0445 [DFF53AB0] [17] ev_gpe_detect         : Read GPE Register at GPE18: Status=BE, Enable=40
[  370.593908]    evsci-0091 [DFF53AB0] [17] ev_sci_xrupt_handler  : ----Exit- 0000000000000001
[  370.593942] 
[  370.593944] **** Context Switch from TID DFF53AB0 to TID DFF955B0 ****
[  370.593946] 
[  370.593950] evregion-0432 [DFF955B0] [16] ev_address_space_dispa: ----Exit- AE_OK
[  370.593960]   evmisc-0499 [DFF955B0] [14] ev_release_global_lock: ----Entry
[  370.593969]   evmisc-0526 [DFF955B0] [14] ev_release_global_lock: Released hardware Global Lock
[  370.593979]   evmisc-0534 [DFF955B0] [14] ev_release_global_lock: ----Exit- AE_OK

-- 
mattia
:wq!
