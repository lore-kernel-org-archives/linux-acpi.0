From: Tejun Heo <tj@kernel.org>
Subject: Re: WARNING at kernel/workqueue.c:829 wq_worker_waking_up+0x53/0x70()
Date: Tue, 18 Feb 2014 17:49:07 -0500
Message-ID: <20140218224907.GG31892@mtj.dyndns.org>
References: <20140213124059.GA2908@krava.brq.redhat.com>
 <20140217171900.GB29173@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140217171900.GB29173@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello,

On Mon, Feb 17, 2014 at 06:19:00PM +0100, Oleg Nesterov wrote:
> acpi_processor_set_throttling() plays with set_cpus_allowed_ptr(current),
> this is obviously wrong, and the worker is bound.

Umm... yeah, anything running on workqueues shouldn't be diddling with
cpu affinity.  The function even has /* FIXME: use work_on_cpu() */ in
it.  I suppose it's about time to actually implement that?

Thanks.

-- 
tejun
