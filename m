From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: Tree for December 10
Date: Wed, 10 Dec 2008 14:52:26 -0800
Message-ID: <20081210145226.8a174e68.akpm@linux-foundation.org>
References: <20081210164659.9ebb8158.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20081210164659.9ebb8158.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-acpi@vger.kernel.org

On Wed, 10 Dec 2008 16:46:59 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
> (patches at
> http://www.kernel.org/pub/linux/kernel/people/sfr/linux-next/)

This tree breaks poweroff on my x86_64 test box.  `halt -pfn' does all
the usual things, but the machine doesn't turn off.

config: http://userweb.kernel.org/~akpm/config-akpm2.txt
dmesg: http://userweb.kernel.org/~akpm/dmesg-akpm2.txt

Any suggestions which don't include the word "bisect" would be most welcome.
