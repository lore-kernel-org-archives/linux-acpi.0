From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/4] ACPI 2.0: Enable TermList interpretion for table loading
Date: Wed, 18 May 2016 01:23:09 +0200
Message-ID: <CAJZ5v0gYBKC0GxBpFH-jOca7ide-pGc9R1bfi9PCSZgiB1hSAg@mail.gmail.com>
References: <cover.1463109824.git.lv.zheng@intel.com>
	<1AE640813FDE7649BE1B193DEA596E883BBA2A9A@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBA2A9A@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 17, 2016 at 2:29 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Rafael
>
> Can we queue this up in linux-next?
> ASLTS recursive tests are done in ACPICA upstream and no regressions can be seen.
> We need more tests around this experimental change from the real users to have the chances to learn the unknown cases.
> If they reported regressions, we could stop the regressions by reverting [PATCH 4/4].
> So it should be safe to do such experiments in the Linux upstream.
> Thanks in advance.

There is a rule that during a merge window linux-next should only
contain material for that merge window.  That is, currently linux-next
should only contain material targeted at v4.7.

For this reason, I can't put the series into linux-next right now, but
I'll do that as soon as 4.7-rc1 is released.
