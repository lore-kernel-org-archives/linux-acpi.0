From: Len Brown <lenb@kernel.org>
Subject: Re: [2.6.25-rc5-mm1] BUG: spinlock bad magic early during boot
Date: Mon, 17 Mar 2008 13:48:13 -0400
Message-ID: <200803171348.13417.lenb@kernel.org>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org> <1205530551.8167.20.camel@nimitz.home.sr71.net> <47DB013D.3060102@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754638AbYCQSEt@vger.kernel.org>
In-Reply-To: <47DB013D.3060102@tremplin-utc.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Piel <eric.piel@tremplin-utc.net>
Cc: Dave Hansen <haveblue@us.ibm.com>, Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>, Markus Gaugusch <dsdt@gaugusch.at>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> We used to have 
> a different way but it was even uglier: append the DSDT after the 
> initramfs, and then access it _directly_. This implies teaching 
> populate_rootfs() to not panic when seeing DSDTs and loosing the benefit 
> of the compression.

DSDT's are generally 4KB to 64KB, so I don't think compression
for a DSDT override is important.

-Len
