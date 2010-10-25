From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 44/60] ACPI, APEI, Add ERST record ID cache
Date: Mon, 25 Oct 2010 10:56:08 +0200
Message-ID: <20101025085608.GA3496@elte.hu>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
 <3ab532b764169a551caffc4f3ea550538091449e.1287987547.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:56036 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856Ab0JYI4b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Oct 2010 04:56:31 -0400
Content-Disposition: inline
In-Reply-To: <3ab532b764169a551caffc4f3ea550538091449e.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux@elte.hu, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <petkovbb@googlemail.com>, Don Zickus <dzickus@redhat.com>


* Len Brown <lenb@kernel.org> wrote:

> From: Huang Ying <ying.huang@intel.com>
> 
> APEI ERST firmware interface and implementation has no multiple users
> in mind. For example, there is four records in storage with ID: 1, 2,
> 3 and 4, if two ERST readers enumerate the records via
> GET_NEXT_RECORD_ID as follow,
> 
> reader 1		reader 2
> 1
> 			2
> 3
> 			4
> -1
> 			-1
> 
> where -1 signals there is no more record ID.
> 
> Reader 1 has no chance to check record 2 and 4, while reader 2 has no
> chance to check record 1 and 3. And any other GET_NEXT_RECORD_ID will
> return -1, that is, other readers will has no chance to check any
> record even they are not cleared by anyone.
> 
> This makes raw GET_NEXT_RECORD_ID not suitable for usage of multiple
> users.
> 
> To solve the issue, an in memory ERST record ID cache is designed and
> implemented. When enumerating record ID, the ID returned by
> GET_NEXT_RECORD_ID is added into cache in addition to be returned to
> caller. So other readers can check the cache to get all record ID
> available.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/kernel/cpu/mcheck/mce-apei.c |   42 ++++---
>  drivers/acpi/apei/erst-dbg.c          |   24 +++-
>  drivers/acpi/apei/erst.c              |  241 +++++++++++++++++++++++++++------
>  include/acpi/apei.h                   |    5 +-
>  4 files changed, 247 insertions(+), 65 deletions(-)

NAK on similar grounds.

The code here is exporting all sorts of lowlevel hw error event details to 
user-space, in a vendor specific form, without _ANY_ effort whatsoever at 
generalizing it, merging it with the existing EDAC code, extending EDAC so that both 
can offer similar functionality, etc. etc.

And before you say that "it's for debug only": the direction of these patches 
suggests that this exported data will be used by user-space as an ad-hoc event 
interface, resulting in a de-facto ABI later on.

(Or if it will not be used by user-space then it should not be merged upstream.)

There's EDAC code that tries to do all this correctly, there was even an RFC 
user-space EDAC tool posted recently that uses the perf syscall to receive error 
events, etc. This code goes into debugfs and adds Yet Another Random ABI instead of 
using (or extending) existing facilities of structured event logging.

NAKed-by: Ingo Molnar <mingo@elte.hu>

Thanks,

	Ingo
