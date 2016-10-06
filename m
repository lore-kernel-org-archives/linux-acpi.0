From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Bogus "APIC: NR_CPUS/possible_cpus limit of 4 reached" messages
Date: Thu, 6 Oct 2016 13:27:37 +0200
Message-ID: <20161006112737.GA308@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On current trunk I get during boot:

[    0.000000] APIC: NR_CPUS/possible_cpus limit of 4 reached.  Processor 4/0x84 ignored.
[    0.000000] APIC: NR_CPUS/possible_cpus limit of 4 reached.  Processor 5/0x85 ignored.

I don't think these messages make much sense on a 4-core machine.

-- 
Markus
