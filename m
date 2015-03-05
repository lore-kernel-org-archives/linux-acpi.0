From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Unwanted delayed execution of _Qxx EC methods
Date: Thu, 05 Mar 2015 18:20:16 +0100
Message-ID: <1734806.SfTNVcaUUz@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, Mario_Limonciello@dell.com
List-Id: linux-acpi@vger.kernel.org

Hi,

I'd like to report a minor issue I have with the ACPI embedded controller
driver. My laptop (XPS13 9333) has two function keys to control the
screen brightness. When pressed, two _Qxx ACPI methods are called, one
to increase and one to decrease the brightness. Both the methods sleep
for 200ms.

This pause of 200ms is causing some problems when I keep one of the
function keys pressed. In this situation, more queries than needed
are scheduled for a delayed execution, making the screen brightness
change even after the function key is released.

Here below you can see some log lines that show the problem.

If I keep the function key pressed for X seconds, it will take roughly
2X seconds for all the queries to be executed.

Is there any way to prevent this from happening?

Thanks,
Gabriele

[   47.213439] ACPI : EC: ===== IRQ (1) =====
[   47.213455] ACPI : EC: EC_SC(R) = 0x20 SCI_EVT=1 BURST=0 CMD=0 IBF=0 OBF=0
[   47.213458] ACPI : EC: ***** Event started *****
[   47.213509] ACPI : EC: ***** Command(QR_EC) started *****
[   47.213522] ACPI : EC: ===== TASK (1) =====
[   47.213533] ACPI : EC: EC_SC(R) = 0x20 SCI_EVT=1 BURST=0 CMD=0 IBF=0 OBF=0
[   47.213536] ACPI : EC: EC_SC(W) = 0x84
[   47.213544] ACPI : EC: ***** Event stopped *****
[   47.213547] ACPI : EC: ***** Event started *****
[   47.218812] ACPI : EC: ===== TASK (1) =====
[   47.218829] ACPI : EC: EC_SC(R) = 0x2a SCI_EVT=1 BURST=0 CMD=1 IBF=1 OBF=0
[   47.220195] ACPI : EC: ===== IRQ (1) =====
[   47.220212] ACPI : EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
[   47.220219] ACPI : EC: EC_DATA(R) = 0x80
[   47.220222] ACPI : EC: ***** Command(QR_EC) hardware completion *****
[   47.220251] ACPI : EC: ***** Command(QR_EC) stopped *****
[   47.220260] ACPI : EC: ##### Query(0x80) scheduled #####
[   47.220273] ACPI : EC: ***** Command(QR_EC) started *****
[   47.220277] ACPI : EC: ===== TASK (1) =====
[   47.220290] ACPI : EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
[   47.220293] ACPI : EC: ##### Query(0x80) started #####
[   47.220301] ACPI : EC: EC_SC(W) = 0x84
[   47.220308] ACPI : EC: ***** Event stopped *****
[   47.221021] ACPI : EC: ===== IRQ (0) =====
[   47.221037] ACPI : EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
[   47.221045] ACPI : EC: EC_DATA(R) = 0x00
[   47.221048] ACPI : EC: ***** Command(QR_EC) hardware completion *****
[   47.221063] ACPI : EC: ***** Command(QR_EC) stopped *****
[   47.422969] ACPI : EC: ##### Query(0x80) stopped #####
[   47.487914] ACPI : EC: ===== IRQ (1) =====
[   47.487926] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[   47.487928] ACPI : EC: ***** Event started *****
[   47.487962] ACPI : EC: ***** Command(QR_EC) started *****
[   47.487969] ACPI : EC: ===== TASK (1) =====
[   47.487978] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[   47.487981] ACPI : EC: EC_SC(W) = 0x84
[   47.487986] ACPI : EC: ***** Event stopped *****
[   47.487988] ACPI : EC: ***** Event started *****
[   47.488557] ACPI : EC: ===== IRQ (1) =====
[   47.488580] ACPI : EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
[   47.488584] ACPI : EC: EC_DATA(R) = 0x80
[   47.488585] ACPI : EC: ***** Command(QR_EC) hardware completion *****
[   47.488602] ACPI : EC: ***** Command(QR_EC) stopped *****
[   47.488607] ACPI : EC: ##### Query(0x80) scheduled #####
[   47.488613] ACPI : EC: ***** Command(QR_EC) started *****
[   47.488615] ACPI : EC: ===== TASK (1) =====
[   47.488623] ACPI : EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
[   47.488624] ACPI : EC: ##### Query(0x80) started #####
[   47.488628] ACPI : EC: EC_SC(W) = 0x84
[   47.488633] ACPI : EC: ***** Event stopped *****
[   47.490090] ACPI : EC: ===== IRQ (0) =====
[   47.490100] ACPI : EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
[   47.490103] ACPI : EC: EC_DATA(R) = 0x00
[   47.490104] ACPI : EC: ***** Command(QR_EC) hardware completion *****
[   47.490110] ACPI : EC: ***** Command(QR_EC) stopped *****
[   47.577686] ACPI : EC: ===== IRQ (1) =====
[   47.577698] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[   47.577699] ACPI : EC: ***** Event started *****
[   47.577722] ACPI : EC: ***** Command(QR_EC) started *****
[   47.577724] ACPI : EC: ===== TASK (1) =====
[   47.577731] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[   47.577733] ACPI : EC: EC_SC(W) = 0x84
[   47.577736] ACPI : EC: ***** Event stopped *****
[   47.577737] ACPI : EC: ***** Event started *****
[   47.578309] ACPI : EC: ===== IRQ (1) =====
[   47.578315] ACPI : EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
[   47.578319] ACPI : EC: EC_DATA(R) = 0x80
[   47.578320] ACPI : EC: ***** Command(QR_EC) hardware completion *****
[   47.578328] ACPI : EC: ***** Command(QR_EC) stopped *****
[   47.578331] ACPI : EC: ##### Query(0x80) scheduled #####
[   47.578334] ACPI : EC: ***** Command(QR_EC) started *****
[   47.578336] ACPI : EC: ===== TASK (1) =====
[   47.578343] ACPI : EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
[   47.578345] ACPI : EC: EC_SC(W) = 0x84
[   47.578350] ACPI : EC: ***** Event stopped *****
[   47.580030] ACPI : EC: ===== IRQ (1) =====
[   47.580040] ACPI : EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
[   47.580044] ACPI : EC: EC_DATA(R) = 0x00
[   47.580045] ACPI : EC: ***** Command(QR_EC) hardware completion *****
[   47.580063] ACPI : EC: ***** Command(QR_EC) stopped *****
[   47.667627] ACPI : EC: ===== IRQ (1) =====
[   47.667638] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[   47.667640] ACPI : EC: ***** Event started *****
[   47.667669] ACPI : EC: ***** Command(QR_EC) started *****
[   47.667671] ACPI : EC: ===== TASK (1) =====
[   47.667678] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[   47.667680] ACPI : EC: EC_SC(W) = 0x84
[   47.667683] ACPI : EC: ***** Event stopped *****
[   47.667684] ACPI : EC: ***** Event started *****
[   47.668157] ACPI : EC: ===== IRQ (1) =====
[   47.668167] ACPI : EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
[   47.668171] ACPI : EC: EC_DATA(R) = 0x80
[   47.668172] ACPI : EC: ***** Command(QR_EC) hardware completion *****
[   47.668188] ACPI : EC: ***** Command(QR_EC) stopped *****
[   47.668192] ACPI : EC: ##### Query(0x80) scheduled #####
[   47.668198] ACPI : EC: ***** Command(QR_EC) started *****
[   47.668200] ACPI : EC: ===== TASK (1) =====
[   47.668209] ACPI : EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
[   47.668211] ACPI : EC: EC_SC(W) = 0x84
[   47.668216] ACPI : EC: ***** Event stopped *****
[   47.669836] ACPI : EC: ===== IRQ (1) =====
[   47.669847] ACPI : EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
[   47.669850] ACPI : EC: EC_DATA(R) = 0x00
[   47.669852] ACPI : EC: ***** Command(QR_EC) hardware completion *****
[   47.669880] ACPI : EC: ***** Command(QR_EC) stopped *****
[   47.691187] ACPI : EC: ##### Query(0x80) stopped #####
[   47.691192] ACPI : EC: ##### Query(0x80) started #####
[   47.792343] ACPI : EC: ===== IRQ (1) =====
[   47.792355] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[   47.792357] ACPI : EC: ***** Event started *****
[   47.792387] ACPI : EC: ***** Command(QR_EC) started *****
[   47.792389] ACPI : EC: ===== TASK (1) =====
[   47.792396] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[   47.792398] ACPI : EC: EC_SC(W) = 0x84
[   47.792401] ACPI : EC: ***** Event stopped *****
[   47.792405] ACPI : EC: ***** Event started *****
[   47.793445] ACPI : EC: ===== IRQ (1) =====
[   47.793456] ACPI : EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
[   47.793460] ACPI : EC: EC_DATA(R) = 0x80
[   47.793461] ACPI : EC: ***** Command(QR_EC) hardware completion *****
[   47.793480] ACPI : EC: ***** Command(QR_EC) stopped *****
[   47.793485] ACPI : EC: ##### Query(0x80) scheduled #####
[   47.793491] ACPI : EC: ***** Command(QR_EC) started *****
[   47.793493] ACPI : EC: ===== TASK (1) =====
[   47.793501] ACPI : EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
[   47.793504] ACPI : EC: EC_SC(W) = 0x84
[   47.793509] ACPI : EC: ***** Event stopped *****
[   47.794994] ACPI : EC: ===== IRQ (1) =====
[   47.795004] ACPI : EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
[   47.795007] ACPI : EC: EC_DATA(R) = 0x00
[   47.795009] ACPI : EC: ***** Command(QR_EC) hardware completion *****
[   47.795022] ACPI : EC: ***** Command(QR_EC) stopped *****
[   47.882247] ACPI : EC: ===== IRQ (1) =====
[   47.882260] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[   47.882262] ACPI : EC: ***** Event started *****
[   47.882299] ACPI : EC: ***** Command(QR_EC) started *****
[   47.882302] ACPI : EC: ===== TASK (1) =====
[   47.882310] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[   47.882312] ACPI : EC: EC_SC(W) = 0x84
[   47.882318] ACPI : EC: ***** Event stopped *****
[   47.882319] ACPI : EC: ***** Event started *****
[   47.882888] ACPI : EC: ===== IRQ (1) =====
[   47.882896] ACPI : EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
[   47.882900] ACPI : EC: EC_DATA(R) = 0x80
[   47.882901] ACPI : EC: ***** Command(QR_EC) hardware completion *****
[   47.882914] ACPI : EC: ***** Command(QR_EC) stopped *****
[   47.882919] ACPI : EC: ##### Query(0x80) scheduled #####
[   47.882924] ACPI : EC: ***** Command(QR_EC) started *****
[   47.882927] ACPI : EC: ===== TASK (1) =====
[   47.882935] ACPI : EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
[   47.882937] ACPI : EC: EC_SC(W) = 0x84
[   47.882942] ACPI : EC: ***** Event stopped *****
[   47.884614] ACPI : EC: ===== IRQ (1) =====
[   47.884627] ACPI : EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
[   47.884632] ACPI : EC: EC_DATA(R) = 0x00
[   47.884634] ACPI : EC: ***** Command(QR_EC) hardware completion *****
[   47.884655] ACPI : EC: ***** Command(QR_EC) stopped *****
[   47.895378] ACPI : EC: ##### Query(0x80) stopped #####
[   47.895388] ACPI : EC: ##### Query(0x80) started #####
[   48.099496] ACPI : EC: ##### Query(0x80) stopped #####
[   48.099502] ACPI : EC: ##### Query(0x80) started #####
[   48.303660] ACPI : EC: ##### Query(0x80) stopped #####
[   48.303665] ACPI : EC: ##### Query(0x80) started #####
[   48.507823] ACPI : EC: ##### Query(0x80) stopped #####
