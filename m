From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC] [Patch 0/3]  ACPI : several patches for EC
Date: Wed, 29 Oct 2008 17:45:38 +0800
Message-ID: <1225273538.5189.265.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57334 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224AbYJ2Ji5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Oct 2008 05:38:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Hi, All
 
    Two people report the following warning messages on the 2.6.28-rc2 kernel. 
    >ACPI: EC: missing confirmations, switch off interrupt mode.
    >ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
[EmbeddedControl] [20080926]
    (One happens on Asus EEEPC901. Another happens on HP laptop).
    The detailed info about HP laptop can be found in 
     http://marc.info/?t=122491944100001&r=1&w=2

    After analysis I think that this issue is related with the current EC 
working flowchart in 2.6.28-rc2.
(There is detailed explanation about it after the description of patch set).
    
    The following is the patch set that is to fix the above issue.
    Patch 01: EC transaction is explicitly divided into different phases. 
And EC access is realized in process context. 
    At the same time EC driver will be started in EC GEP mode. And when 
there is no EC GPE confirmation for some EC transaction on some broken laptops,
the EC driver will be switched to polling mode. But EC GPE is still enabled.
    
    Patch 02: Add the 2 us delay before starting check EC status while in 
polling mode
      According to the ACPI spec when the host writes data to the command or data
register of the embedded controller, the input buffer flag (IBF) in the
status register is set within 1 microsecond.  On most laptosp it
is unnecessary to add the delay as EC device is connected with the slow
peripherial bus.
      But it is safe to add the delay of 2 microseconds before starting loop
check the EC status while EC is in polling mode.

    Patch 03: Add some delay  in EC GPE handler to avoid EC interrupt storm on some
broken BIOS.
     The delay won't be added for most laptops.Only when more than five
interrupts happen in the same jiffies and EC status are the same, OS will add
some delay in the EC GPE handler. If the same issue still happens after adding
delay,the delay time will be increased.But the max delay time is ten
microseconds.

    After applying the patch, the problem disappears on ASUS EEEPC901 and HP laptop.

Welcome the comments.


Now the EC transaction will be executed in EC GPE interrupt context on
most laptops.Maybe it is easier. But for the some laptops it can't be
done in EC GPE interrupt context.So it falls back to the EC polling
mode. (For example : when there is no EC interrupt confirm in EC
transaction;EC GPE interrupt storm). And then EC transaction is done in
the function of EC poll. Unfortunately the working flowchart in ec_poll
is not appropriate. So there exists the above warning message on
2.6.28-rc2 kernel.
    Sometimes -ETIME is returned by the function of ec_poll, which
brings the following message:
    AE_TIME, Returned by Handler for [EmbeddedControl] [20080926]
   
   Maybe on some laptops the EC controller will crash if host issues the
next EC command before the previous EC transaction is not finished
because of bogus timeout.
   
Why is ETIME is returned by the function of ec_poll? Please look at the 
source code of ec_poll.
static int ec_poll(struct acpi_ec *ec)
{
        unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
        msleep(1);

//[my comments] Maybe the current jiffies is already after the
predefined jiffies after msleep(1). In such case the ETIME will be
returned. Of course the EC transaction can't be finished. If so, IMO
this is not reasonable as this is caused by that OS has no opportunity
to issue the following EC command sequence.
        while (time_before(jiffies, delay)) {
                gpe_transaction(ec, acpi_ec_read_status(ec));
                msleep(1);
                if (ec_transaction_done(ec))
                        return 0;
//[my comments] Maybe there exists the following cases. EC transaction
is not finished after msleep(1),but the current jiffies is already after
predefined jiffies. So ETIME is returned. In such case, IMO this is also
not reasonable.
        }
        return -ETIME;
}
    At the same time msleep is realized by schedule_timeout. On linux
although one process is waked up by some events, it won't be scheduled
immediately. So maybe the current jiffies is already after the
predefined timeout jiffies  after msleep(1). In such case the ETIME will
be returned by ec_poll. IMO this is unreasonable. 
    
    The reason about ETIME is not caused by that EC controller can't update its 
status in time. Instead it is caused by that host has no opportunity to issue the
sequence operation in the current work flowchart. In current EC work
flowchart the EC transaction is done in a big loop. 
    Maybe the better solution is that the EC transaction is explicitly
divided into several different phases and EC access is still realized in
process context as in the early kernel.


Thanks for the comments.
  Yakui


