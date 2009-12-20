From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 00/11] ACPI: early _PDC eval and unify x86/ia64
Date: Sun, 20 Dec 2009 12:25:17 -0700
Message-ID: <20091220192517.GA2016@ldl.fc.hp.com>
References: <20091220190434.4274.67855.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091220190434.4274.67855.stgit@bob.kio>
Sender: linux-ia64-owner@vger.kernel.org
To: venkatesh.pallipadi@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

* Alex Chiang <achiang@hp.com>:
> It was recently discovered that some BIOS implementations load
> dynamic SSDTs when a processor's _PDC method is evaluated.

D'oh, I knew I'd forget something. Here are some bz references:

	http://bugzilla.kernel.org/show_bug.cgi?id=14824
	http://bugzilla.kernel.org/show_bug.cgi?id=14710

/ac

