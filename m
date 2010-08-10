From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for August 10 (acpi/apei)
Date: Tue, 10 Aug 2010 10:02:28 -0700
Message-ID: <20100810100228.525d952e.randy.dunlap@oracle.com>
References: <20100810135601.4777e310.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100810135601.4777e310.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 10 Aug 2010 13:56:01 +1000 Stephen Rothwell wrote:

> Hi all,
> 
> As the merge window is open, please do not add 2.6.37 material to your
> linux-next included trees until after 2.6.36-rc1.
> 
> Changes since 20100809:


on 32-bit i386:

drivers/acpi/apei/erst-dbg.c:106: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'ssize_t'
erst-dbg.c:(.text+0xede6d): undefined reference to `__get_user_X'

For the __get_user_X() call, in erst-dbg.c::erst_dbg_ioctl():

	case APEI_ERST_CLEAR_RECORD:
		rc = get_user(record_id, (u64 __user *)arg);

-> arch/x86/include/asm/uaccess.h:

#ifdef CONFIG_X86_32
#define __get_user_8(__ret_gu, __val_gu, ptr)				\
		__get_user_x(X, __ret_gu, __val_gu, ptr)
#else
#define __get_user_8(__ret_gu, __val_gu, ptr)				\
		__get_user_x(8, __ret_gu, __val_gu, ptr)
#endif


so is __get_user_8() not supported on X86_32?
or is this something else?


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
