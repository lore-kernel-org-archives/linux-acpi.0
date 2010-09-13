From: Ike Panhc <ike.pan@canonical.com>
Subject: intel_idle
Date: Mon, 13 Sep 2010 16:25:51 +0800
Message-ID: <4C8DE00F.7070801@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I test myself which says when CONFIG_CPU_IDLE=y, Lenovo ideapad S10-3 can
not boot. The CPU is Atom N450, and I also find the report[2] that says intel_idle
works fine with N450.

I do not have much knowledge about intel_idle. is there any similar report that on
some machine intel_idle halt the system or any suggestion for next step debug?


[1] http://launchpad.net/bugs/634702
[2] http://www.spinics.net/lists/linux-pm/msg21334.html
