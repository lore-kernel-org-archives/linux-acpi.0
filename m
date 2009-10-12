From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 4/6] ACPI: dock: add struct dock_station * directly to
	platform device data
Date: Mon, 12 Oct 2009 11:17:29 -0600
Message-ID: <20091012171729.GB8636@ldl.fc.hp.com>
References: <20091007220509.15597.65501.stgit@bob.kio> <20091007220747.15597.90592.stgit@bob.kio> <20091010075230.GA7473@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932155AbZJLRSI@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091010075230.GA7473@sli10-desk.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Len,

* Shaohua Li <shaohua.li@intel.com>:
> 
> This patch isn't good. platform_device_add_data will malloc a new
> 'struct dock_station' and copy old to it, and later the two copy aren't
> consistent. So NACK this one.

If you can drop this patch without requiring a respin from me, go
ahead.

If you can't, go ahead and drop what you need, and I'll respin.

I'm going to chew on this a bit and see if I can still salvage
it.

> ACK other 5 patches.

Thanks, Shaohua.

/ac
