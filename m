From: moosotc@gmail.com
Subject: ACPI, software suspend, power consumption, EFI, crashing
Date: Wed, 13 Mar 2019 15:39:36 +0300
Message-ID: <87ftrrosmv.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello,

After a "regular" system update (pacman -Syu) new kernel and firmware
packages were installed on this machine[1] (The exact version of the
kernel/firmware may be a red-herring given sporadic and non bisectable
(at this point) nature of the problem)

The system failed to come up after a reboot though. The machine was
dead, being an EFI box meant that it also was silent as to why (no
console output).

After adding "debug earlyprintk=efi,keep log_buf_len=16M"[2] to the
kernel command line (luckily it's quite easy with rEFInd[3]) it became
apparent that kernel was crashing (at least 2 oopses happened during
boot the second one being fatal)

Several false starts later (i.e. downgrade kernel/firmware) when the
system will _sometimes_ boot) the "real" culprit was identified -
another kernel command line parameter _seems_ to play a crucial role:
an empty acpi_osi (i.e. `acpi_osi=`), with acpi_osi removed from the
command line the system (so far) never failed to reach user-space.

But empty acpi_osi was there for a reason, without it the system
consumes 2 watts more while idling (for background cf. [4]) (That said
the acpi_osi influence on power was noticed by accident and is as
inexplicable as the need to do a one-time suspend to memory to achieve
power consumption on par with macOS on this hardware)

It is also worth pointing out that the crashes are not really
deterministic and _sometimes_ kernel boots even with an empty acpi_osi
being present. The non deterministic nature of failures also means
that there is no good "bisection" point for saying this kernel was
okay and after this point in time things went awry.

---------
Update #1
Having `spectre_v2=off' in the kernel command line:

a. Makes the kernel boot even with an empty acpi_osi
b. Makes the suspend-to-memory "trick" effective again
   (in bringing power consumption down)

Update #2 (12-03-2019)
Turns out `spectre_v2=off' is no panacea, just that when it's there
kernel is more likely to complete booting without a hitch

Open questions
--------------

a. How are `spectre_v2=off' and `acpi_osi=' related? (update #2 makes
   this point moot)

b. (Original question from 2016) Why does one-off (accidentally
   discovered) suspend to RAM have any bearing on power consumption?
   And why is the efficiency of this trick dependant on acpi_osi?

   What exactly is so important in clear acpi_osi? (A hypothesis here
   is that AML does (or doesn`t do something "important") depending on
   the acpi_osi value)

[1] https://manuals.info.apple.com/MANUALS/1000/MA1687/en_US/mac-mini-late2014-qs.pdf
[2] After ~10 minutes of excruciatingly slow video redraws
[3] http://www.rodsbooks.com/refind/
[4] https://lkml.org/lkml/2016/2/12/55

-- 
mailto:moosotc@gmail.com
