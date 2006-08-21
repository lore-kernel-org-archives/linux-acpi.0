From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] acpi: ec_transaction(), second try
Date: Mon, 21 Aug 2006 15:52:58 -0700
Message-ID: <20060821155258.21bebc10.akpm@osdl.org>
References: <20060820222759.GA5369@curacao>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751284AbWHUWxG@vger.kernel.org>
In-Reply-To: <20060820222759.GA5369@curacao>
Sender: linux-kernel-owner@vger.kernel.org
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 21 Aug 2006 00:27:59 +0200
Lennart Poettering <mzxreary@0pointer.de> wrote:

> This is the second version of my patch which unifies the logic of
> ec_read() and ec_write() into ec_transaction(). Most things I wrote
> about the first version are still true:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115517205307700&w=2
> 
> The changes are:
> 
> - Updated for Kernel 2.6.18pre (Linus' GIT tree as of today)
> 
> - Fix a bad argument validity check in acpi_ec_poll_transaction() as
>   pointed out by Yu Luming.
> 
> - I unified the code in acpi_ec_poll_transaction() and
>   acpi_ec_intr_transaction() a little more. Both functions are now just
>   wrappers around the new acpi_ec_transaction_unlocked() function. The
>   latter contains the EC access logic, the two original
>   function now just do their special way of locking and call the the
>   new function for the actual work.
> 
> This patch is required for my MSI laptop support patch.
> 
> Based on Linus' GIT tree and should also apply to the current ACPI
> tree. 

This isn't a suitable description of this work.  Please review
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, especially section
4 and then send (and maintain) a new changelog, thanks.
