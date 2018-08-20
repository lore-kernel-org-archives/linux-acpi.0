From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Regression: 18996f2db918 ("ACPICA: Events: Stop unconditionally
 clearing ACPI IRQs during suspend/resume" breaks resume from suspend
Date: Mon, 20 Aug 2018 18:29:06 +0200
Message-ID: <20180820182906.48f7743f@kitsune.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Erik Schmauss <erik.schmauss@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: linux-acpi@vger.kernel.org

Hello,

after commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
clearing ACPI IRQs during suspend/resume") I am no longer able to
resume from suspend.

Reported in bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=200841

Reverting this on top of 4.18 fixes the issue. acpidump output is
attaches in the bugzilla.

Is there anything else that can be done to diagnose the issue?

Thanks

Michal
