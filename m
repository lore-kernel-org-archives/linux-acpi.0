From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Stable inclusion for commit 36904703aeee
Date: Wed, 7 Mar 2018 17:23:30 +0800
Message-ID: <EAE9DCBC-48EC-4EFA-B481-A24667D5CBEE@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.11\))
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable <stable@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-acpi@vger.kernel.org

Hi Greg,

Please include commit 36904703aeee ("ACPI / bus: Parse tables as term_list  
for Dell XPS 9570 and Precision M5530")
for v4.14+.

This can be backported to older versions, but this system won't function on  
v4.4 or v4.9.
It requires new drivers that don't exist in v4.4 or v4.9.

Thanks!

Kai-Heng
