From: Zhao Yakui <yakui.zhao@intel.com>
Subject: the errors about the EC patch from Alexey
Date: Wed, 17 Sep 2008 17:02:06 +0800
Message-ID: <1221642126.3999.77.camel@yakui_zhao.sh.intel.com>
References: <1221036693.3989.175.camel@yakui_zhao.sh.intel.com>
	 <48C7BF94.6010204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40335 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbYIQI5Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Sep 2008 04:57:24 -0400
In-Reply-To: <48C7BF94.6010204@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com

Hi, All
    A patch is attached in kernel bugzilla(bug number is  11549), which is to
fix the issue of EC GPE storm.(This patch is from Alexey Starikovskiy)
    The patch is attached in http://bugzilla.kernel.org/show_bug.cgi?id=11549#c1
    Although the bug can be fixed by the patch, there exists the following error about
the synchronization:
     Synchronization about the content of transaction_data(ec->t): 
       The function of gpe_transaction is reenterable. It will be called in 
the two different routines. One is called in ec_gpe_handler(Interrupt context) and
another is called in the function of ec_poll(This is called in acpi_ec_transaction_unlocked).
       The content of transaction_data will be changed/read in the function of gpe_transaction.
             >if (t->wlen > 0) {
              >  if ((status & ACPI_EC_FLAG_IBF) == 0) {
               >         acpi_ec_write_data(ec, *(t->wdata++));
               >         --t->wlen;
       But unfortunately there is no synchronization between the two routines.
       IMO this is incorrect.   
      As there are no protection and synchronization about the content of ec->t, maybe the ec->t 
is assigned to zero while OS is accessing the content of ec->t. In such case maybe the system 
will be crashed. Even when there is no crash, it is still unreasonable as OS will try to access the 
invalid memory.

     At the same time the following source code looks so ugly.
     The address of local variable is assigned to the global pointer variable. Although it won't
break the system, it looks very ugly. 
      >struct transaction_data t = {.wdata = wdata, .rdata = rdata,
                                     .wlen = wdata_len, .rlen = rdata_len};
      >ec->t = &t;
      And the ec->t will be accessed in the function of acpi_ec_gpe_handler(Interrupt context).
      
     
Best regards.
    Yakui


   
   

