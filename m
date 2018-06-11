From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Possible regression caused by commit a192aa923b66a
Date: Mon, 11 Jun 2018 14:26:12 +0800
Message-ID: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, perryhelionsemail@gmail.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

There's a regression report [1] that says commit a192aa923b66a ("ACPI /  
LPSS: Consolidate runtime PM and system sleep handling") is the first bad  
commit.

 From the looks of it, it didn't introduce any behavioral change. So your  
help is appreciated.

[1] https://bugs.launchpad.net/bugs/1774950

Kai-Heng
