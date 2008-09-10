From: Zhao Yakui <yakui.zhao@intel.com>
Subject: the errors about two EC patches
Date: Wed, 10 Sep 2008 16:51:33 +0800
Message-ID: <1221036693.3989.175.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50119 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbYIJIg6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Sep 2008 04:36:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, andi@firstfloor.org, rui.zhang@intel.com

Hi, Len
    
    The patch named acpi-ec-dont-degrade-to-poll-mode-at-storm-automatically is 
included by 2.6.27-rc5-mm1 tree. In fact this patch can't fix the problem of 
bug 11089 & 10724. 
    >Not all users of semi-broken EC devices want to degrade to poll mode, so
give them right to choose.
    >This fixes a regression in 2.6.26 (from 2.6.25.3).  Initially reported as
"Asus Eee PC hotkeys stop working if pressed quickly" in bugzilla
<http://bugzilla.kernel.org/show_bug.cgi?id=11089>.

    At the same time the content in the patch is totally discarded by the 
following patch in ACPI test git tree:
>commit 50c0f43ff1199bbea5f0418d40df32f4d4029b13
>Author: Andi Kleen <ak@linux.intel.com>
>Date:   Thu Sep 4 15:13:29 2008 +0200

    >ACPI: EC: do transaction from interrupt context

   In the above patch there exist the following problems:
   a. In the following code the GPE_STORM bit will always be set regardless 
of whether there exists the EC GPE storm.
    >if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
    >            /* check if we received SCI during transaction */
    >           ec_check_sci(ec, acpi_ec_read_status(ec));
    >           /* it is safe to enable GPE outside of transaction */
    >            acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
    >    } else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
    >               atomic_read(&ec->irq_count) > ACPI_EC_STORM_THRESHOLD)
    >           pr_debug(PREFIX "GPE storm detected\n");
    >           set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
    b. When EC GPE storm is detected, the EC GPE will be disabled and 
EC will work in polling mode while doing EC transaction. In such case 
maybe EC transaction is not finished. But when timeout happens, it 
will still be regarded as finishing the EC transaction. 
       This error is related with the following source code:
           > {
           >    delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY); 
 //Maybe the preemptible schedule happens here.If the current jiffies
 is greater than the predefined jiffies after the process is returned 
from preempt_schedule, OS will have no opportunity to do the EC transaction.
 It means that EC transaction is not finished. But it is still regarded as 
finishing EC transaction. It is incorrect.
           >     while (time_before(jiffies, delay)) {
            >            gpe_transaction(ec, acpi_ec_read_status(ec));
            >            msleep(1);
//as msleep is realized by using the function of schedule_timeout, 
maybe the current jiffies is already greater than the predefined jiffies 
before finishing EC transaction. In such case the EC transaction is
not finished. But it is also regarded as finishing. It is incorrect.
            >            if (ec_transaction_done(ec))
            >                    goto end;
            >    }
     c. There is no detailed change log although a lot is changed.(
Including the EC work mode, the detect mechanism of EC GPE storm). 
It is not easy to understand.     

     At the same time this commit can't handle the EC notification
event in the following case:
         EC GPE Interrupt storm is detected and EC GPE will be disabled
when doing EC transaction. If EC notification event happens while doing
EC transaction(EC GPE is disabled), the SCI_EVT bit of EC status
register is cleared before OS issuing query command. In such case the EC
notification event will be lost.

  Based on the above analysis ,IMO the two patches are not appropriate.

Best regards.
    Yakui


