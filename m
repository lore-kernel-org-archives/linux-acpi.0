From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Patch] acpi: introduce "acpi_addr=" parameter for kdump
Date: Mon, 21 Mar 2011 01:05:04 -0700
Message-ID: <m1hbawkifj.fsf@fess.ebiederm.org>
References: <1299766243-494-1-git-send-email-amwang@redhat.com>
	<20110310143923.GB29464@redhat.com> <m1oc5ig90b.fsf@fess.ebiederm.org>
	<20110310185019.GB23105@srcf.ucam.org> <4D86F2C2.9080707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D86F2C2.9080707@redhat.com> (Cong Wang's message of "Mon, 21
	Mar 2011 14:40:02 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Cong Wang <amwang@redhat.com>
Cc: Matthew Garrett <mjg@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org, Takao Indoh <tindoh@redhat.com>, Randy Dunlap <rdunlap@xenotime.net>, Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-acpi@vger.kernel.org

Cong Wang <amwang@redhat.com> writes:

> Eric, any comments?

You have my Nack.

We are doing stupid and unnecessary things, that cause us problems with
EFI.  If we stop doing those stupid and unnecessary things we won't have
problems.

So I don't see the point of adding more stupid and unnecessary work, so
we can continue to do stupid and unnecessary things and cause ourselves
problems.

Eric
