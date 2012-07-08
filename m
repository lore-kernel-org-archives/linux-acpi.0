From: "Octavio Alvarez" <alvarezp@alvarezp.com>
Subject: Re: Bug#680707: [3.4-rc5 -> 3.4-rc6 regression] Asus P5NSLI: lockup
 on resume from suspend
Date: Sun, 08 Jul 2012 02:46:47 -0700
Message-ID: <op.wg4f33nl6g6bxc@localhost.localdomain>
References: <op.wg3en6ij6g6bxc@localhost.localdomain>
 <Pine.LNX.4.44L0.1207072208270.508-100000@netrider.rowland.org>
 <20120708025730.GE2961@burratino> <op.wg30yabp6g6bxc@localhost.localdomain>
 <20120708090432.GF4625@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from spider.alvarezp.com ([207.210.217.159]:56700 "EHLO
	spider.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab2GHJra (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Jul 2012 05:47:30 -0400
In-Reply-To: <20120708090432.GF4625@burratino>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>, 680707@bugs.debian.org
Cc: Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

On Sun, 08 Jul 2012 02:04:32 -0700, Jonathan Nieder <jrnieder@gmail.com>  
wrote:

> So presumably it's the new writes to the ACPI_BITREG_ARB_DISABLE
> register that cause trouble.  The patch below tests that guess.

Given the complexity of the ACPI_DEBUG logging (particularly the
console part), I decided to give your patch a shot directly.

Result: the system no longer locks up. I paste the following info
so you can make sure I'm working with the correct commit:

[Sun Jul 08 02:41:37 -0700 -- alvarezp@octavio:~/src/linux]
$ git status
# Not currently on any branch.
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working  
directory)
#
#	modified:   drivers/acpi/acpica/hwsleep.c
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	arch/x86/tools/relocs
no changes added to commit (use "git add" and/or "git commit -a")

[Sun Jul 08 02:41:41 -0700 -- alvarezp@octavio:~/src/linux]
$ git log HEAD^..HEAD
commit 2feec47d4c5f80b05f1650f5a24865718978eea4
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Feb 14 15:00:53 2012 +0800

     ACPICA: ACPI 5: Support for new FADT SleepStatus, SleepControl  
registers

     Adds sleep and wake support for systems with these registers.
     One new file, hwxfsleep.c

     Signed-off-by: Bob Moore <robert.moore@intel.com>
     Signed-off-by: Len Brown <len.brown@intel.com>

[Sun Jul 08 02:41:49 -0700 -- alvarezp@octavio:~/src/linux]
$ git diff
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 59a2a6b..66dd2b8 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -241,18 +241,6 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
                 return_ACPI_STATUS(status);
         }

-       if (sleep_state != ACPI_STATE_S5) {
-               /*
-                * Disable BM arbitration. This feature is contained  
within an
-                * optional register (PM2 Control), so ignore a BAD_ADDRESS
-                * exception.
-                */
-               status = acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE,  
1);
-               if (ACPI_FAILURE(status) && (status != AE_BAD_ADDRESS)) {
-                       return_ACPI_STATUS(status);
-               }
-       }
-
         /*
          * 1) Disable/Clear all GPEs
          * 2) Enable all wakeup GPEs
@@ -498,16 +486,6 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
                                     [ACPI_EVENT_POWER_BUTTON].
                                     status_register_id, ACPI_CLEAR_STATUS);

-       /*
-        * Enable BM arbitration. This feature is contained within an
-        * optional register (PM2 Control), so ignore a BAD_ADDRESS
-        * exception.
-        */
-       status = acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 0);
-       if (ACPI_FAILURE(status) && (status != AE_BAD_ADDRESS)) {
-               return_ACPI_STATUS(status);
-       }
-
         acpi_hw_execute_SST(ACPI_SST_WORKING);
         return_ACPI_STATUS(status);
  }


> Now for a complaint.  This would have been a lot easier if cleanups
> that do not change behavior were split into separate commits --- one
> commit per change.  That makes it easy to verify that each patch
> correctly does what it promises with no unintended side effects.

I have to back you up on this one. This patch could have been 3 easily.
Git bisect would have done a better job.

The question is: if he had dont it that way, would the kernel have
compiled in intermediate commits?

> diff --git i/drivers/acpi/acpica/hwsleep.c  
> w/drivers/acpi/acpica/hwsleep.c
> index 0ed85cac3231..615996a36bed 100644
> --- i/drivers/acpi/acpica/hwsleep.c
> +++ w/drivers/acpi/acpica/hwsleep.c
> @@ -95,18 +95,6 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state, u8  
> flags)
>  		return_ACPI_STATUS(status);
>  	}
> -	if (sleep_state != ACPI_STATE_S5) {
> -		/*
> -		 * Disable BM arbitration. This feature is contained within an
> -		 * optional register (PM2 Control), so ignore a BAD_ADDRESS
> -		 * exception.
> -		 */
> -		status = acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 1);
> -		if (ACPI_FAILURE(status) && (status != AE_BAD_ADDRESS)) {
> -			return_ACPI_STATUS(status);
> -		}
> -	}
> -
>  	/*
>  	 * 1) Disable/Clear all GPEs
>  	 * 2) Enable all wakeup GPEs
> @@ -364,16 +352,6 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state, u8  
> flags)
>  				    [ACPI_EVENT_POWER_BUTTON].
>  				    status_register_id, ACPI_CLEAR_STATUS);
> -	/*
> -	 * Enable BM arbitration. This feature is contained within an
> -	 * optional register (PM2 Control), so ignore a BAD_ADDRESS
> -	 * exception.
> -	 */
> -	status = acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 0);
> -	if (ACPI_FAILURE(status) && (status != AE_BAD_ADDRESS)) {
> -		return_ACPI_STATUS(status);
> -	}
> -
>  	acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST, ACPI_SST_WORKING);
>  	return_ACPI_STATUS(status);
>  }

Thanks for the patch.

-- 
Octavio.
