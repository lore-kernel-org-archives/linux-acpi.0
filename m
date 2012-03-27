From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] ACPI: Implement overriding of arbitrary ACPI tables via
 initrd
Date: Mon, 26 Mar 2012 21:15:28 -0700
Message-ID: <4F713EE0.7000009@zytor.com>
References: <1332512984-79664-1-git-send-email-trenn@suse.de> <201203261619.31766.trenn@suse.de> <4F70812A.4080205@zytor.com> <201203261651.29640.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:34805 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947Ab2C0EQN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Mar 2012 00:16:13 -0400
In-Reply-To: <201203261651.29640.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: eric.piel@tremplin-utc.net, vojcek@tlen.pl, dsdt@gaugusch.at, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Lin Ming <ming.m.lin@intel.com>, lenb@kernel.org, robert.moore@intel.com, Al Viro <viro@zeniv.linux.org.uk>, Borislav Petkov <bp@amd64.org>

For what it's worth, I'm starting a git tree for this work at:

git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-earlyinitramfs.git

	-hpa
