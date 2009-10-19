From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH v3 1/6] ACPI: dock: convert sysfs attributes to an
	attribute_group
Date: Mon, 19 Oct 2009 13:36:15 -0600
Message-ID: <20091019193615.GC23948@ldl.fc.hp.com>
References: <20091016211323.12126.58457.stgit@bob.kio> <20091016211459.12126.60739.stgit@bob.kio> <20091018071630.GC3935@core.coreip.homeip.net> <20091019172138.GB23948@ldl.fc.hp.com> <20091019175616.GA20992@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:26803 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755731AbZJSTgL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Oct 2009 15:36:11 -0400
Content-Disposition: inline
In-Reply-To: <20091019175616.GA20992@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: lenb@kernel.org, shaohua.li@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> 
> If sysfs_create_group() fails you will go to err_unregister:
> which will try to remove the non-existing group. While the
> current sysfs code is relsilient against such errors it may not
> be so in the future. It is better to have a separate label and
> bypass sysfs_remove_group() if sysfs_create_group() returned
> error.

Yeah, you're right. I was trying to be lazy (everyone else is
doing it!), but I guess you won't let me. ;)

I'll respin.

Thanks for the review.

/ac

